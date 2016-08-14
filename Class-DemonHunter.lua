local addonName, internal = ...;
local Z = internal.Z

------------------------------------------------------------------------------------------------------------------------
-- Vengeance profile definition
------------------------------------------------------------------------------------------------------------------------

local vengeance_base_overrides = {
    shear = {
        PerformCast = function(spell, env)
            env.pain.gained = env.pain.gained + 10
        end
    },
    soul_cleave = {
        cost_type = 'pain',
        pain_cost = 50, -- cost is 30-60
    },
    immolation_aura = {
        AuraID = 178740,
        AuraMine = true,
        AuraUnit = 'player',
        AuraApplied = 'immolation_aura',
        AuraApplyLength = 6,
    },
    soul_cleave = {
        PerformCast = function(spell, env)
            env.soul_fragments.spent = env.soul_fragments.spent + env.soul_fragments.curr
        end
    }
}

local vengeance_talent_overrides = {
    felblade = {
        PerformCast = function(spell, env)
            env.pain.gained = env.pain.gained + 20
        end,
    },
    fracture = {
        CanCast = function(spell, env)
            return env.soul_fragments.curr >= 2
        end,
        PerformCast = function(spell, env)
            env.soul_fragments.spent = env.soul_fragments.spent + 2
        end,
    },
    spirit_bomb = {
        AuraApplied = 'frail',
        AuraApplyLength = 15,

        CanCast = function(spell, env)
            return env.soul_fragments.curr >= 1
        end,
        PerformCast = function(spell, env)
            env.soul_fragments.spent = env.soul_fragments.spent + 1
        end,
    },
    frail = { -- Spirit bomb debuff
        AuraID = 224509,
        AuraUnit = 'target',
        AuraMine = true,
    }
}

Z:RegisterPlayerClass({
    name = 'Vengeance',
    class_id = 12,
    spec_id = 2,
    action_profile = 'legion-dev::Tier19P::Demon_Hunter_Vengeance_T19P',
    gcd_ability = 'shear',
    resources = { 'pain', 'soul_fragments' },
    actions = {
        vengeance_base_overrides,
        vengeance_talent_overrides,
    },
    blacklisted = {},
})

------------------------------------------------------------------------------------------------------------------------
-- Havoc profile definition
------------------------------------------------------------------------------------------------------------------------

--[[
local havoc_base_overrides = {
}

local havoc_talent_overrides = {
}

Z:RegisterPlayerClass({
    name = 'Havoc',
    class_id = 12,
    spec_id = 1,
    action_profile = 'legion-dev::Tier19P::Demon_Hunter_Havoc_T19P',
    gcd_ability = 'shear',
    resources = { 'fury', 'soul_fragments' },
    actions = {
        havoc_base_overrides,
        havoc_talent_overrides,
    },
    blacklisted = {
        pick_up_fragment = true,
    },
})
]]