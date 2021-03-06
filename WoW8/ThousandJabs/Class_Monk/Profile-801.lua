--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BfA only.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if GetBuildInfo and select(4, GetBuildInfo()) < 80000 then
    return
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if select(2, UnitClass('player')) ~= 'MONK' then return end

local addonName, internal = ...
local TJ = LibStub('AceAddon-3.0'):GetAddon('ThousandJabs')
local Core = TJ:GetModule('Core')
local Config = TJ:GetModule('Config')

if not Core:MatchesBuild('8.0.0', '8.0.9') then return end

local mmin = math.min

------------------------------------------------------------------------------------------------------------------------
-- Brewmaster profile definition
------------------------------------------------------------------------------------------------------------------------

-- exported with /tj _esd
local brewmaster_abilities_exported = {
    black_ox_brew = { SpellIDs = { 115399 }, TalentID = 19992, },
    blackout_combo = { TalentID = 22108, },
    blackout_strike = { SpellIDs = { 205523 }, },
    bob_and_weave = { TalentID = 20174, },
    breath_of_fire = { SpellIDs = { 115181 }, },
    brewmasters_balance = { SpellIDs = { 245013 }, },
    celerity = { TalentID = 19304, },
    chi_burst = { SpellIDs = { 123986 }, TalentID = 20185, },
    chi_torpedo = { SpellIDs = { 115008 }, TalentID = 19818, },
    chi_wave = { SpellIDs = { 115098 }, TalentID = 19820, },
    crackling_jade_lightning = { SpellIDs = { 117952 }, },
    dampen_harm = { SpellIDs = { 122278 }, TalentID = 20175, },
    detox = { SpellIDs = { 218164 }, },
    expel_harm = { SpellIDs = { 115072 }, },
    eye_of_the_tiger = { TalentID = 23106, },
    fortifying_brew = { SpellIDs = { 115203 }, },
    gift_of_the_ox = { SpellIDs = { 124502 }, },
    guard = { TalentID = 22104, },
    healing_elixir = { SpellIDs = { 122281 }, TalentID = 23363, },
    high_tolerance = { TalentID = 22106, },
    invoke_niuzao_the_black_ox = { SpellIDs = { 132578 }, TalentID = 22103, },
    ironskin_brew = { SpellIDs = { 115308 }, },
    keg_smash = { SpellIDs = { 121253 }, },
    leg_sweep = { SpellIDs = { 119381 }, },
    light_brewing = { TalentID = 22099, },
    mastery_elusive_brawler = { SpellIDs = { 117906 }, },
    mystic_touch = { SpellIDs = { 8647 }, },
    paralysis = { SpellIDs = { 115078 }, },
    provoke = { SpellIDs = { 115546 }, },
    purifying_brew = { SpellIDs = { 119582 }, },
    resuscitate = { SpellIDs = { 115178 }, },
    ring_of_peace = { SpellIDs = { 116844 }, TalentID = 19995, },
    roll = { SpellIDs = { 109132 }, },
    rushing_jade_wind = { SpellIDs = { 116847 }, TalentID = 20184, },
    spear_hand_strike = { SpellIDs = { 116705 }, },
    special_delivery = { TalentID = 19819, },
    spitfire = { TalentID = 22097, },
    stagger = { SpellIDs = { 115069 }, },
    summon_black_ox_statue = { SpellIDs = { 115315 }, TalentID = 19994, },
    tiger_palm = { SpellIDs = { 100780 }, },
    tiger_tail_sweep = { TalentID = 19993, },
    tigers_lust = { SpellIDs = { 116841 }, TalentID = 19302, },
    transcendence = { SpellIDs = { 101643 }, },
    transcendence_transfer = { SpellIDs = { 119996 }, },
    vivify = { SpellIDs = { 116670 }, },
    zen_flight = { SpellIDs = { 125883 }, },
    zen_meditation = { SpellIDs = { 115176 }, },
}

local function RemoveBlackoutCombo(env)
    -- Remove Blackout Combo
    if env.blackout_combo.talent_enabled then
        env.blackout_combo.expirationTime = 0
    end
end

local brewmaster_base_overrides = {
    blackout_strike = {
        AuraApplied = 'elusive_brawler',
        AuraApplyLength = 10,
    },
    breath_of_fire = {
        PerformCast = function(spell, env)
            RemoveBlackoutCombo(env)
        end
    },
    expel_harm = {
        ChargesUseSpellCount = true,
        PerformCast = function(spell, env)
            spell.rechargeSpent = spell.rechargeSpent + spell.spell_charges
        end,
    },
    fortifying_brew = {
        AuraID = 115203, -- TBD
        AuraMine = true,
        AuraUnit = 'player',
        AuraApplied = 'fortifying_brew',
        AuraApplyLength = 15,
    },
    ironskin_brew = {
        AuraID = 215479,
        AuraUnit = 'player',
        AuraMine = true,
        AuraApplied = 'ironskin_brew',
        AuraApplyLength = 6,

        PerformCast = function(spell,env)
            RemoveBlackoutCombo(env)

            -- Need to also decrement the number of charges for Purifying Brew
            env.purifying_brew.rechargeSpent = env.purifying_brew.rechargeSpent+1
        end,
    },
    keg_smash = {
        AuraID = 121253,
        AuraUnit = 'target',
        AuraMine = true,
        AuraApplied = 'keg_smash',
        AuraApplyLength = 15,
        PerformCast = function(spell, env)
            RemoveBlackoutCombo(env)
        end
    },
    leg_sweep = {
        AuraID = 119381,
        AuraMine = true,
        AuraUnit = 'target',
        AuraApplied = 'leg_sweep',
        AuraApplyLength = 3,
    },
    paralysis = {
        AuraID = 115078,
        AuraMine = true,
        AuraUnit = 'target',
        AuraApplied = 'paralysis',
        AuraApplyLength = 60,
    },
    provoke = {
        AuraID = 116189,
        AuraMine = true,
        AuraUnit = 'target',
        AuraApplied = 'provoke',
        AuraApplyLength = 2,
    },
    purifying_brew = {
        PerformCast = function(spell,env)
            RemoveBlackoutCombo(env)

            -- Need to also decrement the number of charges for Ironskin Brew
            env.ironskin_brew.rechargeSpent = env.ironskin_brew.rechargeSpent+1

            -- Swap stagger urgency to be down one level, to approximate purification (heavy->moderate, moderate->light)
            if env.stagger_heavy.aura_up then
                env.stagger_moderate.expirationTime = env.stagger_heavy.expirationTime
                env.stagger_heavy.expirationTime = 0
            elseif env.stagger_moderate.aura_up then
                env.stagger_light.expirationTime = env.stagger_moderate.expirationTime
                env.stagger_moderate.expirationTime = 0
            end
        end,
    },
    spear_hand_strike = {
        spell_cast_time = 0.01, -- off GCD!
        CanCast = function(spell, env)
            return env.target.is_casting and env.target.is_interruptible
        end,
        PerformCast = function(spell, env)
            if env.target.is_interruptible then
                env.target.is_casting = false
                env.target.is_interruptible = false
            end
        end,
    },
    tiger_palm = {
        PerformCast = function(spell, env)
            RemoveBlackoutCombo(env)

            if env.eye_of_the_tiger.talent_enabled then
                env.eye_of_the_tiger.expirationTime = env.currentTime + 8
            end
            -- TODO: Remove 1 second from CDs of brews
        end
    },
}

local brewmaster_procs = {
    elusive_brawler = {
        AuraID = 195630,
        AuraUnit = 'player',
        AuraMine = true,
    },
    stagger = {
        any = function(spell, env) return spell.light or spell.moderate or spell.heavy or false end,
        light = function(spell, env) return (env.stagger_light.aura_remains > 0) and true or false end,
        moderate = function(spell, env) return (env.stagger_moderate.aura_remains > 0) and true or false end,
        heavy = function(spell, env) return (env.stagger_heavy.aura_remains > 0) and true or false end,
    },
    stagger_light = {
        AuraID = 124275,
        AuraUnit = 'player',
        AuraMine = true,
    },
    stagger_moderate = {
        AuraID = 124274,
        AuraUnit = 'player',
        AuraMine = true,
    },
    stagger_heavy = {
        AuraID = 124273,
        AuraUnit = 'player',
        AuraMine = true,
    },
}


local brewmaster_talent_overrides = {
    eye_of_the_tiger = {
        AuraID = 196608,
        AuraUnit = 'player',
        AuraMine = true,
    },
    black_ox_brew = {
        PerformCast = function(spell, env)
        -- TODO: Fix up energy/brew charges
        end
    },
    dampen_harm = {
        AuraID = 122278,
        AuraMine = true,
        AuraUnit = 'player',
        AuraApplied = 'dampen_harm',
        AuraApplyLength = 10,
    },
    guard = {
        AuraID = 115295,
        AuraMine = true,
        AuraUnit = 'player',
        AuraApplied = 'guard',
        AuraApplyLength = 8,
    },
    blackout_combo = {
        AuraID = 228563,
        AuraMine = true,
        AuraUnit = 'player',
    },
}

local zzz = {
    spear_hand_strike = {
        spell_cast_time = 0.01, -- off GCD!
        CanCast = function(spell, env)
            return env.target.is_casting and env.target.is_interruptible
        end,
        PerformCast = function(spell, env)
            if env.target.is_interruptible then
                env.target.is_casting = false
                env.target.is_interruptible = false
            end
        end,
    },
    tiger_palm = {
        PerformCast = function(spell, env)
            -- Extend Eye of the Tiger
            if env.eye_of_the_tiger.talent_enabled then
                env.eye_of_the_tiger.expirationTime = env.currentTime + 8
            end

            -- Remove Blackout Combo
            if env.blackout_combo.talent_enabled then
                env.blackout_combo.expirationTime = 0
            end
        end
    },
    breath_of_fire = {
        PerformCast = function(spell, env)
            -- Remove Blackout Combo
            if env.blackout_combo.talent_enabled then
                env.blackout_combo.expirationTime = 0
            end
        end
    },
    keg_smash = {
        AuraID = 121253,
        AuraUnit = 'target',
        AuraMine = true,
        AuraApplied = 'keg_smash',
        AuraApplyLength = 15,
        PerformCast = function(spell, env)
            -- Remove Blackout Combo
            if env.blackout_combo.talent_enabled then
                env.blackout_combo.expirationTime = 0
            end
        end
    },
    blackout_strike = {
        AuraApplied = 'blackout_combo',
        AuraApplyLength = 14,
    },
    ironskin_brew = {
        AuraID = 215479,
        AuraUnit = 'player',
        AuraMine = true,
        AuraApplied = 'ironskin_brew',
        AuraApplyLength = 6,

        PerformCast = function(spell,env)
            -- Need to also decrement the number of charges for Purifying Brew
            env.purifying_brew.rechargeSpent = env.purifying_brew.rechargeSpent+1

            -- Remove Blackout Combo
            if env.blackout_combo.talent_enabled then
                env.blackout_combo.expirationTime = 0
            end
        end,
    },
    expel_harm = {
        ChargesUseSpellCount = true,
        PerformCast = function(spell, env)
            spell.rechargeSpent = spell.rechargeSpent + spell.spell_charges
        end,
    },
    purifying_brew = {
        PerformCast = function(spell,env)
            -- Need to also decrement the number of charges for Ironskin Brew
            env.ironskin_brew.rechargeSpent = env.ironskin_brew.rechargeSpent+1

            -- Remove Blackout Combo
            if env.blackout_combo.talent_enabled then
                env.blackout_combo.expirationTime = 0
            end

            -- Swap stagger urgency to be down one level, to approximate purification (heavy->moderate, moderate->light)
            if env.stagger_heavy.aura_up then
                env.stagger_moderate.expirationTime = env.stagger_heavy.expirationTime
                env.stagger_heavy.expirationTime = 0
            elseif env.stagger_moderate.aura_up then
                env.stagger_light.expirationTime = env.stagger_moderate.expirationTime
                env.stagger_moderate.expirationTime = 0
            end
        end,
    },
    stagger = {
        any = function(spell, env) return spell.light or spell.moderate or spell.heavy or false end,
        light = function(spell, env) return (env.stagger_light.aura_remains > 0) and true or false end,
        moderate = function(spell, env) return (env.stagger_moderate.aura_remains > 0) and true or false end,
        heavy = function(spell, env) return (env.stagger_heavy.aura_remains > 0) and true or false end,
    },
    stagger_light = {
        AuraID = 124275,
        AuraUnit = 'player',
        AuraMine = true,
    },
    stagger_moderate = {
        AuraID = 124274,
        AuraUnit = 'player',
        AuraMine = true,
    },
    stagger_heavy = {
        AuraID = 124273,
        AuraUnit = 'player',
        AuraMine = true,
    },
}

TJ:RegisterPlayerClass({
    name = 'Brewmaster',
    class_id = 10,
    spec_id = 1,
    default_action_profile = 'custom::monk::brewmaster',
    resources = { 'energy', 'energy_per_time' },
    actions = {
        brewmaster_abilities_exported,
        brewmaster_base_overrides,
        brewmaster_procs,
        brewmaster_talent_overrides,
    },
    blacklisted = {
        'gift_of_the_ox',
        'greater_gift_of_the_ox',
    },
})

------------------------------------------------------------------------------------------------------------------------
-- Windwalker profile definition
------------------------------------------------------------------------------------------------------------------------

-- exported with /tj _esd
local windwalker_abilities_exported = {
    afterlife = { SpellIDs = { 116092 }, },
    ascension = { TalentID = 22098, },
    blackout_kick = { SpellIDs = { 100784 }, },
    celerity = { TalentID = 19304, },
    chi_burst = { SpellIDs = { 123986 }, TalentID = 20185, },
    chi_torpedo = { SpellIDs = { 115008 }, TalentID = 19818, },
    chi_wave = { SpellIDs = { 115098 }, TalentID = 19820, },
    crackling_jade_lightning = { SpellIDs = { 117952 }, },
    dampen_harm = { SpellIDs = { 122278 }, TalentID = 20175, },
    detox = { SpellIDs = { 218164 }, },
    diffuse_magic = { SpellIDs = { 122783 }, TalentID = 20173, },
    disable = { SpellIDs = { 116095 }, },
    energizing_elixir = { SpellIDs = { 115288 }, TalentID = 22096, },
    eye_of_the_tiger = { TalentID = 23106, },
    fist_of_the_white_tiger = { SpellIDs = { 261947 }, TalentID = 19771, },
    fists_of_fury = { SpellIDs = { 113656 }, },
    flying_serpent_kick = { SpellIDs = { 101545 }, },
    good_karma = { TalentID = 23364, },
    hit_combo = { TalentID = 22093, },
    inner_strength = { TalentID = 23258, },
    invoke_xuen_the_white_tiger = { SpellIDs = { 123904 }, TalentID = 22102, },
    leg_sweep = { SpellIDs = { 119381 }, },
    mastery_combo_strikes = { SpellIDs = { 115636 }, },
    mystic_touch = { SpellIDs = { 8647 }, },
    paralysis = { SpellIDs = { 115078 }, },
    provoke = { SpellIDs = { 115546 }, },
    resuscitate = { SpellIDs = { 115178 }, },
    ring_of_peace = { SpellIDs = { 116844 }, TalentID = 19995, },
    rising_sun_kick = { SpellIDs = { 107428 }, },
    roll = { SpellIDs = { 109132 }, },
    rushing_jade_wind = { SpellIDs = { 261715 }, TalentID = 23122, },
    serenity = { SpellIDs = { 152173 }, TalentID = 21191, },
    spear_hand_strike = { SpellIDs = { 116705 }, },
    spinning_crane_kick = { SpellIDs = { 101546 }, },
    spiritual_focus = { TalentID = 22107, },
    storm_earth_and_fire = { SpellIDs = { 137639 }, },
    tiger_palm = { SpellIDs = { 100780 }, },
    tiger_tail_sweep = { TalentID = 19993, },
    tigers_lust = { SpellIDs = { 116841 }, TalentID = 19302, },
    touch_of_death = { SpellIDs = { 115080 }, },
    touch_of_karma = { SpellIDs = { 122470 }, },
    transcendence = { SpellIDs = { 101643 }, },
    transcendence_transfer = { SpellIDs = { 119996 }, },
    vivify = { SpellIDs = { 116670 }, },
    whirling_dragon_punch = { SpellIDs = { 152175 }, TalentID = 22105, },
    zen_flight = { SpellIDs = { 125883 }, },
}

local windwalker_base_overrides = {
    blackout_kick = {
        cost_type = 'chi',
        chi_cost = function(spell, env) return env.serenity.aura_up and 0 or 1 end, -- Gymnastics to deal with Serenity.
        PerformCast = function(spell, env)
            if env.bok_proc.aura_up then
                env.bok_proc.expirationTime = 0
            end
        end,
    },
    fists_of_fury = {
        cost_type = 'chi',
        chi_cost = function(spell, env) return env.serenity.aura_up and 0 or 3 end, -- Gymnastics to deal with Serenity.
        spell_cast_time = function(spell,env) return env.playerHasteMultiplier * 4 end, -- seems like we can't detect this...
    },
    leg_sweep = {
        AuraID = 119381,
        AuraMine = true,
        AuraUnit = 'target',
        AuraApplied = 'leg_sweep',
        AuraApplyLength = 3,
    },
    paralysis = {
        AuraID = 115078,
        AuraMine = true,
        AuraUnit = 'target',
        AuraApplied = 'paralysis',
        AuraApplyLength = 60,
    },
    provoke = {
        AuraID = 116189,
        AuraMine = true,
        AuraUnit = 'target',
        AuraApplied = 'provoke',
        AuraApplyLength = 2,
    },
    rising_sun_kick = {
        cost_type = 'chi',
        chi_cost = function(spell, env) return env.serenity.aura_up and 0 or 2 end, -- Gymnastics to deal with Serenity.
    },
    spear_hand_strike = {
        spell_cast_time = 0.01, -- off GCD!
        CanCast = function(spell, env)
            return env.target.is_casting and env.target.is_interruptible
        end,
        PerformCast = function(spell, env)
            if env.target.is_interruptible then
                env.target.is_casting = false
                env.target.is_interruptible = false
            end
        end,
    },
    spinning_crane_kick = {
        cost_type = 'chi',
        chi_cost = function(spell, env) return env.serenity.aura_up and 0 or 2 end, -- Gymnastics to deal with Serenity.
        count = function(spell, env)
            return env.active_enemies
        end
    },
    storm_earth_and_fire = {
        AuraID = 137639,
        AuraMine = true,
        AuraUnit = 'player',
        AuraApplied = 'storm_earth_and_fire',
        AuraApplyLength = 15,

        CanCast = function(spell, env)
            --DevTools_Dump{storm_earth_and_fire=env.storm_earth_and_fire}
            return (not env.serenity.talent_enabled) and (not spell.aura_react)
        end,

        spell_cast_time = 0.01, -- off GCD!
    },
    tiger_palm = {
        CanCast = function(spell, env)
            -- Make sure we have enough when RJW is active so that we don't accidentally deactivate it
            if env.rushing_jade_wind.talent_enabled and env.energy.curr < spell.energy_cost + env.rushing_jade_wind.timed_energy_cost + 1 then return false end
            return true
        end,
        PerformCast = function(spell, env)
            env.chi.gained = env.chi.gained + mmin(2, env.chi.deficit)
        end,
    },
    touch_of_death = {
        AuraID = 115080,
        AuraMine = true,
        AuraUnit = 'target',
        AuraApplied = 'touch_of_death',
        AuraApplyLength = 8,
        CanCast = function(spell, env)
            return spell.aura_down and true or false
        end,
    },
    touch_of_karma = {
        AuraID = 122470,
        AuraMine = true,
        AuraUnit = 'target',
        spell_cast_time = 0.01, -- off GCD!
    },
}

local windwalker_talent_overrides = {
    eye_of_the_tiger = {
        AuraID = 196608,
        AuraMine = true,
        AuraUnit = 'target',
        AuraApplied = 'eye_of_the_tiger',
        AuraApplyLength = 8,
    },
    chi_burst = {
        PerformCast = function(spell, env)
            local generated = env.active_enemies == 1 and 1 or 2
            env.chi.gained = env.chi.gained + mmin(env.chi.deficit, generated)
        end
    },
    fist_of_the_white_tiger = {
        CanCast = function(spell, env)
            -- Make sure we have enough when RJW is active so that we don't accidentally deactivate it
            if env.rushing_jade_wind.talent_enabled and env.energy.curr < spell.energy_cost + env.rushing_jade_wind.timed_energy_cost + 1 then return false end
            return true
        end,
        PerformCast = function(spell, env)
            env.chi.gained = env.chi.gained + mmin(3, env.chi.deficit)
        end,
    },
    energizing_elixir = {
        PerformCast = function(spell, env)
            env.energy.gained = env.energy.gained + env.energy.deficit
            env.chi.gained = env.chi.gained + mmin(2, env.chi.deficit)
        end
    },
    inner_strength = {
        AuraID = 261769,
        AuraMine = true,
        AuraUnit = 'player',
        AuraApplied = 'inner_strength',
        AuraApplyLength = 5,
    },
    diffuse_magic = {
        AuraID = 122783,
        AuraMine = true,
        AuraUnit = 'player',
        AuraApplied = 'diffuse_magic',
        AuraApplyLength = 6,
    },
    dampen_harm = {
        AuraID = 122278,
        AuraMine = true,
        AuraUnit = 'player',
        AuraApplied = 'dampen_harm',
        AuraApplyLength = 10,
    },
    hit_combo = {
        AuraID = 196741,
        AuraMine = true,
        AuraUnit = 'player',
        AuraApplied = 'hit_combo',
        AuraApplyLength = 10,
    },
    rushing_jade_wind = {
        AuraID = 261715,
        AuraMine = true,
        AuraUnit = 'player',
        AuraApplied = 'rushing_jade_wind',
        AuraApplyLength = 9999,
        CanCast = function(spell,env) return spell.aura_down end,
        timed_energy_cost = 3,
    },
    whirling_dragon_punch = {
        CanCast = function(spell, env)
            return (env.fists_of_fury.cooldown_remains > 0) and (env.rising_sun_kick.cooldown_remains > 0)
        end,
    },
    serenity = {
        AuraID = 152173,
        AuraMine = true,
        AuraUnit = 'player',
        AuraApplied = 'serenity',
        AuraApplyLength = 8,
        spell_cast_time = 0.01, -- off GCD!
    },
}

local windwalker_procs = {
    bok_proc = { -- tiger palm trigger for free chi cost on BoK
        AuraID = 116768,
        AuraMine = true,
        AuraUnit = 'player',
    },
    mark_of_the_crane = { -- from RJW
        AuraID = 228287,
        AuraUnit = 'target',
        AuraMine = true,
    }
}

local windwalker_legendaries = {
    the_emperors_capacitor = {
        AuraID = 235053,
        AuraUnit = 'player',
        AuraMine = true,
    }
}

local lastSerenityState
local windwalker_hooks = {
    hooks = {
        perform_spend = function(spell, env, action, origCostType, origCostAmount)
            if origCostType == 'chi' then
                if env.serenity.aura_remains > 0 then -- if serenity is active, then no chi costs (still need appropriate amount of chi!)
                    return 'none'
                elseif action == 'blackout_kick' and env.bok_proc.aura_remains > 0 then -- no spend for BoK when there's a proc
                    return 'none'
                end
            end
            return origCostType, origCostAmount
        end,
        OnStateInit = function(env)
            -- Dodgy shit for when serenity changes costs
            if lastSerenityState ~= env.serenity.aura_up then
                lastSerenityState = env.serenity.aura_up
                TJ:QueueProfileReload(true)
            end
        end,
    },
}

TJ:RegisterPlayerClass({
    name = 'Windwalker',
    class_id = 10,
    spec_id = 3,
    default_action_profile = 'simc::monk::windwalker',
    resources = { 'energy', 'energy_per_time', 'chi' },
    actions = {
        windwalker_abilities_exported,
        windwalker_base_overrides,
        windwalker_talent_overrides,
        windwalker_procs,
        windwalker_legendaries,
        windwalker_hooks,
    },
    config_checkboxes = {
        gale_burst_selected = false,
        strike_of_the_windlord_selected = false,
    },
    simc_mapping = { -- simc_name = "equivalent_parsed_ingame_table_name"
        invoke_xuen = "invoke_xuen_the_white_tiger",
        Good_Karma = 'good_karma',
    },
    blacklisted = {
        'lights_judgment'
    },
})
