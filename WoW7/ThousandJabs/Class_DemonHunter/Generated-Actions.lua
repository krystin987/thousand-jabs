--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Legion only.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if select(4, GetBuildInfo()) >= 80000 then
    return
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if select(3, UnitClass('player')) ~= 12 then return end

local TJ = LibStub('AceAddon-3.0'):GetAddon('ThousandJabs')

TJ:RegisterActionProfileList('simc::demonhunter::havoc', 'Simulationcraft Demon Hunter Profile: Havoc', 12, 1, [[
actions.precombat=flask
actions.precombat+=/augmentation
actions.precombat+=/food
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions.precombat+=/metamorphosis,if=!(talent.demon_reborn.enabled&(talent.demonic.enabled|set_bonus.tier21_4pc))
actions=auto_attack
actions+=/variable,name=waiting_for_nemesis,value=!(!talent.nemesis.enabled|cooldown.nemesis.ready|cooldown.nemesis.remains>target.time_to_die|cooldown.nemesis.remains>60)
actions+=/variable,name=waiting_for_chaos_blades,value=!(!talent.chaos_blades.enabled|cooldown.chaos_blades.ready|cooldown.chaos_blades.remains>target.time_to_die|cooldown.chaos_blades.remains>60)
actions+=/variable,name=pooling_for_meta,value=!talent.demonic.enabled&cooldown.metamorphosis.remains<6&fury.deficit>30&(!variable.waiting_for_nemesis|cooldown.nemesis.remains<10)&(!variable.waiting_for_chaos_blades|cooldown.chaos_blades.remains<6)
actions+=/variable,name=blade_dance,value=talent.first_blood.enabled|set_bonus.tier20_4pc|spell_targets.blade_dance1>=3+(talent.chaos_cleave.enabled*3)
actions+=/variable,name=pooling_for_blade_dance,value=variable.blade_dance&(fury<75-talent.first_blood.enabled*20)
actions+=/variable,name=pooling_for_chaos_strike,value=talent.chaos_cleave.enabled&fury.deficit>40&!raid_event.adds.up&raid_event.adds.in<2*gcd
actions+=/consume_magic
actions+=/call_action_list,name=cooldown,if=gcd.remains=0
actions+=/pick_up_fragment,if=fury.deficit>=35&((cooldown.eye_beam.remains>5|!talent.blind_fury.enabled&!set_bonus.tier21_4pc)|(buff.metamorphosis.up&!set_bonus.tier21_4pc))
actions+=/run_action_list,name=demonic,if=talent.demonic.enabled
actions+=/run_action_list,name=normal
actions.cooldown=arcane_torrent,if=!talent.demonic.enabled&fury.deficit>=15
actions.cooldown+=/arcane_torrent,if=talent.demonic.enabled&fury.deficit>=15&buff.metamorphosis.up
actions.cooldown+=/metamorphosis,if=!(talent.demonic.enabled|variable.pooling_for_meta|variable.waiting_for_nemesis|variable.waiting_for_chaos_blades)|target.time_to_die<25
actions.cooldown+=/metamorphosis,if=talent.demonic.enabled&buff.metamorphosis.up
actions.cooldown+=/nemesis,target_if=min:target.time_to_die,if=raid_event.adds.exists&debuff.nemesis.down&(active_enemies>desired_targets|raid_event.adds.in>60)
actions.cooldown+=/nemesis,if=!raid_event.adds.exists&(buff.chaos_blades.up|buff.metamorphosis.up|cooldown.metamorphosis.adjusted_remains<20|target.time_to_die<=60)
actions.cooldown+=/chaos_blades,if=buff.metamorphosis.up|cooldown.metamorphosis.adjusted_remains>60|target.time_to_die<=duration
actions.cooldown+=/potion,if=buff.metamorphosis.remains>25|target.time_to_die<60
actions.demonic=vengeful_retreat,if=(talent.prepared.enabled|talent.momentum.enabled)&buff.prepared.down&buff.momentum.down
actions.demonic+=/fel_rush,if=(talent.momentum.enabled|talent.fel_mastery.enabled)&(!talent.momentum.enabled|(charges=2|cooldown.vengeful_retreat.remains>4)&buff.momentum.down)&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
actions.demonic+=/throw_glaive,if=talent.bloodlet.enabled&(!talent.momentum.enabled|buff.momentum.up)&charges=2
actions.demonic+=/death_sweep,if=variable.blade_dance
actions.demonic+=/fel_eruption
actions.demonic+=/fury_of_the_illidari,if=(active_enemies>desired_targets)|(raid_event.adds.in>55&(!talent.momentum.enabled|buff.momentum.up))
actions.demonic+=/blade_dance,if=variable.blade_dance&cooldown.eye_beam.remains>5&!cooldown.metamorphosis.ready
actions.demonic+=/throw_glaive,if=talent.bloodlet.enabled&spell_targets>=2&(!talent.master_of_the_glaive.enabled|!talent.momentum.enabled|buff.momentum.up)&(spell_targets>=3|raid_event.adds.in>recharge_time+cooldown)
actions.demonic+=/felblade,if=fury.deficit>=30&(fury<40|buff.metamorphosis.down)
actions.demonic+=/eye_beam,if=spell_targets.eye_beam_tick>desired_targets|(!talent.blind_fury.enabled|fury.deficit>=70)&(!buff.metamorphosis.extended_by_demonic|(set_bonus.tier21_4pc&buff.metamorphosis.remains>16))
actions.demonic+=/annihilation,if=(!talent.momentum.enabled|buff.momentum.up|fury.deficit<30+buff.prepared.up*8|buff.metamorphosis.remains<5)&!variable.pooling_for_blade_dance
actions.demonic+=/throw_glaive,if=talent.bloodlet.enabled&(!talent.master_of_the_glaive.enabled|!talent.momentum.enabled|buff.momentum.up)&raid_event.adds.in>recharge_time+cooldown
actions.demonic+=/chaos_strike,if=(!talent.momentum.enabled|buff.momentum.up|fury.deficit<30+buff.prepared.up*8)&!variable.pooling_for_chaos_strike&!variable.pooling_for_meta&!variable.pooling_for_blade_dance
actions.demonic+=/fel_rush,if=!talent.momentum.enabled&talent.demon_blades.enabled&!cooldown.eye_beam.ready&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
actions.demonic+=/demons_bite
actions.demonic+=/throw_glaive,if=buff.out_of_range.up|!talent.bloodlet.enabled
actions.demonic+=/fel_rush,if=movement.distance>15|(buff.out_of_range.up&!talent.momentum.enabled)
actions.demonic+=/vengeful_retreat,if=movement.distance>15
actions.normal=vengeful_retreat,if=(talent.prepared.enabled|talent.momentum.enabled)&buff.prepared.down&buff.momentum.down
actions.normal+=/fel_rush,if=(talent.momentum.enabled|talent.fel_mastery.enabled)&(!talent.momentum.enabled|(charges=2|cooldown.vengeful_retreat.remains>4)&buff.momentum.down)&(!talent.fel_mastery.enabled|fury.deficit>=25)&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
actions.normal+=/fel_barrage,if=(buff.momentum.up|!talent.momentum.enabled)&(active_enemies>desired_targets|raid_event.adds.in>30)
actions.normal+=/throw_glaive,if=talent.bloodlet.enabled&(!talent.momentum.enabled|buff.momentum.up)&charges=2
actions.normal+=/felblade,if=fury<15&(cooldown.death_sweep.remains<2*gcd|cooldown.blade_dance.remains<2*gcd)
actions.normal+=/death_sweep,if=variable.blade_dance
actions.normal+=/fel_rush,if=charges=2&!talent.momentum.enabled&!talent.fel_mastery.enabled&!buff.metamorphosis.up&talent.demon_blades.enabled
actions.normal+=/fel_eruption
actions.normal+=/fury_of_the_illidari,if=(active_enemies>desired_targets)|(raid_event.adds.in>55&(!talent.momentum.enabled|buff.momentum.up)&(!talent.chaos_blades.enabled|buff.chaos_blades.up|cooldown.chaos_blades.remains>30|target.time_to_die<cooldown.chaos_blades.remains))
actions.normal+=/blade_dance,if=variable.blade_dance
actions.normal+=/throw_glaive,if=talent.bloodlet.enabled&spell_targets>=2&(!talent.master_of_the_glaive.enabled|!talent.momentum.enabled|buff.momentum.up)&(spell_targets>=3|raid_event.adds.in>recharge_time+cooldown)
actions.normal+=/felblade,if=fury.deficit>=30+buff.prepared.up*8
actions.normal+=/eye_beam,if=spell_targets.eye_beam_tick>desired_targets|buff.havoc_t21_4pc.remains<2&(!talent.blind_fury.enabled|fury.deficit>=70)&((spell_targets.eye_beam_tick>=3&raid_event.adds.in>cooldown)|talent.blind_fury.enabled|set_bonus.tier21_2pc)
actions.normal+=/annihilation,if=(talent.demon_blades.enabled|!talent.momentum.enabled|buff.momentum.up|fury.deficit<30+buff.prepared.up*8|buff.metamorphosis.remains<5)&!variable.pooling_for_blade_dance
actions.normal+=/throw_glaive,if=talent.bloodlet.enabled&(!talent.master_of_the_glaive.enabled|!talent.momentum.enabled|buff.momentum.up)&raid_event.adds.in>recharge_time+cooldown
actions.normal+=/throw_glaive,if=!talent.bloodlet.enabled&buff.metamorphosis.down&spell_targets>=3
actions.normal+=/chaos_strike,if=(talent.demon_blades.enabled|!talent.momentum.enabled|buff.momentum.up|fury.deficit<30+buff.prepared.up*8)&!variable.pooling_for_chaos_strike&!variable.pooling_for_meta&!variable.pooling_for_blade_dance
actions.normal+=/fel_rush,if=!talent.momentum.enabled&raid_event.movement.in>charges*10&talent.demon_blades.enabled
actions.normal+=/demons_bite
actions.normal+=/felblade,if=movement.distance>15|buff.out_of_range.up
actions.normal+=/fel_rush,if=movement.distance>15|(buff.out_of_range.up&!talent.momentum.enabled)
actions.normal+=/vengeful_retreat,if=movement.distance>15
actions.normal+=/throw_glaive,if=!talent.bloodlet.enabled&talent.demon_blades.enabled
]])

TJ:RegisterActionProfileList('simc::demonhunter::vengeance', 'Simulationcraft Demon Hunter Profile: Vengeance', 12, 2, [[
actions.precombat=flask
actions.precombat+=/augmentation
actions.precombat+=/food
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions=auto_attack
actions+=/consume_magic
actions+=/demonic_infusion,if=cooldown.demon_spikes.charges=0&pain.deficit>60
actions+=/fiery_brand,if=buff.demon_spikes.down&buff.metamorphosis.down
actions+=/demon_spikes,if=charges=2|buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down
actions+=/empower_wards,if=debuff.casting.up
actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&artifact.fiery_demise.enabled&dot.fiery_brand.ticking
actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&(!artifact.fiery_demise.enabled|(max_charges-charges_fractional)*recharge_time<cooldown.fiery_brand.remains+5)&(cooldown.sigil_of_flame.remains>7|charges=2)
actions+=/spirit_bomb,if=soul_fragments=5|debuff.frailty.down
actions+=/soul_carver,if=dot.fiery_brand.ticking
actions+=/immolation_aura,if=pain<=80
actions+=/felblade,if=pain<=70
actions+=/soul_barrier
actions+=/soul_cleave,if=soul_fragments=5
actions+=/metamorphosis,if=buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down&incoming_damage_5s>health.max*0.70
actions+=/fel_devastation,if=incoming_damage_5s>health.max*0.70
actions+=/soul_cleave,if=incoming_damage_5s>=health.max*0.70
actions+=/fel_eruption
actions+=/sigil_of_flame,if=remains-delay<=0.3*duration
actions+=/fracture,if=pain>=80&soul_fragments<4&incoming_damage_4s<=health.max*0.20
actions+=/soul_cleave,if=pain>=80
actions+=/sever
actions+=/shear
]])
