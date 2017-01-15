local TJ = LibStub('AceAddon-3.0'):GetAddon('ThousandJabs')
local Core = TJ:GetModule('Core')
local Profiling = TJ:GetModule('Profiling')
local TableCache = TJ:GetModule('TableCache')
local UnitCache = TJ:GetModule('UnitCache')

local GetInventoryItemID = GetInventoryItemID
local getmetatable = getmetatable
local GetSpellCharges = GetSpellCharges
local GetSpellCooldown = GetSpellCooldown
local GetSpellCount = GetSpellCount
local GetTime = GetTime
local mmax = math.max
local mmin = math.min
local pairs = pairs
local pcall = pcall
local rawget = rawget
local select = select
local setfenv = setfenv
local setmetatable = setmetatable
local tconcat = table.concat
local tContains = tContains
local tinsert = table.insert
local tonumber = tonumber
local tostring = tostring
local tsort = table.sort
local type = type
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo
local UnitLevel = UnitLevel
local UnitSpellHaste = UnitSpellHaste
local wipe = wipe

Core:Safety()

local safeTableEntries = {
    'type',
    'tostring',
    'hooks',
    'can_spend',
    'perform_spend',
    'OnStateInit',
    'OnPredictActionAtOffset'
}

local function convertToNumber(n)
    if type(n) == 'number' then
        return n
    elseif type(n) == 'boolean' then
        return n and 1 or 0
    end
    return tonumber(n)
end

local function convertToBoolean(n)
    if type(n) == 'boolean' then
        return n
    elseif type(n) == 'number' then
        return n ~= 0 and true or false
    elseif type(n) == 'string' then
        return n == 'true' and true or false
    end
end

local stateResetDefaults = {
    type = type,
    tostring = tostring,
    N = convertToNumber,
    B = convertToBoolean,
}

local function CreateStateEnvTable(state, profile)
    -- Set up an environment table for calling the condition functions
    local env_base = {}
    for k,v in pairs(Core.Environment.base) do
        env_base[k] = v
    end
    env_base = Core:MissingFieldTable(getmetatable(state).__name..".env", env_base)

    -- Set up a proxy table which correctly calls functions to retrieve data instead
    local env = setmetatable({}, {
        __env_base = env_base,
        __index = function(tbl, idx)
            local env_base = getmetatable(tbl).__env_base
            -- Handle incoming damage queries
            local dmgprefix = "incoming_damage_over_"
            if idx:match(dmgprefix) then
                local val = 0
                local length = tonumber(idx:sub(dmgprefix:len()+1))
                if length >= tbl.time_since_incoming_damage then
                    val = TJ:GetIncomingDamage(GetTime(), length/1000) -- use GetTime() here, as future prediction will change the accumulation window
                end
                return val
            end
            -- Forward to the base table
            local e = env_base[idx]
            if type(e) == 'function' then
                local res = e(tbl, tbl)
                return res
            else
                return e
            end
            return rawget(tbl,idx)
        end
    })

    -- Set up fallback tables for each of the abilities
    for k, v in pairs(profile.actions) do
        if type(v) == 'table' then
            env[k] = setmetatable({}, {
                __env = env,
                __action = v,
                __index = function(tbl, idx)
                    local env = getmetatable(tbl).__env
                    local action = getmetatable(tbl).__action
                    -- Allow raw access to the safe entries, without throwing faults
                    if tContains(safeTableEntries, idx) then
                        return rawget(action, idx)
                    end
                    -- Forward to the profile table
                    local e = action[idx]
                    if type(e) == 'function' then
                        local res = e(tbl, env)
                        return res
                    else
                        return e
                    end
                    return rawget(tbl,idx)
                end
            })
        end
    end

    return env
end

local function PrevGcdTableIndexerPrototype(tbl, idx)
    local gcdcount = getmetatable(tbl).__gcd
    local env = getmetatable(tbl).__env
    local profile = getmetatable(tbl).__profile
    local abilityQueue = TableCache:Acquire()
    for k,v in Core:OrderedPairs(env.abilitiesUsed, function(a,b) return b < a end) do
        local t = rawget(env, v)
        if t and (t.spell_cast_time or TJ.currentGCD) > 0.2 then
            abilityQueue[1+#abilityQueue] = v
        end
    end
    local prev_gcd_ability = abilityQueue[gcdcount] or nil
    TableCache:Release(abilityQueue)
    return prev_gcd_ability and prev_gcd_ability == idx and true or false
end

local function CreatePrevGcdTable(state, profile)
    local prev_gcd = {}
    for i=1,10 do
        prev_gcd[i] = setmetatable({}, { __gcd = i, __env = state.env, __profile = profile, __index = PrevGcdTableIndexerPrototype, })
    end
    return prev_gcd
end

local function CreatePrevOffGcdTable(state, profile)
    local prev_off_gcd = setmetatable({}, {
        __state = state,
        __index = function(tbl, idx)
            local castsOffGCD = getmetatable(tbl).__state.castsOffGCD
            return castsOffGCD[idx] and true or false
        end,
    })
    return prev_off_gcd
end

local function CreateEquippedTable(state, profile)
    local equipped = setmetatable({}, {
        __state = state,
        __env = state.env,
        __profile = profile,
        __index = function(tbl,idx)
            local ae = getmetatable(tbl).__state.actuallyEquipped
            if type(idx) == "number" then
                if tContains(ae, idx) then return true end
            elseif type(idx) == "string" then
                local l = TJ.Generated.EquippedMapping[idx]
                if l then
                    for i=1,#l do
                        if tContains(ae, l[i]) then return true end
                    end
                end
            end
            return false
        end,
    })
    return equipped
end

local function CreateSetBonusTable(state, profile)
    local checks = {}
    for k,v in pairs(TJ.Generated.ItemSets) do
        -- Check that we match all the items in the set, if there's no suffix
        checks[k] = function()
            return (Core:IntersectionCount(v, state.actuallyEquipped) >= #v) and true or false
        end
        -- Loop through and create _2pc to _8pc
        if #v > 2 then
            for c=2,8 do
                if #v >= c then
                    checks[Core:Format("%s_%dpc", k, c)] = function(spell, env)
                        return (Core:IntersectionCount(v, state.actuallyEquipped) >= c) and true or false
                    end
                end
            end
        end
    end

    local set_bonus = setmetatable({}, {
        __checks = checks,
        __index = function(tbl,idx)
            return checks[idx] and checks[idx]() or false
        end,
    })

    return set_bonus
end

-- Helper for cleaning a state
local function StateResetPrototype(self, targetCount)
    local env = self.env
    env.prev_gcd = nil
    env.prev_off_gcd = nil
    env.equipped = nil
    env.lastCastTimes = nil
    env.abilitiesUsed = nil
    env.set_bonus = nil

    self.numTargets = targetCount or self.numTargets

    -- Deep copy over the last cast times for the state so that we're not writing to the global state instead
    wipe(self.abilitiesUsed)
    for k,v in pairs(TJ.abilitiesUsed) do
        self.abilitiesUsed[k] = v
    end
    wipe(self.lastCastTimes)
    for k,v in pairs(TJ.lastCastTimes) do
        self.lastCastTimes[k] = v
    end
    wipe(self.castsOffGCD)
    for k,v in pairs(TJ.castsOffGCD) do
        self.castsOffGCD[k] = v
    end

    -- Work out which items are actually equipped
    wipe(self.actuallyEquipped)
    for i=1,30 do
        local ok, itemid = pcall(GetInventoryItemID, 'player', i)
        if ok and itemid then
            self.actuallyEquipped[1+#self.actuallyEquipped] = itemid
        end
    end
    tsort(self.actuallyEquipped)

    -- Clear out the environment and reset to initial values
    for k,v in pairs(env) do
        if type(v) == 'table' then
            -- Wipe the environment table
            wipe(v)

            -- Get the equivalent profile entry for this table
            local entry = self.profile.actions[k]
            local abilityID = rawget(entry, 'AbilityID')

            -- Add data if we're checking auras for this entry
            if rawget(entry, 'AuraID') then
                local aura = UnitCache:GetAura(entry.AuraUnit, entry.AuraID, entry.AuraMine)
                v.expirationTime = aura and aura.expires or 0
                v.auraCount = aura and aura.count or 0
            end

            -- Add data if we're checking cooldowns for this entry
            if rawget(entry, 'CooldownTime') then
                if abilityID then
                    v.cooldownStart, v.cooldownDuration = GetSpellCooldown(abilityID)
                else
                    v.cooldownStart, v.cooldownDuration = env.CurrentTime, v.CooldownTime
                end
            end

            -- Add data if we're checking charges for this entry
            if rawget(entry, 'RechargeTime') then
                local charges, maxCharges, start, duration
                if abilityID then
                    charges, maxCharges, start, duration = GetSpellCharges(abilityID)
                end
                v.rechargeSampled = charges or 0
                v.rechargeMax = maxCharges or 0
                v.rechargeStartTime = start or 0
                v.rechargeDuration = duration or 0
                v.rechargeSpent = 0
            end

            -- Add data if we're using GetSpellCount to get the number of charges for this ability
            if rawget(entry, 'ChargesUseSpellCount') then
                local charges
                if abilityID then
                    charges = GetSpellCount(abilityID)
                end
                v.rechargeSampled = charges or 0
                v.rechargeMax = 999
                v.rechargeStartTime = 0
                v.rechargeDuration = 0
                v.rechargeSpent = 0
            end
        else
            env[k] = nil
        end
    end

    -- Reset the defaults for the state
    for k,v in pairs(stateResetDefaults) do
        env[k] = v
    end

    -- Set the initial parameters
    env.ptr = false -- Core:MatchesBuild('7.1.5')
    env.sampleTime = GetTime()
    env.active_enemies = self.numTargets
    env.spell_targets = self.numTargets
    env.desired_targets = self.numTargets - 1
    env.playerHasteMultiplier = ( 100 / ( 100 + UnitSpellHaste('player') ) )
    env.player_level = UnitLevel('player')
    env.movement.distance = UnitCache:UnitRange('target')
    env.gcd = mmax(1, TJ.currentGCD * env.playerHasteMultiplier)
    env.gcd_max = mmax(1, TJ.currentGCD * env.playerHasteMultiplier)
    env.in_combat = (TJ.combatStart ~= 0) and true or false

    -- Determine if player/target are casting things
    local pName = (UnitCastingInfo("player") or UnitChannelInfo("player"))
    local pInterruptible = (pName and not (select(9,UnitCastingInfo("player")) or select(8,UnitChannelInfo("player")))) and true or false
    local tName = (UnitCastingInfo("target") or UnitChannelInfo("target"))
    local tInterruptible = (tName and not (select(9,UnitCastingInfo("target")) or select(8,UnitChannelInfo("target")))) and true or false
    local mName = (UnitCastingInfo("pet") or UnitChannelInfo("pet"))
    local mInterruptible = (mName and not (select(9,UnitCastingInfo("pet")) or select(8,UnitChannelInfo("pet")))) and true or false
    env.player.is_casting = pName and true or false
    env.player.casting_spell = pName
    env.player.is_interruptible = pInterruptible
    env.target.is_casting = tName and true or false
    env.target.is_interruptible = tInterruptible
    env.target.casting_spell = tName
    env.pet.is_casting = mName and true or false
    env.pet.is_interruptible = mInterruptible
    env.pet.casting_spell = mName

    -- Reset the prev_gcd/equipped tables
    env.prev_gcd = self.prev_gcd
    env.prev_off_gcd = self.prev_off_gcd
    env.equipped = self.equipped
    env.lastCastTimes = self.lastCastTimes
    env.abilitiesUsed = self.abilitiesUsed
    env.set_bonus = self.set_bonus

    -- Call the current profile's state initialisation function
    local initFunc = env.hooks.OnStateInit
    if initFunc then initFunc(env) end
end

-- Base action prediction for the current time, or just after the current cast finishes
local function StatePredictNextActionPrototype(self)
    local env = self.env

    -- Attempt to work out when we can next cast something, based off the gcd
    local start, duration = GetSpellCooldown(61304)

    -- Set the combat start time
    env.combatStart = (TJ.combatStart ~= 0) and TJ.combatStart or GetTime()

    -- ....unless we're currently casting/channeling something (i.e. fists of fury), in which case use it instead
    local cname, _, _, _, cstart, cend, _, _, _, spellCastID = UnitCastingInfo('player')
    local performPostCastAction = false
    if cname then
        performPostCastAction = true
        Core:Debug("Currently casting: %s", tostring(spellCastID))
    else
        cname, _, _, _, cstart, cend = UnitChannelInfo('player')
    end
    if cname then
        start = cstart * 0.001
        duration = (cend - cstart) * 0.001
    end
    -- Find the sampling offset
    local predictionOffset = mmax(0, (start and duration) and (start + duration - GetTime()) or 0)
    -- Predict at the specific offset
    return self:PredictActionAtOffset(predictionOffset, performPostCastAction and spellCastID or nil)
end

-- Prediction of the action following the one specified, mocing the prediction time accordingly
local function StatePredictActionFollowingPrototype(self, action)
    local env = self.env
    local act = env[action]
    if act then
        if act.AbilityID and act.AbilityID ~= 61304 then -- Don't count the 'wait' ability
            -- Pretend we just casted the supplied action, update the last cast time for this ability
            self.lastCastTimes[act.AbilityID] = env.currentTime
            self.abilitiesUsed[env.currentTime] = action
        end
        -- Perform the cast of the supplied action
        self.profile.actions[action].perform_cast(act, env)
        -- Work out the new prediction offset given its cast time
        local newOffset = env.predictionOffset + act.spell_cast_time
        -- Predict the next action
        return self:PredictActionAtOffset(newOffset)
    end
    return nil
end

-- Prediction at the supplied time offset
local function StatePredictActionAtOffsetPrototype(self, predictionOffset, performPostCastSpellID)
    local env = self.env
    env.predictionOffset = predictionOffset

    if performPostCastSpellID ~= nil then
        Core:Debug("Handling cast of %s", tostring(performPostCastSpellID))
        local action = self.profile:FindActionForSpellID(performPostCastSpellID)
        if action then
            Core:Debug("Handling cast of %s", action)
            local act = env[action]
            if act.AbilityID and act.AbilityID ~= 61304 then -- Don't count the 'wait' ability
                -- Pretend we just casted the supplied action, update the last cast time for this ability
                self.lastCastTimes[act.AbilityID] = env.currentTime
                self.abilitiesUsed[env.currentTime] = action
            end
            -- Perform the cast of the supplied action
            self.profile.actions[action].perform_cast(act, env)

            -- If we have a cast time, then assume we're going to invoke the GCD, wipe out the castsOffGCD table
            if act.spell_cast_time > 0.1 then
                wipe(self.castsOffGCD)
            else
                -- Otherwise, add it to the castsOffGCD table
                self.castsOffGCD[action] = true
            end
        end
    end

    Core:Debug("")
    Core:Debug("|cFFFFCC99Offset: %.3f|r", predictionOffset)
    Core:Debug("|cFFFFFFFFRange: <= %d yd|r", env.movement.distance)

    -- Call the current profile's state initialisation function
    local func = env.hooks.OnPredictActionAtOffset
    if func then func(env) end

    return self:ExecuteActionProfileList("default")
end

-- Execute an action profile list and get the resulting action
local function StateExecuteActionProfileListPrototype(self, listname)
    local env = self.env

    -- Get the requested action list to execute
    local actionList = self.profile.parsedActions[listname]
    if not actionList or #actionList == 0 then
        return nil
    end

    -- Loop through all the actions in the list
    for i=1,#actionList do
        -- Get the action under consideration
        local action = actionList[i]
        if not tContains(self.profile.blacklisted, action.action) then
            -- Show debug information if requested
            if action.params.debug then
                if not action.keywords_printer then
                    local entries = (action.action == "variable" or action.action == "call_action_list" or action.action == "run_action_list")
                        and { }
                        or { Core:Format("\n'|cFFFFFF99%s.spell_can_cast=|cFFFF9900' .. tostring(%s.spell_can_cast)", action.action, action.action) }
                    local keywords = action.params.condition_converted and action.params.condition_converted.keywords
                        or action.params.value_converted and action.params.value_converted.keywords
                        or {}
                    for k,v in pairs(keywords) do
                        entries[1+#entries] = Core:Format("'|cFFFFFF99%s=|cFFFF9900' .. (type(%s) == 'number' and ('%%.2f'):format(%s) or tostring(%s))", v, v, v, v)
                    end
                    local funcsrc = Core:Format("function() return %s end", tconcat(entries, " .. '|r, ' .. "))
                    action.keywords_printer = Core:LoadFunctionString(funcsrc:gsub('THIS_SPELL', action.action), action.key)
                end
                setfenv(action.keywords_printer, env)
                Core:Debug("\n%s|r", action.keywords_printer())
            end

            if action.action == "variable" then
                -- Execute the variable value function with the current state
                setfenv(action.value_func, env)
                local status, ret = pcall(action.value_func)
                -- If we got a failure, then print out in the debugging and console
                if not status then
                    Core:Debug("|cFFFF0000%s (ERROR EXECUTING): %s|r", action.key, action.fullvaluefuncsrc)
                    Core:Error(Core:Format("Error executing variable function:\n------\n%s\n------\n%s\n------", ret, action.fullvaluefuncsrc))
                else
                    -- Update the value
                    env.variable[action.params.name] = ret
                    Core:Debug("|cFFFF99FF%s ==> |cFFDD00FF%s = %s|cFFFF99FF: %s|r", action.key, action.params.name, tostring(ret), action.fullvaluefuncsrc)
                end
                -- Validate that it isn't blacklisted, and there's a valid check function
            elseif action.condition_func then -- We have a valid check function
                -- Execute the check function with the current state
                setfenv(action.condition_func, env)
                local status, ret = pcall(action.condition_func)
                -- If we got a failure, then print out in the debugging and console
                if not status then
                    Core:Debug("|cFFFF0000%s (ERROR EXECUTING): %s|r", action.key, action.fullconditionfuncsrc)
                    Core:Error(Core:Format("Error executing condition function:\n------\n%s\n------\n%s\n------", ret, action.fullconditionfuncsrc))
                elseif ret == false then
                    -- Ran correctly, but the condition failed...
                    Core:Debug("|r%s: %s", action.key, action.fullconditionfuncsrc)
                elseif ret == true then
                    -- If the condition succeeded....
                    if action.action == 'call_action_list' or action.action == 'run_action_list' then
                        -- ...we're running another action list, so run that recursively
                        Core:Debug("|cFF99FFFF%s ==> '|cFF00DDFF%s|cFF99FFFF': %s|r", action.key, action.params.name, action.fullconditionfuncsrc)
                        local action = self:ExecuteActionProfileList(action.params.name)
                        if action then
                            return action
                        end
                    else
                        -- We have an ability, so send it back
                        Core:Debug("|cFF99FF99%s ==> '|cFF00FF00%s|cFF99FF99': %s|r", action.key, action.action, action.fullconditionfuncsrc)
                        return action.action
                    end
                end
            end
        else
        -- Core:Debug("|cFFCC9999%s (blacklisted): %s|r", action.key, action.fullconditionfuncsrc)
        end

        if action.params.debug then
            Core:Debug("")
        end
    end
end

-- Export the actions table
local function exportVisitor(env, ctx, t)
    local out = {}
    for k,v in pairs(t) do
        local key = ctx and ctx:len() > 0 and Core:Format("%s.%s", ctx, k) or k
        if type(v) == "table" then
            out[k] = exportVisitor(env, key, v)
        elseif type(v) == "function" then
            local funcsrc = Core:Format("function() return %s end", key)
            local func = Core:LoadFunctionString(funcsrc, key)
            setfenv(func, env)
            local ok, ret = pcall(func)
            out[k] = (not ok) and { error = ret } or ret
        else
            out[k] = v
        end
    end

    if out.AbilityID then
        out.AbilityTooltipEntries = {}
        local tooltip = TJ:GetTooltipEntries(Core:Format('spell:%d', out.AbilityID))
        for k,v in pairs(tooltip) do
            tinsert(out.AbilityTooltipEntries, v.t)
        end
        TableCache:Release(tooltip)
    end
    return out
end
local function StateExportActionsTablePrototype(self)
    local env = self.env
    local output = exportVisitor(env, nil, self.profile.actions)
    return output
end

function TJ:CreateNewState(numTargets)

    local profile = TJ:GetActiveProfile()
    if not profile then return end

    -- Set up the state and associate a profile with it
    local state = Core:MissingFieldTable("state{"..profile.name.."}", {
        numTargets = numTargets,
    })

    -- Keep track of the profile, last cast times
    state.profile = profile
    state.abilitiesUsed = {}
    state.lastCastTimes = {}
    state.castsOffGCD = {}
    state.actuallyEquipped = {}

    -- Set up proxy tables
    state.env = CreateStateEnvTable(state, profile)
    state.prev_gcd = CreatePrevGcdTable(state, profile)
    state.prev_off_gcd = CreatePrevOffGcdTable(state, profile)
    state.equipped = CreateEquippedTable(state, profile)
    state.set_bonus = CreateSetBonusTable(state, profile)

    state.Reset = StateResetPrototype
    Profiling:ProfileFunction(state, 'Reset', 'state:Reset')

    -- Base action prediction for the current time, or just after the current cast finishes
    state.PredictNextAction = StatePredictNextActionPrototype
    Profiling:ProfileFunction(state, 'PredictNextAction', 'state:PredictNextAction')

    -- Prediction of the action following the one specified, mocing the prediction time accordingly
    state.PredictActionFollowing = StatePredictActionFollowingPrototype
    Profiling:ProfileFunction(state, 'PredictActionFollowing', 'state:PredictActionFollowing')

    -- Prediction at the supplied time offset
    state.PredictActionAtOffset = StatePredictActionAtOffsetPrototype
    Profiling:ProfileFunction(state, 'PredictActionAtOffset', 'state:PredictActionAtOffset')

    -- Execute an action profile list and get the resulting action
    state.ExecuteActionProfileList = StateExecuteActionProfileListPrototype
    Profiling:ProfileFunction(state, 'ExecuteActionProfileList', 'state:ExecuteActionProfileList')

    -- Export the actions table
    state.ExportActionsTable = StateExportActionsTablePrototype
    Profiling:ProfileFunction(state, 'ExportActionsTable', 'state:ExportActionsTable')

    -- Reset the state by default, populating with initial data
    state:Reset(1)
    return state
end