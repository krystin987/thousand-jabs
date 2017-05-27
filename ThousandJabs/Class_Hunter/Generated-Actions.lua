if select(3, UnitClass('player')) ~= 3 then return end

local TJ = LibStub('AceAddon-3.0'):GetAddon('ThousandJabs')

TJ:RegisterActionProfileList('simc::hunter::beast_mastery', 'Simulationcraft Hunter Profile: Beast Mastery', 3, 1, [[
actions.precombat=flask
actions.precombat+=/augmentation
actions.precombat+=/food
actions.precombat+=/summon_pet
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions=auto_shot
actions+=/counter_shot,if=target.debuff.casting.react
actions+=/arcane_torrent,if=focus.deficit>=30
actions+=/berserking
actions+=/blood_fury
actions+=/volley,toggle=on
actions+=/potion,if=buff.bestial_wrath.remains|!cooldown.bestial_wrath.remains
actions+=/a_murder_of_crows
actions+=/stampede,if=buff.bloodlust.up|buff.bestial_wrath.up|cooldown.bestial_wrath.remains<=2|target.time_to_die<=14
actions+=/dire_beast,if=cooldown.bestial_wrath.remains>3
actions+=/dire_frenzy,if=(cooldown.bestial_wrath.remains>6&(!equipped.the_mantle_of_command|pet.cat.buff.dire_frenzy.remains<=gcd.max*1.2))|(charges>=2&focus.deficit>=25+talent.dire_stable.enabled*12)|target.time_to_die<9
actions+=/aspect_of_the_wild,if=buff.bestial_wrath.up|target.time_to_die<12
actions+=/barrage,if=spell_targets.barrage>1
actions+=/bestial_wrath
actions+=/titans_thunder,if=(talent.dire_frenzy.enabled&(buff.bestial_wrath.up|cooldown.bestial_wrath.remains>35))|cooldown.dire_beast.remains>=3|(buff.bestial_wrath.up&pet.dire_beast.active)
actions+=/multishot,if=spell_targets>4&(pet.cat.buff.beast_cleave.remains<gcd.max|pet.cat.buff.beast_cleave.down)
actions+=/kill_command
actions+=/multishot,if=spell_targets>1&(pet.cat.buff.beast_cleave.remains<gcd.max*2|pet.cat.buff.beast_cleave.down)
actions+=/chimaera_shot,if=focus<90
actions+=/cobra_shot,if=(cooldown.kill_command.remains>focus.time_to_max&cooldown.bestial_wrath.remains>focus.time_to_max)|(buff.bestial_wrath.up&focus.regen*cooldown.kill_command.remains>30)|target.time_to_die<cooldown.kill_command.remains
]])

TJ:RegisterActionProfileList('simc::hunter::marksmanship', 'Simulationcraft Hunter Profile: Marksmanship', 3, 2, [[
actions.precombat=flask
actions.precombat+=/augmentation
actions.precombat+=/food
actions.precombat+=/summon_pet
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions.precombat+=/windburst
actions=auto_shot
actions+=/counter_shot,if=target.debuff.casting.react
actions+=/volley,toggle=on
actions+=/variable,name=pooling_for_piercing,value=talent.piercing_shot.enabled&cooldown.piercing_shot.remains<5&lowest_vuln_within.5>0&lowest_vuln_within.5>cooldown.piercing_shot.remains&(buff.trueshot.down|spell_targets=1)
actions+=/variable,name=waiting_for_sentinel,value=talent.sentinel.enabled&(buff.marking_targets.up|buff.trueshot.up)&!cooldown.sentinel.up&((cooldown.sentinel.remains>54&cooldown.sentinel.remains<(54+gcd.max))|(cooldown.sentinel.remains>48&cooldown.sentinel.remains<(48+gcd.max))|(cooldown.sentinel.remains>42&cooldown.sentinel.remains<(42+gcd.max)))
actions+=/call_action_list,name=cooldowns
actions+=/call_action_list,name=patient_sniper,if=talent.patient_sniper.enabled
actions+=/call_action_list,name=non_patient_sniper,if=!talent.patient_sniper.enabled
actions.cooldowns=arcane_torrent,if=focus.deficit>=30&(!talent.sidewinders.enabled|cooldown.sidewinders.charges<2)
actions.cooldowns+=/berserking,if=buff.trueshot.up
actions.cooldowns+=/blood_fury,if=buff.trueshot.up
actions.cooldowns+=/potion,if=(buff.trueshot.react&buff.bloodlust.react)|buff.bullseye.react>=23|((consumable.prolonged_power&target.time_to_die<62)|target.time_to_die<31)
actions.cooldowns+=/variable,name=trueshot_cooldown,op=set,value=time*1.1,if=time>15&cooldown.trueshot.up&variable.trueshot_cooldown=0
actions.cooldowns+=/trueshot,if=variable.trueshot_cooldown=0|buff.bloodlust.up|(variable.trueshot_cooldown>0&target.time_to_die>(variable.trueshot_cooldown+duration))|buff.bullseye.react>25|target.time_to_die<16
actions.non_patient_sniper=explosive_shot
actions.non_patient_sniper+=/piercing_shot,if=lowest_vuln_within.5>0&focus>100
actions.non_patient_sniper+=/aimed_shot,if=spell_targets>1&debuff.vulnerability.remains>cast_time&talent.trick_shot.enabled&buff.sentinels_sight.stack=20
actions.non_patient_sniper+=/marked_shot,if=spell_targets>1
actions.non_patient_sniper+=/multishot,if=spell_targets>1&(buff.marking_targets.up|buff.trueshot.up)
actions.non_patient_sniper+=/sentinel,if=!debuff.hunters_mark.up
actions.non_patient_sniper+=/black_arrow,if=talent.sidewinders.enabled|spell_targets.multishot<6
actions.non_patient_sniper+=/a_murder_of_crows
actions.non_patient_sniper+=/windburst
actions.non_patient_sniper+=/barrage,if=spell_targets>2|(target.health.pct<20&buff.bullseye.stack<25)
actions.non_patient_sniper+=/marked_shot,if=buff.marking_targets.up|buff.trueshot.up
actions.non_patient_sniper+=/sidewinders,if=!variable.waiting_for_sentinel&(debuff.hunters_mark.down|(buff.trueshot.down&buff.marking_targets.down))&((buff.marking_targets.up|buff.trueshot.up)|charges_fractional>1.8)&(focus.deficit>cast_regen)
actions.non_patient_sniper+=/aimed_shot,if=talent.sidewinders.enabled&debuff.vulnerability.remains>cast_time
actions.non_patient_sniper+=/aimed_shot,if=!talent.sidewinders.enabled&debuff.vulnerability.remains>cast_time&(!variable.pooling_for_piercing|(buff.lock_and_load.up&lowest_vuln_within.5>gcd.max))&(spell_targets.multishot<4|talent.trick_shot.enabled|buff.sentinels_sight.stack=20)
actions.non_patient_sniper+=/marked_shot
actions.non_patient_sniper+=/aimed_shot,if=talent.sidewinders.enabled&spell_targets.multi_shot=1&focus>110
actions.non_patient_sniper+=/multishot,if=spell_targets.multi_shot>1&!variable.waiting_for_sentinel
actions.non_patient_sniper+=/arcane_shot,if=spell_targets.multi_shot<2&!variable.waiting_for_sentinel
actions.patient_sniper=variable,name=vuln_window,op=setif,value=cooldown.sidewinders.full_recharge_time,value_else=debuff.vulnerability.remains,condition=talent.sidewinders.enabled&cooldown.sidewinders.full_recharge_time<variable.vuln_window
actions.patient_sniper+=/variable,name=vuln_aim_casts,op=set,value=floor(variable.vuln_window%action.aimed_shot.execute_time)
actions.patient_sniper+=/variable,name=vuln_aim_casts,op=set,value=floor((focus+action.aimed_shot.cast_regen*(variable.vuln_aim_casts-1))%action.aimed_shot.cost),if=variable.vuln_aim_casts>0&variable.vuln_aim_casts>floor((focus+action.aimed_shot.cast_regen*(variable.vuln_aim_casts-1))%action.aimed_shot.cost)
actions.patient_sniper+=/variable,name=can_gcd,value=variable.vuln_window>variable.vuln_aim_casts*action.aimed_shot.execute_time+gcd.max
actions.patient_sniper+=/call_action_list,name=targetdie,if=target.time_to_die<variable.vuln_window&spell_targets.multishot=1
actions.patient_sniper+=/piercing_shot,if=cooldown.piercing_shot.up&spell_targets=1&lowest_vuln_within.5>0&lowest_vuln_within.5<1
actions.patient_sniper+=/piercing_shot,if=cooldown.piercing_shot.up&spell_targets>1&lowest_vuln_within.5>0&((!buff.trueshot.up&focus>80&(lowest_vuln_within.5<1|debuff.hunters_mark.up))|(buff.trueshot.up&focus>105&lowest_vuln_within.5<6))
actions.patient_sniper+=/aimed_shot,if=spell_targets>1&debuff.vulnerability.remains>cast_time&talent.trick_shot.enabled&(buff.sentinels_sight.stack=20|(buff.trueshot.up&buff.sentinels_sight.stack>=spell_targets.multishot*5))
actions.patient_sniper+=/marked_shot,if=spell_targets>1
actions.patient_sniper+=/multishot,if=spell_targets>1&(buff.marking_targets.up|buff.trueshot.up)
actions.patient_sniper+=/windburst,if=variable.vuln_aim_casts<1&!variable.pooling_for_piercing
actions.patient_sniper+=/black_arrow,if=variable.can_gcd&(talent.sidewinders.enabled|spell_targets.multishot<6)&(!variable.pooling_for_piercing|(lowest_vuln_within.5>gcd.max&focus>85))
actions.patient_sniper+=/a_murder_of_crows,if=(!variable.pooling_for_piercing|lowest_vuln_within.5>gcd.max)&(target.time_to_die>=cooldown+duration|target.health.pct<20|target.time_to_die<16)
actions.patient_sniper+=/barrage,if=spell_targets>2|(target.health.pct<20&buff.bullseye.stack<25)
actions.patient_sniper+=/aimed_shot,if=debuff.vulnerability.up&buff.lock_and_load.up&(!variable.pooling_for_piercing|lowest_vuln_within.5>gcd.max)&(spell_targets.multi_shot<4|talent.trick_shot.enabled)
actions.patient_sniper+=/aimed_shot,if=spell_targets.multishot>1&debuff.vulnerability.remains>execute_time&(!variable.pooling_for_piercing|(focus>100&lowest_vuln_within.5>(execute_time+gcd.max)))&(spell_targets.multishot<4|buff.sentinels_sight.stack=20|talent.trick_shot.enabled)
actions.patient_sniper+=/multishot,if=spell_targets>1&variable.can_gcd&focus+cast_regen+action.aimed_shot.cast_regen<focus.max&(!variable.pooling_for_piercing|lowest_vuln_within.5>gcd.max)
actions.patient_sniper+=/arcane_shot,if=spell_targets.multi_shot=1&variable.vuln_aim_casts>0&variable.can_gcd&focus+cast_regen+action.aimed_shot.cast_regen<focus.max&(!variable.pooling_for_piercing|lowest_vuln_within.5>gcd.max)
actions.patient_sniper+=/aimed_shot,if=talent.sidewinders.enabled&(debuff.vulnerability.remains>cast_time|(buff.lock_and_load.down&action.windburst.in_flight))&(variable.vuln_window-(execute_time*variable.vuln_aim_casts)<1|focus.deficit<25|buff.trueshot.up)&(spell_targets.multishot=1|focus>100)
actions.patient_sniper+=/aimed_shot,if=!talent.sidewinders.enabled&debuff.vulnerability.remains>cast_time&(!variable.pooling_for_piercing|(focus>100&lowest_vuln_within.5>(execute_time+gcd.max)))
actions.patient_sniper+=/marked_shot,if=!talent.sidewinders.enabled&!variable.pooling_for_piercing&(focus>=70|buff.trueshot.up)&!action.windburst.in_flight
actions.patient_sniper+=/marked_shot,if=talent.sidewinders.enabled&(variable.vuln_aim_casts<1|buff.trueshot.up|variable.vuln_window<action.aimed_shot.cast_time)
actions.patient_sniper+=/aimed_shot,if=spell_targets.multi_shot=1&focus>110
actions.patient_sniper+=/sidewinders,if=(!debuff.hunters_mark.up|(!buff.marking_targets.up&!buff.trueshot.up))&((buff.marking_targets.up&variable.vuln_aim_casts<1)|buff.trueshot.up|charges_fractional>1.9)
actions.patient_sniper+=/arcane_shot,if=spell_targets.multi_shot=1&(!variable.pooling_for_piercing|lowest_vuln_within.5>gcd.max)
actions.patient_sniper+=/multishot,if=spell_targets>1&(!variable.pooling_for_piercing|lowest_vuln_within.5>gcd.max)
actions.targetdie=piercing_shot,if=debuff.vulnerability.up
actions.targetdie+=/windburst
actions.targetdie+=/aimed_shot,if=debuff.vulnerability.remains>cast_time&target.time_to_die>cast_time
actions.targetdie+=/marked_shot
actions.targetdie+=/arcane_shot
actions.targetdie+=/sidewinders
]])

TJ:RegisterActionProfileList('simc::hunter::survival', 'Simulationcraft Hunter Profile: Survival', 3, 3, [[
actions.precombat=flask
actions.precombat+=/augmentation
actions.precombat+=/food
actions.precombat+=/summon_pet
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions.precombat+=/explosive_trap
actions.precombat+=/steel_trap
actions.precombat+=/dragonsfire_grenade
actions.precombat+=/harpoon
actions=auto_attack
actions+=/muzzle,if=target.debuff.casting.react
actions+=/call_action_list,name=mokMaintain,if=talent.way_of_the_moknathal.enabled
actions+=/call_action_list,name=CDs,if=buff.moknathal_tactics.stack>=2|!talent.way_of_the_moknathal.enabled
actions+=/call_action_list,name=preBitePhase,if=!buff.mongoose_fury.up
actions+=/call_action_list,name=aoe,if=active_enemies>=3
actions+=/call_action_list,name=bitePhase
actions+=/call_action_list,name=biteFill
actions+=/call_action_list,name=fillers
actions.CDs=arcane_torrent,if=focus<=30
actions.CDs+=/berserking,if=buff.aspect_of_the_eagle.up
actions.CDs+=/blood_fury,if=buff.aspect_of_the_eagle.up
actions.CDs+=/potion,if=buff.aspect_of_the_eagle.up
actions.CDs+=/berserking,if=buff.aspect_of_the_eagle.up
actions.CDs+=/snake_hunter,if=cooldown.mongoose_bite.charges=0&buff.mongoose_fury.remains>3*gcd
actions.CDs+=/aspect_of_the_eagle,if=(buff.mongoose_fury.remains<=11&buff.mongoose_fury.up)&(cooldown.fury_of_the_eagle.remains>buff.mongoose_fury.remains)
actions.CDs+=/aspect_of_the_eagle,if=(buff.mongoose_fury.remains<=7&buff.mongoose_fury.up)
actions.aoe=butchery
actions.aoe+=/caltrops,if=!dot.caltrops.ticking
actions.aoe+=/explosive_trap
actions.aoe+=/carve,if=talent.serpent_sting.enabled&!dot.serpent_sting.ticking
actions.aoe+=/carve,if=active_enemies>5
actions.biteFill=spitting_cobra
actions.biteFill+=/butchery,if=equipped.frizzos_fingertrap&dot.lacerate.remains<3.6
actions.biteFill+=/carve,if=equipped.frizzos_fingertrap&dot.lacerate.remains<3.6
actions.biteFill+=/lacerate,if=dot.lacerate.remains<3.6
actions.biteFill+=/raptor_strike,if=active_enemies=1&talent.serpent_sting.enabled&!dot.serpent_sting.ticking
actions.biteFill+=/steel_trap
actions.biteFill+=/a_murder_of_crows
actions.biteFill+=/dragonsfire_grenade
actions.biteFill+=/explosive_trap
actions.biteFill+=/caltrops,if=!dot.caltrops.ticking
actions.bitePhase=fury_of_the_eagle,if=(!talent.way_of_the_moknathal.enabled|buff.moknathal_tactics.remains>(gcd*(8%3)))&buff.mongoose_fury.stack=6,interrupt_if=(talent.way_of_the_moknathal.enabled&buff.moknathal_tactics.remains<=tick_time)
actions.bitePhase+=/mongoose_bite,if=charges>=2&cooldown.mongoose_bite.remains<gcd*2
actions.bitePhase+=/flanking_strike,if=((buff.mongoose_fury.remains>(gcd*(cooldown.mongoose_bite.charges+2)))&cooldown.mongoose_bite.charges<=1)&!buff.aspect_of_the_eagle.up
actions.bitePhase+=/mongoose_bite,if=buff.mongoose_fury.up
actions.bitePhase+=/flanking_strike
actions.fillers=carve,if=active_enemies>1&talent.serpent_sting.enabled&!dot.serpent_sting.ticking
actions.fillers+=/throwing_axes
actions.fillers+=/carve,if=active_enemies>2
actions.fillers+=/raptor_strike,if=(talent.way_of_the_moknathal.enabled&buff.moknathal_tactics.remains<gcd*4)
actions.fillers+=/raptor_strike,if=focus>((25-focus.regen*gcd)+55)
actions.mokMaintain=raptor_strike,if=buff.moknathal_tactics.remains<gcd
actions.mokMaintain+=/raptor_strike,if=buff.moknathal_tactics.stack<2
actions.preBitePhase=flanking_strike,if=cooldown.mongoose_bite.charges<3
actions.preBitePhase+=/spitting_cobra
actions.preBitePhase+=/lacerate,if=!dot.lacerate.ticking
actions.preBitePhase+=/raptor_strike,if=active_enemies=1&talent.serpent_sting.enabled&!dot.serpent_sting.ticking
actions.preBitePhase+=/steel_trap
actions.preBitePhase+=/a_murder_of_crows
actions.preBitePhase+=/dragonsfire_grenade
actions.preBitePhase+=/explosive_trap
actions.preBitePhase+=/caltrops,if=!dot.caltrops.ticking
actions.preBitePhase+=/butchery,if=equipped.frizzos_fingertrap&dot.lacerate.remains<3.6
actions.preBitePhase+=/carve,if=equipped.frizzos_fingertrap&dot.lacerate.remains<3.6
actions.preBitePhase+=/lacerate,if=dot.lacerate.remains<3.6
]])

