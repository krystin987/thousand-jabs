if select(3, UnitClass('player')) ~= 4 then return end

local TJ = LibStub('AceAddon-3.0'):GetAddon('ThousandJabs')

TJ:RegisterActionProfileList('simc::rogue::assassination', 'Simulationcraft Rogue Profile: Assassination', 4, 1, [[
actions.precombat=flask,name=flask_of_the_seventh_demon
actions.precombat+=/augmentation,name=defiled
actions.precombat+=/food,name=lavish_suramar_feast
actions.precombat+=/snapshot_stats
actions.precombat+=/apply_poison
actions.precombat+=/stealth
actions.precombat+=/potion,name=old_war
actions.precombat+=/marked_for_death,if=raid_event.adds.in>40
actions=variable,name=energy_regen_combined,value=energy.regen+poisoned_bleeds*(7+talent.venom_rush.enabled*3)%2
actions+=/variable,name=energy_time_to_max_combined,value=energy.deficit%variable.energy_regen_combined
actions+=/call_action_list,name=cds
actions+=/call_action_list,name=maintain
actions+=/call_action_list,name=finish,if=(!talent.exsanguinate.enabled|cooldown.exsanguinate.remains>2)&(!dot.rupture.refreshable|(dot.rupture.exsanguinated&dot.rupture.remains>=3.5)|target.time_to_die-dot.rupture.remains<=6)&active_dot.rupture>=spell_targets.rupture
actions+=/call_action_list,name=build,if=combo_points.deficit>1|energy.deficit<=25+variable.energy_regen_combined
actions.build=hemorrhage,if=refreshable
actions.build+=/hemorrhage,cycle_targets=1,if=refreshable&dot.rupture.ticking&spell_targets.fan_of_knives<2+talent.agonizing_poison.enabled+equipped.insignia_of_ravenholdt
actions.build+=/fan_of_knives,if=spell_targets>=2+talent.agonizing_poison.enabled+equipped.insignia_of_ravenholdt|buff.the_dreadlords_deceit.stack>=29
actions.build+=/mutilate,cycle_targets=1,if=(!talent.agonizing_poison.enabled&dot.deadly_poison_dot.refreshable)|(talent.agonizing_poison.enabled&debuff.agonizing_poison.remains<debuff.agonizing_poison.duration*0.3)
actions.build+=/mutilate
actions.build+=/poisoned_knife,cycle_targets=1,if=talent.agonizing_poison.enabled&debuff.agonizing_poison.remains<debuff.agonizing_poison.duration*0.3&debuff.agonizing_poison.stack>=5
actions.cds=potion,name=old_war,if=buff.bloodlust.react|target.time_to_die<=25|debuff.vendetta.up&cooldown.vanish.remains<5
actions.cds+=/use_item,name=draught_of_souls,if=energy.deficit>=35+variable.energy_regen_combined*2&(!equipped.mantle_of_the_master_assassin|cooldown.vanish.remains>8)&(!talent.agonizing_poison.enabled|debuff.agonizing_poison.stack>=5&debuff.surge_of_toxins.remains>=3)
actions.cds+=/use_item,name=draught_of_souls,if=mantle_duration>0&mantle_duration<3.5&dot.kingsbane.ticking
actions.cds+=/blood_fury,if=debuff.vendetta.up
actions.cds+=/berserking,if=debuff.vendetta.up
actions.cds+=/arcane_torrent,if=dot.kingsbane.ticking&!buff.envenom.up&energy.deficit>=15+variable.energy_regen_combined*gcd.remains*1.1
actions.cds+=/marked_for_death,target_if=min:target.time_to_die,if=target.time_to_die<combo_points.deficit*1.5|(raid_event.adds.in>40&combo_points.deficit>=cp_max_spend)
actions.cds+=/vendetta,if=!artifact.urge_to_kill.enabled|energy.deficit>=60+variable.energy_regen_combined
actions.cds+=/vanish,if=talent.nightstalker.enabled&combo_points>=cp_max_spend&!talent.exsanguinate.enabled&((equipped.mantle_of_the_master_assassin&set_bonus.tier19_4pc&mantle_duration=0)|((!equipped.mantle_of_the_master_assassin|!set_bonus.tier19_4pc)&(dot.rupture.refreshable|debuff.vendetta.up)))
actions.cds+=/vanish,if=talent.nightstalker.enabled&combo_points>=cp_max_spend&talent.exsanguinate.enabled&cooldown.exsanguinate.remains<1&(dot.rupture.ticking|time>10)
actions.cds+=/vanish,if=talent.subterfuge.enabled&equipped.mantle_of_the_master_assassin&(debuff.vendetta.up|target.time_to_die<10)&mantle_duration=0
actions.cds+=/vanish,if=talent.subterfuge.enabled&!equipped.mantle_of_the_master_assassin&!stealthed.rogue&dot.garrote.refreshable&((spell_targets.fan_of_knives<=3&combo_points.deficit>=1+spell_targets.fan_of_knives)|(spell_targets.fan_of_knives>=4&combo_points.deficit>=4))
actions.cds+=/vanish,if=talent.shadow_focus.enabled&variable.energy_time_to_max_combined>=2&combo_points.deficit>=4
actions.cds+=/exsanguinate,if=prev_gcd.1.rupture&dot.rupture.remains>4+4*cp_max_spend
actions.finish=death_from_above,if=combo_points>=5
actions.finish+=/envenom,if=combo_points>=4&(debuff.vendetta.up|mantle_duration>=gcd.remains+0.2|debuff.surge_of_toxins.remains<gcd.remains+0.2|energy.deficit<=25+variable.energy_regen_combined)
actions.finish+=/envenom,if=talent.elaborate_planning.enabled&combo_points>=3+!talent.exsanguinate.enabled&buff.elaborate_planning.remains<gcd.remains+0.2
actions.kb=kingsbane,if=artifact.sinister_circulation.enabled&!(equipped.duskwalkers_footpads&equipped.convergence_of_fates&artifact.master_assassin.rank>=6)&(time>25|!equipped.mantle_of_the_master_assassin|(debuff.vendetta.up&debuff.surge_of_toxins.up))&(talent.subterfuge.enabled|!stealthed.rogue|(talent.nightstalker.enabled&(!equipped.mantle_of_the_master_assassin|!set_bonus.tier19_4pc)))
actions.kb+=/kingsbane,if=!talent.exsanguinate.enabled&buff.envenom.up&((debuff.vendetta.up&debuff.surge_of_toxins.up)|cooldown.vendetta.remains<=5.8|cooldown.vendetta.remains>=10)
actions.kb+=/kingsbane,if=talent.exsanguinate.enabled&dot.rupture.exsanguinated
actions.maintain=rupture,if=talent.nightstalker.enabled&stealthed.rogue&(!equipped.mantle_of_the_master_assassin|!set_bonus.tier19_4pc)&(talent.exsanguinate.enabled|target.time_to_die-remains>4)
actions.maintain+=/garrote,cycle_targets=1,if=talent.subterfuge.enabled&stealthed.rogue&combo_points.deficit>=1&refreshable&(!exsanguinated|remains<=tick_time*2)&target.time_to_die-remains>2
actions.maintain+=/garrote,cycle_targets=1,if=talent.subterfuge.enabled&stealthed.rogue&combo_points.deficit>=1&remains<=10&pmultiplier<=1&!exsanguinated&target.time_to_die-remains>2
actions.maintain+=/rupture,if=!talent.exsanguinate.enabled&combo_points>=3&!ticking&mantle_duration<=gcd.remains+0.2&target.time_to_die>6
actions.maintain+=/rupture,if=talent.exsanguinate.enabled&((combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1)|(!ticking&(time>10|combo_points>=2+artifact.urge_to_kill.enabled)))
actions.maintain+=/rupture,cycle_targets=1,if=combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time)&(!exsanguinated|remains<=tick_time*2)&target.time_to_die-remains>6
actions.maintain+=/call_action_list,name=kb,if=combo_points.deficit>=1+(mantle_duration>=gcd.remains+0.2)
actions.maintain+=/pool_resource,for_next=1
actions.maintain+=/garrote,cycle_targets=1,if=(!talent.subterfuge.enabled|!(cooldown.vanish.up&cooldown.vendetta.remains<=4))&combo_points.deficit>=1&refreshable&(pmultiplier<=1|remains<=tick_time)&(!exsanguinated|remains<=tick_time*2)&target.time_to_die-remains>4
]])

TJ:RegisterActionProfileList('simc::rogue::outlaw', 'Simulationcraft Rogue Profile: Outlaw', 4, 2, [[
actions.precombat=flask,name=flask_of_the_seventh_demon
actions.precombat+=/augmentation,name=defiled
actions.precombat+=/food,name=lavish_suramar_feast
actions.precombat+=/snapshot_stats
actions.precombat+=/stealth
actions.precombat+=/potion,name=prolonged_power
actions.precombat+=/marked_for_death,if=raid_event.adds.in>40
actions.precombat+=/roll_the_bones,if=!talent.slice_and_dice.enabled
actions=variable,name=rtb_reroll,value=!talent.slice_and_dice.enabled&(rtb_buffs<=2&!rtb_list.any.6)
actions+=/variable,name=ss_useable_noreroll,value=(combo_points<5+talent.deeper_stratagem.enabled-(buff.broadsides.up|buff.jolly_roger.up)-(talent.alacrity.enabled&buff.alacrity.stack<=4))
actions+=/variable,name=ss_useable,value=(talent.anticipation.enabled&combo_points<4)|(!talent.anticipation.enabled&((variable.rtb_reroll&combo_points<4+talent.deeper_stratagem.enabled)|(!variable.rtb_reroll&variable.ss_useable_noreroll)))
actions+=/call_action_list,name=bf
actions+=/call_action_list,name=cds
actions+=/call_action_list,name=stealth,if=stealthed.rogue|cooldown.vanish.up|cooldown.shadowmeld.up
actions+=/death_from_above,if=energy.time_to_max>2&!variable.ss_useable_noreroll
actions+=/slice_and_dice,if=!variable.ss_useable&buff.slice_and_dice.remains<target.time_to_die&buff.slice_and_dice.remains<(1+combo_points)*1.8
actions+=/roll_the_bones,if=!variable.ss_useable&buff.roll_the_bones.remains<target.time_to_die&(buff.roll_the_bones.remains<=3|variable.rtb_reroll)
actions+=/killing_spree,if=energy.time_to_max>5|energy<15
actions+=/call_action_list,name=build
actions+=/call_action_list,name=finish,if=!variable.ss_useable
actions+=/gouge,if=talent.dirty_tricks.enabled&combo_points.deficit>=1
actions.bf=cancel_buff,name=blade_flurry,if=equipped.shivarran_symmetry&cooldown.blade_flurry.up&buff.blade_flurry.up&spell_targets.blade_flurry>=2|spell_targets.blade_flurry<2&buff.blade_flurry.up
actions.bf+=/blade_flurry,if=spell_targets.blade_flurry>=2&!buff.blade_flurry.up
actions.build=ghostly_strike,if=combo_points.deficit>=1+buff.broadsides.up&!buff.curse_of_the_dreadblades.up&(debuff.ghostly_strike.remains<debuff.ghostly_strike.duration*0.3|(cooldown.curse_of_the_dreadblades.remains<3&debuff.ghostly_strike.remains<14))&(combo_points>=3|(variable.rtb_reroll&time>=10))
actions.build+=/pistol_shot,if=combo_points.deficit>=1+buff.broadsides.up&buff.opportunity.up&(energy.time_to_max>2-talent.quick_draw.enabled|(buff.blunderbuss.up&buff.greenskins_waterlogged_wristcuffs.up))
actions.build+=/saber_slash,if=variable.ss_useable
actions.cds=potion,name=prolonged_power,if=buff.bloodlust.react|target.time_to_die<=25|buff.adrenaline_rush.up
actions.cds+=/blood_fury
actions.cds+=/berserking
actions.cds+=/arcane_torrent,if=energy.deficit>40
actions.cds+=/cannonball_barrage,if=spell_targets.cannonball_barrage>=1
actions.cds+=/adrenaline_rush,if=!buff.adrenaline_rush.up&energy.deficit>0
actions.cds+=/marked_for_death,target_if=min:target.time_to_die,if=target.time_to_die<combo_points.deficit|((raid_event.adds.in>40|buff.true_bearing.remains>15)&combo_points.deficit>=cp_max_spend-1)
actions.cds+=/sprint,if=equipped.thraxis_tricksy_treads&!variable.ss_useable
actions.cds+=/darkflight,if=equipped.thraxis_tricksy_treads&!variable.ss_useable&buff.sprint.down
actions.cds+=/curse_of_the_dreadblades,if=combo_points.deficit>=4&(!talent.ghostly_strike.enabled|debuff.ghostly_strike.up)
actions.finish=between_the_eyes,if=equipped.greenskins_waterlogged_wristcuffs&!buff.greenskins_waterlogged_wristcuffs.up
actions.finish+=/run_through,if=!talent.death_from_above.enabled|energy.time_to_max<cooldown.death_from_above.remains+3.5
actions.stealth=variable,name=stealth_condition,value=combo_points.deficit>=2+2*(talent.ghostly_strike.enabled&!debuff.ghostly_strike.up)+buff.broadsides.up&energy>60&!buff.jolly_roger.up&!buff.hidden_blade.up&!buff.curse_of_the_dreadblades.up
actions.stealth+=/ambush
actions.stealth+=/vanish,if=(equipped.mantle_of_the_master_assassin&buff.true_bearing.up)|variable.stealth_condition
actions.stealth+=/shadowmeld,if=variable.stealth_condition
]])

TJ:RegisterActionProfileList('simc::rogue::subtlety', 'Simulationcraft Rogue Profile: Subtlety', 4, 3, [[
actions.precombat=flask,name=flask_of_the_seventh_demon
actions.precombat+=/augmentation,name=defiled
actions.precombat+=/food,name=lavish_suramar_feast
actions.precombat+=/snapshot_stats
actions.precombat+=/stealth
actions.precombat+=/potion,name=prolonged_power
actions.precombat+=/marked_for_death,if=raid_event.adds.in>40
actions.precombat+=/variable,name=ssw_refund,value=equipped.shadow_satyrs_walk*(6+ssw_refund_offset)
actions.precombat+=/variable,name=stealth_threshold,value=(15+talent.vigor.enabled*35+talent.master_of_shadows.enabled*(25+ptr*15)+variable.ssw_refund)
actions.precombat+=/variable,name=shd_fractionnal,value=ptr*(1.725+0.6*talent.enveloping_shadows.enabled)+(1-ptr)*2.45
actions.precombat+=/enveloping_shadows,if=combo_points>=5&ptr=0
actions.precombat+=/shadow_dance,if=talent.subterfuge.enabled&bugs
actions.precombat+=/symbols_of_death
actions=run_action_list,name=ptr_default,if=ptr
actions+=/run_action_list,name=sprinted,if=buff.faster_than_light_trigger.up
actions+=/call_action_list,name=cds
actions+=/run_action_list,name=stealthed,if=stealthed.all
actions+=/nightblade,if=target.time_to_die>8&remains<gcd.max&combo_points>=4
actions+=/sprint,if=!equipped.draught_of_souls&mantle_duration=0&energy.time_to_max>=1.5&cooldown.shadow_dance.charges_fractional<variable.shd_fractionnal&!cooldown.vanish.up&target.time_to_die>=8&(dot.nightblade.remains>=14|target.time_to_die<=45)
actions+=/sprint,if=equipped.draught_of_souls&trinket.cooldown.up&mantle_duration=0
actions+=/call_action_list,name=stealth_als,if=(combo_points.deficit>=2+talent.premeditation.enabled|cooldown.shadow_dance.charges_fractional>=2.9)
actions+=/call_action_list,name=finish,if=combo_points>=5|(combo_points>=4&combo_points.deficit<=2&spell_targets.shuriken_storm>=3&spell_targets.shuriken_storm<=4)
actions+=/call_action_list,name=build,if=energy.deficit<=variable.stealth_threshold
actions.build=shuriken_storm,if=spell_targets.shuriken_storm>=2
actions.build+=/gloomblade
actions.build+=/backstab
actions.cds=potion,name=old_war,if=buff.bloodlust.react|target.time_to_die<=25|buff.shadow_blades.up
actions.cds+=/blood_fury,if=stealthed.rogue
actions.cds+=/berserking,if=stealthed.rogue
actions.cds+=/arcane_torrent,if=stealthed.rogue&energy.deficit>70
actions.cds+=/shadow_blades,if=combo_points.deficit>=2+stealthed.all-equipped.mantle_of_the_master_assassin&(cooldown.sprint.remains>buff.shadow_blades.duration*0.5|mantle_duration>0|cooldown.shadow_dance.charges_fractional>variable.shd_fractionnal|cooldown.vanish.up|target.time_to_die<=buff.shadow_blades.duration*1.1)
actions.cds+=/goremaws_bite,if=combo_points.deficit>=2+stealthed.all-equipped.mantle_of_the_master_assassin&(cooldown.sprint.remains>buff.shadow_blades.duration*(0.4+equipped.denial_of_the_halfgiants*0.2)|mantle_duration>0|cooldown.shadow_dance.charges_fractional>variable.shd_fractionnal|cooldown.vanish.up|target.time_to_die<=buff.shadow_blades.duration*1.1)
actions.cds+=/marked_for_death,target_if=min:target.time_to_die,if=target.time_to_die<combo_points.deficit|(raid_event.adds.in>40&combo_points.deficit>=cp_max_spend)
actions.finish=enveloping_shadows,if=buff.enveloping_shadows.remains<target.time_to_die&buff.enveloping_shadows.remains<=combo_points*1.8
actions.finish+=/death_from_above,if=spell_targets.death_from_above>=5
actions.finish+=/nightblade,if=target.time_to_die-remains>8&(mantle_duration=0|remains<=mantle_duration)&((refreshable&(!finality|buff.finality_nightblade.up))|remains<tick_time*2)
actions.finish+=/nightblade,cycle_targets=1,if=target.time_to_die-remains>8&mantle_duration=0&((refreshable&(!finality|buff.finality_nightblade.up))|remains<tick_time*2)
actions.finish+=/death_from_above
actions.finish+=/eviscerate
actions.ptr_build=shuriken_storm,if=spell_targets.shuriken_storm>=2
actions.ptr_build+=/gloomblade
actions.ptr_build+=/backstab
actions.ptr_cds=potion,name=old_war,if=buff.bloodlust.react|target.time_to_die<=25|buff.shadow_blades.up
actions.ptr_cds+=/use_item,name=draught_of_souls,if=!stealthed.rogue&energy.deficit>30+talent.vigor.enabled*10
actions.ptr_cds+=/blood_fury,if=stealthed.rogue
actions.ptr_cds+=/berserking,if=stealthed.rogue
actions.ptr_cds+=/arcane_torrent,if=stealthed.rogue&energy.deficit>70
actions.ptr_cds+=/symbols_of_death,if=!stealthed.all
actions.ptr_cds+=/shadow_blades,if=combo_points.deficit>=2+stealthed.all-equipped.mantle_of_the_master_assassin
actions.ptr_cds+=/goremaws_bite,if=!stealthed.all&cooldown.shadow_dance.charges_fractional<=variable.shd_fractionnal&((combo_points.deficit>=4-(time<10)*2&energy.deficit>50+talent.vigor.enabled*25-(time>=10)*15)|(combo_points.deficit>=1&target.time_to_die<8))
actions.ptr_cds+=/marked_for_death,target_if=min:target.time_to_die,if=target.time_to_die<combo_points.deficit|(raid_event.adds.in>40&combo_points.deficit>=cp_max_spend)
actions.ptr_default=call_action_list,name=ptr_cds
actions.ptr_default+=/run_action_list,name=ptr_stealthed,if=stealthed.all
actions.ptr_default+=/nightblade,if=target.time_to_die>8&remains<gcd.max&combo_points>=4
actions.ptr_default+=/call_action_list,name=ptr_stealth_als,if=(combo_points.deficit>=2+talent.premeditation.enabled|cooldown.shadow_dance.charges_fractional>=2.9)
actions.ptr_default+=/call_action_list,name=ptr_finish,if=combo_points>=5|(combo_points>=4&combo_points.deficit<=2&spell_targets.shuriken_storm>=3&spell_targets.shuriken_storm<=4)
actions.ptr_default+=/call_action_list,name=ptr_build,if=energy.deficit<=variable.stealth_threshold
actions.ptr_finish=death_from_above,if=spell_targets.death_from_above>=5
actions.ptr_finish+=/nightblade,if=target.time_to_die-remains>8&(mantle_duration=0|remains<=mantle_duration)&((refreshable&(!finality|buff.finality_nightblade.up))|remains<tick_time*2)
actions.ptr_finish+=/nightblade,cycle_targets=1,if=target.time_to_die-remains>8&mantle_duration=0&((refreshable&(!finality|buff.finality_nightblade.up))|remains<tick_time*2)
actions.ptr_finish+=/death_from_above
actions.ptr_finish+=/eviscerate
actions.ptr_stealth_als=call_action_list,name=ptr_stealth_cds,if=energy.deficit<=variable.stealth_threshold&(!equipped.shadow_satyrs_walk|cooldown.shadow_dance.charges_fractional>=variable.shd_fractionnal|energy.deficit>=10)
actions.ptr_stealth_als+=/call_action_list,name=ptr_stealth_cds,if=mantle_duration>2.3
actions.ptr_stealth_als+=/call_action_list,name=ptr_stealth_cds,if=spell_targets.shuriken_storm>=5
actions.ptr_stealth_als+=/call_action_list,name=ptr_stealth_cds,if=(cooldown.shadowmeld.up&!cooldown.vanish.up&cooldown.shadow_dance.charges<=1)
actions.ptr_stealth_als+=/call_action_list,name=ptr_stealth_cds,if=target.time_to_die<12*cooldown.shadow_dance.charges_fractional*(1+equipped.shadow_satyrs_walk*0.5)
actions.ptr_stealth_cds=vanish,if=mantle_duration=0&cooldown.shadow_dance.charges_fractional<variable.shd_fractionnal+(equipped.mantle_of_the_master_assassin&time<30)*0.3
actions.ptr_stealth_cds+=/shadow_dance,if=charges_fractional>=variable.shd_fractionnal
actions.ptr_stealth_cds+=/pool_resource,for_next=1,extra_amount=40
actions.ptr_stealth_cds+=/shadowmeld,if=energy>=40&energy.deficit>=10+variable.ssw_refund
actions.ptr_stealth_cds+=/shadow_dance,if=combo_points.deficit>=2+(buff.shadowstrike.up|talent.subterfuge.enabled)*2
actions.ptr_stealthed=call_action_list,name=ptr_finish,if=combo_points>=5&(spell_targets.shuriken_storm>=2+talent.premeditation.enabled+equipped.shadow_satyrs_walk|(mantle_duration<=1.3&mantle_duration-gcd.remains>=0.3))
actions.ptr_stealthed+=/shuriken_storm,if=buff.shadowmeld.down&((combo_points.deficit>=3&spell_targets.shuriken_storm>=2+talent.premeditation.enabled+equipped.shadow_satyrs_walk)|(combo_points.deficit>=1+buff.shadow_blades.up&buff.the_dreadlords_deceit.stack>=29))
actions.ptr_stealthed+=/call_action_list,name=ptr_finish,if=combo_points>=5&combo_points.deficit<2+talent.premeditation.enabled+buff.shadow_blades.up-equipped.mantle_of_the_master_assassin
actions.ptr_stealthed+=/shadowstrike
actions.sprinted=cancel_autoattack
actions.sprinted+=/use_item,name=draught_of_souls
actions.stealth_als=call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold&(!equipped.shadow_satyrs_walk|cooldown.shadow_dance.charges_fractional>=variable.shd_fractionnal|energy.deficit>=10)
actions.stealth_als+=/call_action_list,name=stealth_cds,if=mantle_duration>2.3
actions.stealth_als+=/call_action_list,name=stealth_cds,if=spell_targets.shuriken_storm>=5
actions.stealth_als+=/call_action_list,name=stealth_cds,if=(cooldown.shadowmeld.up&!cooldown.vanish.up&cooldown.shadow_dance.charges<=1)
actions.stealth_als+=/call_action_list,name=stealth_cds,if=target.time_to_die<12*cooldown.shadow_dance.charges_fractional*(1+equipped.shadow_satyrs_walk*0.5)
actions.stealth_cds=vanish,if=mantle_duration=0&cooldown.shadow_dance.charges_fractional<variable.shd_fractionnal+(equipped.mantle_of_the_master_assassin&time<30)*0.3
actions.stealth_cds+=/shadow_dance,if=charges_fractional>=variable.shd_fractionnal
actions.stealth_cds+=/pool_resource,for_next=1,extra_amount=40
actions.stealth_cds+=/shadowmeld,if=energy>=40&energy.deficit>=10+variable.ssw_refund
actions.stealth_cds+=/shadow_dance,if=combo_points.deficit>=5-talent.vigor.enabled
actions.stealthed=symbols_of_death,if=buff.symbols_of_death.remains<target.time_to_die&buff.symbols_of_death.remains<=buff.symbols_of_death.duration*0.3&(mantle_duration=0|buff.symbols_of_death.remains<=mantle_duration)
actions.stealthed+=/call_action_list,name=finish,if=combo_points>=5&(spell_targets.shuriken_storm>=2+talent.premeditation.enabled+equipped.shadow_satyrs_walk|(mantle_duration<=1.3&mantle_duration-gcd.remains>=0.3))
actions.stealthed+=/shuriken_storm,if=buff.shadowmeld.down&((combo_points.deficit>=3&spell_targets.shuriken_storm>=2+talent.premeditation.enabled+equipped.shadow_satyrs_walk)|(combo_points.deficit>=1+buff.shadow_blades.up&buff.the_dreadlords_deceit.stack>=29))
actions.stealthed+=/call_action_list,name=finish,if=combo_points>=5&combo_points.deficit<2+talent.premeditation.enabled+buff.shadow_blades.up-equipped.mantle_of_the_master_assassin
actions.stealthed+=/shadowstrike
]])

