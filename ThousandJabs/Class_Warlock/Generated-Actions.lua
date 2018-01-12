if select(3, UnitClass('player')) ~= 9 then return end

local TJ = LibStub('AceAddon-3.0'):GetAddon('ThousandJabs')

TJ:RegisterActionProfileList('simc::warlock::affliction', 'Simulationcraft Warlock Profile: Affliction', 9, 1, [[
actions.precombat=flask
actions.precombat+=/food
actions.precombat+=/augmentation
actions.precombat+=/summon_pet,if=!talent.grimoire_of_supremacy.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.demonic_power.down)
actions.precombat+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&artifact.lord_of_flames.rank>0
actions.precombat+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&active_enemies>1
actions.precombat+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&active_enemies=1&artifact.lord_of_flames.rank=0
actions.precombat+=/snapshot_stats
actions.precombat+=/grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
actions.precombat+=/life_tap,if=talent.empowered_life_tap.enabled&!buff.empowered_life_tap.remains
actions.precombat+=/potion
actions=call_action_list,name=mg,if=talent.malefic_grasp.enabled
actions+=/call_action_list,name=writhe,if=talent.writhe_in_agony.enabled
actions+=/call_action_list,name=haunt,if=talent.haunt.enabled
actions.haunt=reap_souls,if=!buff.deadwind_harvester.remains&time>5&(buff.tormented_souls.react>=5|target.time_to_die<=buff.tormented_souls.react*(5+1.5*equipped.144364)+(buff.deadwind_harvester.remains*(5+1.5*equipped.144364)%12*(5+1.5*equipped.144364)))
actions.haunt+=/reap_souls,if=debuff.haunt.remains&!buff.deadwind_harvester.remains
actions.haunt+=/reap_souls,if=active_enemies>1&!buff.deadwind_harvester.remains&time>5&soul_shard>0&((talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption>=3)|spell_targets.seed_of_corruption>=5)
actions.haunt+=/agony,cycle_targets=1,if=remains<=tick_time+gcd
actions.haunt+=/drain_soul,cycle_targets=1,if=target.time_to_die<=gcd*2&soul_shard<5
actions.haunt+=/service_pet,if=dot.corruption.remains&dot.agony.remains
actions.haunt+=/summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
actions.haunt+=/summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>2
actions.haunt+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&equipped.132379&!cooldown.sindorei_spite_icd.remains
actions.haunt+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>1&equipped.132379&!cooldown.sindorei_spite_icd.remains
actions.haunt+=/berserking,if=prev_gcd.1.unstable_affliction|buff.soul_harvest.remains>=10
actions.haunt+=/blood_fury
actions.haunt+=/soul_harvest,if=buff.soul_harvest.remains<=8&buff.active_uas.stack>=1&(raid_event.adds.in>20|active_enemies>1|!raid_event.adds.exists)
actions.haunt+=/potion,if=!talent.soul_harvest.enabled&(trinket.proc.any.react|trinket.stack_proc.any.react|target.time_to_die<=70|buff.active_uas.stack>2)
actions.haunt+=/potion,if=talent.soul_harvest.enabled&buff.soul_harvest.remains&(trinket.proc.any.react|trinket.stack_proc.any.react|target.time_to_die<=70|!cooldown.haunt.remains|buff.active_uas.stack>2)
actions.haunt+=/siphon_life,cycle_targets=1,if=remains<=tick_time+gcd
actions.haunt+=/corruption,cycle_targets=1,if=remains<=tick_time+gcd&(spell_targets.seed_of_corruption<3&talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<5)
actions.haunt+=/reap_souls,if=(buff.deadwind_harvester.remains+buff.tormented_souls.react*(5+equipped.144364))>=(12*(5+1.5*equipped.144364))
actions.haunt+=/life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<=gcd
actions.haunt+=/phantom_singularity
actions.haunt+=/haunt
actions.haunt+=/agony,cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains
actions.haunt+=/life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<duration*0.3|talent.malefic_grasp.enabled&target.time_to_die>15&mana.pct<10
actions.haunt+=/siphon_life,if=remains<=duration*0.3&target.time_to_die>=remains
actions.haunt+=/siphon_life,cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains&debuff.haunt.remains>=action.unstable_affliction_1.tick_time*6&debuff.haunt.remains>=action.unstable_affliction_1.tick_time*4
actions.haunt+=/seed_of_corruption,if=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption>=3|spell_targets.seed_of_corruption>=5|spell_targets.seed_of_corruption>=3&dot.corruption.remains<=cast_time+travel_time
actions.haunt+=/corruption,if=remains<=duration*0.3&target.time_to_die>=remains
actions.haunt+=/corruption,cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains&debuff.haunt.remains>=action.unstable_affliction_1.tick_time*6&debuff.haunt.remains>=action.unstable_affliction_1.tick_time*4
actions.haunt+=/unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<5&((soul_shard>=4&!talent.contagion.enabled)|soul_shard>=5|target.time_to_die<30)
actions.haunt+=/unstable_affliction,cycle_targets=1,if=active_enemies>1&(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&soul_shard>=4&talent.contagion.enabled&cooldown.haunt.remains<15&dot.unstable_affliction_1.remains<cast_time&dot.unstable_affliction_2.remains<cast_time&dot.unstable_affliction_3.remains<cast_time&dot.unstable_affliction_4.remains<cast_time&dot.unstable_affliction_5.remains<cast_time
actions.haunt+=/unstable_affliction,cycle_targets=1,if=active_enemies>1&(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&(equipped.132381|equipped.132457)&cooldown.haunt.remains<15&dot.unstable_affliction_1.remains<cast_time&dot.unstable_affliction_2.remains<cast_time&dot.unstable_affliction_3.remains<cast_time&dot.unstable_affliction_4.remains<cast_time&dot.unstable_affliction_5.remains<cast_time
actions.haunt+=/unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<5&talent.contagion.enabled&soul_shard>=4&dot.unstable_affliction_1.remains<cast_time&dot.unstable_affliction_2.remains<cast_time&dot.unstable_affliction_3.remains<cast_time&dot.unstable_affliction_4.remains<cast_time&dot.unstable_affliction_5.remains<cast_time
actions.haunt+=/unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<5&debuff.haunt.remains>=action.unstable_affliction_1.tick_time*2
actions.haunt+=/reap_souls,if=!buff.deadwind_harvester.remains&(buff.active_uas.stack>1|(prev_gcd.1.unstable_affliction&buff.tormented_souls.react>1))
actions.haunt+=/life_tap,if=mana.pct<=10
actions.haunt+=/life_tap,if=prev_gcd.1.life_tap&buff.active_uas.stack=0&mana.pct<50
actions.haunt+=/drain_soul,chain=1,interrupt=1
actions.haunt+=/life_tap,moving=1,if=mana.pct<80
actions.haunt+=/agony,moving=1,cycle_targets=1,if=remains<=duration-(3*tick_time)
actions.haunt+=/siphon_life,moving=1,cycle_targets=1,if=remains<=duration-(3*tick_time)
actions.haunt+=/corruption,moving=1,cycle_targets=1,if=remains<=duration-(3*tick_time)
actions.haunt+=/life_tap,moving=0
actions.mg=reap_souls,if=!buff.deadwind_harvester.remains&time>5&((buff.tormented_souls.react>=4+active_enemies|buff.tormented_souls.react>=9)|target.time_to_die<=buff.tormented_souls.react*(5+1.5*equipped.144364)+(buff.deadwind_harvester.remains*(5+1.5*equipped.144364)%12*(5+1.5*equipped.144364)))
actions.mg+=/agony,cycle_targets=1,max_cycle_targets=5,target_if=sim.target!=target&talent.soul_harvest.enabled&cooldown.soul_harvest.remains<cast_time*6&remains<=duration*0.3&target.time_to_die>=remains&time_to_die>tick_time*3
actions.mg+=/agony,cycle_targets=1,max_cycle_targets=4,if=remains<=(tick_time+gcd)
actions.mg+=/seed_of_corruption,if=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption>=3&soul_shard=5
actions.mg+=/unstable_affliction,if=target=sim.target&soul_shard=5
actions.mg+=/drain_soul,cycle_targets=1,if=target.time_to_die<gcd*2&soul_shard<5
actions.mg+=/life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<=gcd
actions.mg+=/service_pet,if=dot.corruption.remains&dot.agony.remains
actions.mg+=/summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
actions.mg+=/summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>2
actions.mg+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&equipped.132379&!cooldown.sindorei_spite_icd.remains
actions.mg+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>1&equipped.132379&!cooldown.sindorei_spite_icd.remains
actions.mg+=/berserking,if=prev_gcd.1.unstable_affliction|buff.soul_harvest.remains>=10
actions.mg+=/blood_fury
actions.mg+=/siphon_life,cycle_targets=1,if=remains<=(tick_time+gcd)&target.time_to_die>tick_time*3
actions.mg+=/corruption,cycle_targets=1,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<5&remains<=(tick_time+gcd)&target.time_to_die>tick_time*3
actions.mg+=/phantom_singularity
actions.mg+=/soul_harvest,if=buff.active_uas.stack>1&buff.soul_harvest.remains<=8&sim.target=target&(!talent.deaths_embrace.enabled|target.time_to_die>=136|target.time_to_die<=40)
actions.mg+=/potion,if=target.time_to_die<=70
actions.mg+=/potion,if=(!talent.soul_harvest.enabled|buff.soul_harvest.remains>12)&buff.active_uas.stack>=2
actions.mg+=/agony,cycle_targets=1,if=remains<=(duration*0.3)&target.time_to_die>=remains&(buff.active_uas.stack=0|prev_gcd.1.agony)
actions.mg+=/siphon_life,cycle_targets=1,if=remains<=(duration*0.3)&target.time_to_die>=remains&(buff.active_uas.stack=0|prev_gcd.1.siphon_life)
actions.mg+=/corruption,cycle_targets=1,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<5&remains<=(duration*0.3)&target.time_to_die>=remains&(buff.active_uas.stack=0|prev_gcd.1.corruption)
actions.mg+=/life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<duration*0.3|talent.malefic_grasp.enabled&target.time_to_die>15&mana.pct<10
actions.mg+=/seed_of_corruption,if=(talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption>=3)|(spell_targets.seed_of_corruption>=5&dot.corruption.remains<=cast_time+travel_time)
actions.mg+=/unstable_affliction,if=target=sim.target&target.time_to_die<30
actions.mg+=/unstable_affliction,if=target=sim.target&active_enemies>1&soul_shard>=4
actions.mg+=/unstable_affliction,if=target=sim.target&(buff.active_uas.stack=0|(!prev_gcd.3.unstable_affliction&prev_gcd.1.unstable_affliction))&dot.agony.remains>cast_time+(6.5*spell_haste)
actions.mg+=/reap_souls,if=buff.deadwind_harvester.remains<dot.unstable_affliction_1.remains|buff.deadwind_harvester.remains<dot.unstable_affliction_2.remains|buff.deadwind_harvester.remains<dot.unstable_affliction_3.remains|buff.deadwind_harvester.remains<dot.unstable_affliction_4.remains|buff.deadwind_harvester.remains<dot.unstable_affliction_5.remains&buff.active_uas.stack>1
actions.mg+=/life_tap,if=mana.pct<=10
actions.mg+=/life_tap,if=prev_gcd.1.life_tap&buff.active_uas.stack=0&mana.pct<50
actions.mg+=/drain_soul,chain=1,interrupt=1
actions.mg+=/life_tap,moving=1,if=mana.pct<80
actions.mg+=/agony,moving=1,cycle_targets=1,if=remains<duration-(3*tick_time)
actions.mg+=/siphon_life,moving=1,cycle_targets=1,if=remains<duration-(3*tick_time)
actions.mg+=/corruption,moving=1,cycle_targets=1,if=remains<duration-(3*tick_time)
actions.mg+=/life_tap,moving=0
actions.writhe=reap_souls,if=!buff.deadwind_harvester.remains&time>5&(buff.tormented_souls.react>=5|target.time_to_die<=buff.tormented_souls.react*(5+1.5*equipped.144364)+(buff.deadwind_harvester.remains*(5+1.5*equipped.144364)%12*(5+1.5*equipped.144364)))
actions.writhe+=/reap_souls,if=!buff.deadwind_harvester.remains&time>5&(buff.soul_harvest.remains>=(5+1.5*equipped.144364)&buff.active_uas.stack>1|buff.concordance_of_the_legionfall.react|trinket.proc.intellect.react|trinket.stacking_proc.intellect.react|trinket.proc.mastery.react|trinket.stacking_proc.mastery.react|trinket.proc.crit.react|trinket.stacking_proc.crit.react|trinket.proc.versatility.react|trinket.stacking_proc.versatility.react|trinket.proc.spell_power.react|trinket.stacking_proc.spell_power.react)
actions.writhe+=/agony,if=remains<=tick_time+gcd
actions.writhe+=/agony,cycle_targets=1,max_cycle_targets=5,target_if=sim.target!=target&talent.soul_harvest.enabled&cooldown.soul_harvest.remains<cast_time*6&remains<=duration*0.3&target.time_to_die>=remains&time_to_die>tick_time*3
actions.writhe+=/agony,cycle_targets=1,max_cycle_targets=3,target_if=sim.target!=target&remains<=tick_time+gcd&time_to_die>tick_time*3
actions.writhe+=/seed_of_corruption,if=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption>=3&soul_shard=5
actions.writhe+=/unstable_affliction,if=soul_shard=5|(time_to_die<=((duration+cast_time)*soul_shard))
actions.writhe+=/drain_soul,cycle_targets=1,if=target.time_to_die<=gcd*2&soul_shard<5
actions.writhe+=/life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<=gcd
actions.writhe+=/service_pet,if=dot.corruption.remains&dot.agony.remains
actions.writhe+=/summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
actions.writhe+=/summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>2
actions.writhe+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&equipped.132379&!cooldown.sindorei_spite_icd.remains
actions.writhe+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>1&equipped.132379&!cooldown.sindorei_spite_icd.remains
actions.writhe+=/berserking,if=prev_gcd.1.unstable_affliction|buff.soul_harvest.remains>=10
actions.writhe+=/blood_fury
actions.writhe+=/soul_harvest,if=sim.target=target&buff.soul_harvest.remains<=8&(raid_event.adds.in>20|active_enemies>1|!raid_event.adds.exists)&(buff.active_uas.stack>=2|active_enemies>3)&(!talent.deaths_embrace.enabled|time_to_die>120|time_to_die<30)
actions.writhe+=/potion,if=target.time_to_die<=70
actions.writhe+=/potion,if=(!talent.soul_harvest.enabled|buff.soul_harvest.remains>12)&(trinket.proc.any.react|trinket.stack_proc.any.react|buff.active_uas.stack>=2)
actions.writhe+=/siphon_life,cycle_targets=1,if=remains<=tick_time+gcd&time_to_die>tick_time*2
actions.writhe+=/corruption,cycle_targets=1,if=remains<=tick_time+gcd&((spell_targets.seed_of_corruption<3&talent.sow_the_seeds.enabled)|spell_targets.seed_of_corruption<5)&time_to_die>tick_time*2
actions.writhe+=/life_tap,if=mana.pct<40&(buff.active_uas.stack<1|!buff.deadwind_harvester.remains)
actions.writhe+=/reap_souls,if=(buff.deadwind_harvester.remains+buff.tormented_souls.react*(5+equipped.144364))>=(12*(5+1.5*equipped.144364))
actions.writhe+=/phantom_singularity
actions.writhe+=/seed_of_corruption,if=(talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption>=3)|(spell_targets.seed_of_corruption>3&dot.corruption.refreshable)
actions.writhe+=/unstable_affliction,if=talent.contagion.enabled&dot.unstable_affliction_1.remains<cast_time&dot.unstable_affliction_2.remains<cast_time&dot.unstable_affliction_3.remains<cast_time&dot.unstable_affliction_4.remains<cast_time&dot.unstable_affliction_5.remains<cast_time
actions.writhe+=/unstable_affliction,if=talent.absolute_corruption.enabled&set_bonus.tier21_4pc&debuff.tormented_agony.remains<=cast_time
actions.writhe+=/unstable_affliction,cycle_targets=1,target_if=buff.deadwind_harvester.remains>=duration+cast_time&dot.unstable_affliction_1.remains<cast_time&dot.unstable_affliction_2.remains<cast_time&dot.unstable_affliction_3.remains<cast_time&dot.unstable_affliction_4.remains<cast_time&dot.unstable_affliction_5.remains<cast_time
actions.writhe+=/unstable_affliction,if=buff.deadwind_harvester.remains>tick_time*2&(!set_bonus.tier21_4pc|talent.contagion.enabled|soul_shard>1)&(!talent.contagion.enabled|soul_shard>1|buff.soul_harvest.remains)&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking<5)
actions.writhe+=/reap_souls,if=!buff.deadwind_harvester.remains&buff.active_uas.stack>1
actions.writhe+=/reap_souls,if=!buff.deadwind_harvester.remains&prev_gcd.1.unstable_affliction&buff.tormented_souls.react>1
actions.writhe+=/life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<duration*0.3&(!buff.deadwind_harvester.remains|buff.active_uas.stack<1)
actions.writhe+=/agony,if=refreshable&time_to_die>=remains
actions.writhe+=/siphon_life,if=refreshable&time_to_die>=remains
actions.writhe+=/corruption,if=refreshable&time_to_die>=remains
actions.writhe+=/agony,cycle_targets=1,target_if=sim.target!=target&time_to_die>tick_time*3&!buff.deadwind_harvester.remains&refreshable
actions.writhe+=/siphon_life,cycle_targets=1,target_if=sim.target!=target&time_to_die>tick_time*3&!buff.deadwind_harvester.remains&refreshable
actions.writhe+=/corruption,cycle_targets=1,target_if=sim.target!=target&time_to_die>tick_time*3&!buff.deadwind_harvester.remains&refreshable
actions.writhe+=/life_tap,if=mana.pct<=10
actions.writhe+=/life_tap,if=prev_gcd.1.life_tap&buff.active_uas.stack=0&mana.pct<50
actions.writhe+=/drain_soul,chain=1,interrupt=1
actions.writhe+=/life_tap,moving=1,if=mana.pct<80
actions.writhe+=/agony,moving=1,cycle_targets=1,if=remains<=duration-(3*tick_time)
actions.writhe+=/siphon_life,moving=1,cycle_targets=1,if=remains<=duration-(3*tick_time)
actions.writhe+=/corruption,moving=1,cycle_targets=1,if=remains<=duration-(3*tick_time)
actions.writhe+=/life_tap,moving=0
]])

TJ:RegisterActionProfileList('simc::warlock::demonology', 'Simulationcraft Warlock Profile: Demonology', 9, 2, [[
actions.precombat=flask
actions.precombat+=/food
actions.precombat+=/augmentation
actions.precombat+=/summon_pet,if=!talent.grimoire_of_supremacy.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.demonic_power.down)
actions.precombat+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&artifact.lord_of_flames.rank>0
actions.precombat+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&active_enemies>1
actions.precombat+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&active_enemies=1&artifact.lord_of_flames.rank=0
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions.precombat+=/demonic_empowerment
actions.precombat+=/demonbolt
actions.precombat+=/shadow_bolt
actions=implosion,if=wild_imp_remaining_duration<=action.shadow_bolt.execute_time&(buff.demonic_synergy.remains|talent.soul_conduit.enabled|(!talent.soul_conduit.enabled&spell_targets.implosion>1)|wild_imp_count<=4)
actions+=/variable,name=3min,value=doomguard_no_de>0|infernal_no_de>0
actions+=/variable,name=no_de1,value=dreadstalker_no_de>0|darkglare_no_de>0|doomguard_no_de>0|infernal_no_de>0|service_no_de>0
actions+=/variable,name=no_de2,value=(variable.3min&service_no_de>0)|(variable.3min&wild_imp_no_de>0)|(variable.3min&dreadstalker_no_de>0)|(service_no_de>0&dreadstalker_no_de>0)|(service_no_de>0&wild_imp_no_de>0)|(dreadstalker_no_de>0&wild_imp_no_de>0)|(prev_gcd.1.hand_of_guldan&variable.no_de1)
actions+=/implosion,if=prev_gcd.1.hand_of_guldan&((wild_imp_remaining_duration<=3&buff.demonic_synergy.remains)|(wild_imp_remaining_duration<=4&spell_targets.implosion>2))
actions+=/shadowflame,if=(debuff.shadowflame.stack>0&remains<action.shadow_bolt.cast_time+travel_time)&spell_targets.demonwrath<5
actions+=/summon_infernal,if=(!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>2)&equipped.132369
actions+=/summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<=2&equipped.132369
actions+=/call_dreadstalkers,if=((!talent.summon_darkglare.enabled|talent.power_trip.enabled)&(spell_targets.implosion<3|!talent.implosion.enabled))&!(soul_shard=5&buff.demonic_calling.remains)
actions+=/doom,cycle_targets=1,if=(!talent.hand_of_doom.enabled&target.time_to_die>duration&(!ticking|remains<duration*0.3))&!(variable.no_de1|prev_gcd.1.hand_of_guldan)
actions+=/shadowflame,if=(charges=2&soul_shard<5)&spell_targets.demonwrath<5&!variable.no_de1
actions+=/service_pet
actions+=/summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
actions+=/summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>2
actions+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&equipped.132379&!cooldown.sindorei_spite_icd.remains
actions+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>1&equipped.132379&!cooldown.sindorei_spite_icd.remains
actions+=/shadow_bolt,if=buff.shadowy_inspiration.remains&soul_shard<5&!prev_gcd.1.doom&!variable.no_de2
actions+=/summon_darkglare,if=prev_gcd.1.hand_of_guldan|prev_gcd.1.call_dreadstalkers|talent.power_trip.enabled
actions+=/summon_darkglare,if=cooldown.call_dreadstalkers.remains>5&soul_shard<3
actions+=/summon_darkglare,if=cooldown.call_dreadstalkers.remains<=action.summon_darkglare.cast_time&(soul_shard>=3|soul_shard>=1&buff.demonic_calling.react)
actions+=/call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&(cooldown.summon_darkglare.remains>2|prev_gcd.1.summon_darkglare|cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=3|cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=1&buff.demonic_calling.react)
actions+=/hand_of_guldan,if=soul_shard>=4&(((!(variable.no_de1|prev_gcd.1.hand_of_guldan)&(pet_count>=13&!talent.shadowy_inspiration.enabled|pet_count>=6&talent.shadowy_inspiration.enabled))|!variable.no_de2|soul_shard=5)&talent.power_trip.enabled)
actions+=/hand_of_guldan,if=(soul_shard>=3&prev_gcd.1.call_dreadstalkers&!artifact.thalkiels_ascendance.rank)|soul_shard>=5|(soul_shard>=4&cooldown.summon_darkglare.remains>2)
actions+=/demonic_empowerment,if=(((talent.power_trip.enabled&(!talent.implosion.enabled|spell_targets.demonwrath<=1))|!talent.implosion.enabled|(talent.implosion.enabled&!talent.soul_conduit.enabled&spell_targets.demonwrath<=3))&(wild_imp_no_de>3|prev_gcd.1.hand_of_guldan))|(prev_gcd.1.hand_of_guldan&wild_imp_no_de=0&wild_imp_remaining_duration<=0)|(prev_gcd.1.implosion&wild_imp_no_de>0)
actions+=/demonic_empowerment,if=variable.no_de1|prev_gcd.1.hand_of_guldan
actions+=/use_items
actions+=/berserking
actions+=/blood_fury
actions+=/soul_harvest,if=!buff.soul_harvest.remains
actions+=/potion,name=prolonged_power,if=buff.soul_harvest.remains|target.time_to_die<=70|trinket.proc.any.react
actions+=/shadowflame,if=charges=2&spell_targets.demonwrath<5
actions+=/thalkiels_consumption,if=(dreadstalker_remaining_duration>execute_time|talent.implosion.enabled&spell_targets.implosion>=3)&(wild_imp_count>3&dreadstalker_count<=2|wild_imp_count>5)&wild_imp_remaining_duration>execute_time
actions+=/life_tap,if=mana.pct<=15|(mana.pct<=65&((cooldown.call_dreadstalkers.remains<=0.75&soul_shard>=2)|((cooldown.call_dreadstalkers.remains<gcd*2)&(cooldown.summon_doomguard.remains<=0.75|cooldown.service_pet.remains<=0.75)&soul_shard>=3)))
actions+=/demonwrath,chain=1,interrupt=1,if=spell_targets.demonwrath>=3
actions+=/demonwrath,moving=1,chain=1,interrupt=1
actions+=/demonbolt
actions+=/shadow_bolt,if=buff.shadowy_inspiration.remains
actions+=/demonic_empowerment,if=artifact.thalkiels_ascendance.rank&talent.power_trip.enabled&!talent.demonbolt.enabled&talent.shadowy_inspiration.enabled
actions+=/shadow_bolt
actions+=/life_tap
]])

TJ:RegisterActionProfileList('simc::warlock::destruction', 'Simulationcraft Warlock Profile: Destruction', 9, 3, [[
actions.precombat=flask
actions.precombat+=/food
actions.precombat+=/augmentation
actions.precombat+=/summon_pet,if=!talent.grimoire_of_supremacy.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.demonic_power.down)
actions.precombat+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&artifact.lord_of_flames.rank>0
actions.precombat+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&active_enemies>1
actions.precombat+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&active_enemies=1&artifact.lord_of_flames.rank=0
actions.precombat+=/snapshot_stats
actions.precombat+=/grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
actions.precombat+=/life_tap,if=talent.empowered_life_tap.enabled&!buff.empowered_life_tap.remains
actions.precombat+=/potion
actions.precombat+=/chaos_bolt
actions=immolate,cycle_targets=1,if=active_enemies=2&talent.roaring_blaze.enabled&!cooldown.havoc.remains&dot.immolate.remains<=buff.active_havoc.duration
actions+=/havoc,target=2,if=active_enemies>1&(active_enemies<4|talent.wreak_havoc.enabled&active_enemies<6)&!debuff.havoc.remains
actions+=/dimensional_rift,if=charges=3
actions+=/cataclysm,if=spell_targets.cataclysm>=3
actions+=/immolate,if=(active_enemies<5|!talent.fire_and_brimstone.enabled)&remains<=tick_time
actions+=/immolate,cycle_targets=1,if=(active_enemies<5|!talent.fire_and_brimstone.enabled)&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>=action.immolate.cast_time*active_enemies)&active_enemies>1&remains<=tick_time&(!talent.roaring_blaze.enabled|(!debuff.roaring_blaze.remains&action.conflagrate.charges<2+set_bonus.tier19_4pc))
actions+=/immolate,if=talent.roaring_blaze.enabled&remains<=duration&!debuff.roaring_blaze.remains&target.time_to_die>10&(action.conflagrate.charges=2+set_bonus.tier19_4pc|(action.conflagrate.charges>=1+set_bonus.tier19_4pc&action.conflagrate.recharge_time<cast_time+gcd)|target.time_to_die<24)
actions+=/berserking
actions+=/blood_fury
actions+=/use_items
actions+=/potion,name=deadly_grace,if=(buff.soul_harvest.remains|trinket.proc.any.react|target.time_to_die<=45)
actions+=/shadowburn,if=soul_shard<4&buff.conflagration_of_chaos.remains<=action.chaos_bolt.cast_time
actions+=/shadowburn,if=(charges=1+set_bonus.tier19_4pc&recharge_time<action.chaos_bolt.cast_time|charges=2+set_bonus.tier19_4pc)&soul_shard<5
actions+=/conflagrate,if=talent.roaring_blaze.enabled&(charges=2+set_bonus.tier19_4pc|(charges>=1+set_bonus.tier19_4pc&recharge_time<gcd)|target.time_to_die<24)
actions+=/conflagrate,if=talent.roaring_blaze.enabled&debuff.roaring_blaze.stack>0&dot.immolate.remains>dot.immolate.duration*0.3&(active_enemies=1|soul_shard<3)&soul_shard<5
actions+=/conflagrate,if=!talent.roaring_blaze.enabled&buff.backdraft.stack<3&(charges=1+set_bonus.tier19_4pc&recharge_time<action.chaos_bolt.cast_time|charges=2+set_bonus.tier19_4pc)&soul_shard<5
actions+=/life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<=gcd
actions+=/dimensional_rift,if=equipped.144369&!buff.lessons_of_spacetime.remains&((!talent.grimoire_of_supremacy.enabled&!cooldown.summon_doomguard.remains)|(talent.grimoire_of_service.enabled&!cooldown.service_pet.remains)|(talent.soul_harvest.enabled&!cooldown.soul_harvest.remains))
actions+=/service_pet
actions+=/summon_infernal,if=artifact.lord_of_flames.rank>0&!buff.lord_of_flames.remains
actions+=/summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
actions+=/summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>2
actions+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&artifact.lord_of_flames.rank>0&buff.lord_of_flames.remains&!pet.doomguard.active
actions+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&equipped.132379&!cooldown.sindorei_spite_icd.remains
actions+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>1&equipped.132379&!cooldown.sindorei_spite_icd.remains
actions+=/soul_harvest,if=!buff.soul_harvest.remains
actions+=/chaos_bolt,if=active_enemies<4&buff.active_havoc.remains>cast_time
actions+=/channel_demonfire,if=dot.immolate.remains>cast_time&(active_enemies=1|buff.active_havoc.remains<action.chaos_bolt.cast_time)
actions+=/rain_of_fire,if=active_enemies>=3
actions+=/rain_of_fire,if=active_enemies>=6&talent.wreak_havoc.enabled
actions+=/dimensional_rift,if=target.time_to_die<=32|!equipped.144369|charges>1|(!equipped.144369&(!talent.grimoire_of_service.enabled|recharge_time<cooldown.service_pet.remains)&(!talent.soul_harvest.enabled|recharge_time<cooldown.soul_harvest.remains)&(!talent.grimoire_of_supremacy.enabled|recharge_time<cooldown.summon_doomguard.remains))
actions+=/life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<duration*0.3
actions+=/cataclysm
actions+=/chaos_bolt,if=active_enemies<3&(cooldown.havoc.remains>12&cooldown.havoc.remains|active_enemies=1|soul_shard>=5-spell_targets.infernal_awakening*1.5|target.time_to_die<=10)
actions+=/shadowburn
actions+=/conflagrate,if=!talent.roaring_blaze.enabled&buff.backdraft.stack<3
actions+=/immolate,cycle_targets=1,if=(active_enemies<5|!talent.fire_and_brimstone.enabled)&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>=action.immolate.cast_time*active_enemies)&!talent.roaring_blaze.enabled&remains<=duration*0.3
actions+=/incinerate
actions+=/life_tap
]])

