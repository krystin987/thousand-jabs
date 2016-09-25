local _, internal = ...
internal.apls = internal.apls or {}

internal.apls["legion-dev::Tier19P::Hunter_BM_T19P"] = [[
actions.precombat=flask,type=flask_of_the_seventh_demon
actions.precombat+=/food,type=nightborne_delicacy_platter
actions.precombat+=/summon_pet
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=deadly_grace
actions.precombat+=/augmentation,type=defiled
actions=auto_shot
actions+=/arcane_torrent,if=focus.deficit>=30
actions+=/blood_fury
actions+=/berserking
actions+=/potion,name=deadly_grace
actions+=/a_murder_of_crows
actions+=/stampede,if=buff.bloodlust.up|buff.bestial_wrath.up|cooldown.bestial_wrath.remains<=2|target.time_to_die<=14
actions+=/dire_beast,if=cooldown.bestial_wrath.remains>2
actions+=/dire_frenzy,if=cooldown.bestial_wrath.remains>2
actions+=/aspect_of_the_wild,if=buff.bestial_wrath.up
actions+=/barrage,if=spell_targets.barrage>1|(spell_targets.barrage=1&focus>90)
actions+=/titans_thunder,if=cooldown.dire_beast.remains>=3|buff.bestial_wrath.up&pet.dire_beast.active
actions+=/bestial_wrath
actions+=/multi_shot,if=spell_targets.multi_shot>4&(pet.buff.beast_cleave.remains<gcd.max|pet.buff.beast_cleave.down)
actions+=/kill_command
actions+=/multi_shot,if=spell_targets.multi_shot>1&(pet.buff.beast_cleave.remains<gcd.max*2|pet.buff.beast_cleave.down)
actions+=/chimaera_shot,if=focus<90
actions+=/cobra_shot,if=talent.killer_cobra.enabled&(cooldown.bestial_wrath.remains>=4&(buff.bestial_wrath.up&cooldown.kill_command.remains>=2)|focus>119)|!talent.killer_cobra.enabled&focus>90
]]

internal.apls["legion-dev::Tier19P::Hunter_MM_T19P"] = [[
actions.precombat=flask,type=flask_of_the_seventh_demon
actions.precombat+=/food,type=nightborne_delicacy_platter
actions.precombat+=/summon_pet
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=deadly_grace
actions.precombat+=/augmentation,type=defiled
actions.precombat+=/windburst
actions=auto_shot
actions+=/arcane_torrent,if=focus.deficit>=30
actions+=/blood_fury
actions+=/berserking
actions+=/auto_shot
actions+=/call_action_list,name=cooldowns
actions+=/a_murder_of_crows
actions+=/barrage
actions+=/piercing_shot,if=!talent.patient_sniper.enabled&focus>50
actions+=/windburst,if=active_enemies<2&buff.marking_targets.down&(debuff.vulnerability.down|debuff.vulnerability.remains<cast_time)
actions+=/windburst,if=active_enemies<2&buff.marking_targets.down&focus+cast_regen>90
actions+=/windburst,if=active_enemies<2&cooldown.sidewinders.charges=0
actions+=/arcane_shot,if=!talent.patient_sniper.enabled&active_enemies=1&debuff.vulnerability.react<3&buff.marking_targets.react&debuff.hunters_mark.down
actions+=/marked_shot,if=!talent.patient_sniper.enabled&debuff.vulnerability.react<3
actions+=/marked_shot,if=prev_off_gcd.sentinel
actions+=/sentinel,if=debuff.hunters_mark.down&buff.marking_targets.down
actions+=/explosive_shot
actions+=/marked_shot,if=active_enemies>=4&cooldown.sidewinders.charges_fractional>=0.8
actions+=/sidewinders,if=active_enemies>1&debuff.hunters_mark.down&(buff.marking_targets.react|buff.trueshot.react|charges=2)
actions+=/arcane_shot,if=talent.steady_focus.enabled&active_enemies=1&(buff.steady_focus.down|buff.steady_focus.remains<2)
actions+=/multishot,if=talent.steady_focus.enabled&active_enemies>1&(buff.steady_focus.down|buff.steady_focus.remains<2)
actions+=/arcane_shot,if=talent.true_aim.enabled&active_enemies=1&(debuff.true_aim.react<1|debuff.true_aim.remains<2)
actions+=/aimed_shot,if=buff.lock_and_load.up&debuff.vulnerability.remains>gcd.max
actions+=/piercing_shot,if=talent.patient_sniper.enabled&focus>80
actions+=/marked_shot,if=!talent.sidewinders.enabled&(debuff.vulnerability.remains<2|buff.marking_targets.react)
actions+=/pool_resource,for_next=1,if=talent.sidewinders.enabled&(focus<60&cooldown.sidewinders.charges_fractional<=1.2)
actions+=/aimed_shot,if=cast_time<debuff.vulnerability.remains&(focus+cast_regen>80|debuff.hunters_mark.down)
actions+=/marked_shot
actions+=/black_arrow
actions+=/sidewinders,if=debuff.hunters_mark.down&(buff.marking_targets.remains>6|buff.trueshot.react|charges=2)
actions+=/sidewinders,if=focus<30&charges<=1&recharge_time<=5
actions+=/multishot,if=spell_targets.barrage>1&(debuff.hunters_mark.down&buff.marking_targets.react|focus.time_to_max>=2)
actions+=/arcane_shot,if=spell_targets.barrage=1&(debuff.hunters_mark.down&buff.marking_targets.react|focus.time_to_max>=2)
actions+=/arcane_shot,if=focus.deficit<10
actions.cooldowns=potion,name=deadly_grace,if=(buff.trueshot.react&buff.bloodlust.react)|buff.bullseye.react>=23
actions.cooldowns+=/trueshot,if=(buff.bloodlust.react|target.health.pct>20+(cooldown.trueshot.remains+15))|buff.bullseye.react>25
]]

internal.apls["legion-dev::Tier19P::Hunter_SV_T19P"] = [[
actions.precombat=flask,type=flask_of_the_seventh_demon
actions.precombat+=/food,type=seedbattered_fish_plate
actions.precombat+=/summon_pet
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=potion_of_the_old_war
actions.precombat+=/augmentation,type=defiled
actions.precombat+=/harpoon
actions=auto_attack
actions+=/arcane_torrent,if=focus.deficit>=30
actions+=/blood_fury
actions+=/berserking
actions+=/use_item,name=tirathons_betrayal
actions+=/potion,name=old_war
actions+=/steel_trap
actions+=/explosive_trap
actions+=/dragonsfire_grenade
actions+=/caltrops
actions+=/carve,cycle_targets=1,if=talent.serpent_sting.enabled&active_enemies>=3&(!dot.serpent_sting.ticking|dot.serpent_sting.remains<=gcd.max)
actions+=/raptor_strike,cycle_targets=1,if=talent.serpent_sting.enabled&active_enemies<=2&(!dot.serpent_sting.ticking|dot.serpent_sting.remains<=gcd.max)|talent.way_of_the_moknathal.enabled&(buff.moknathal_tactics.remains<gcd.max|buff.moknathal_tactics.down)
actions+=/aspect_of_the_eagle
actions+=/fury_of_the_eagle,if=buff.mongoose_fury.up&(buff.mongoose_fury.stack=6|action.mongoose_bite.charges=0&cooldown.snake_hunter.remains|buff.mongoose_fury.remains<=gcd.max*2)
actions+=/mongoose_bite,if=buff.aspect_of_the_eagle.up&(charges>=2|charges>=1&cooldown.mongoose_bite.remains<=2)|(buff.mongoose_fury.up|cooldown.fury_of_the_eagle.remains<5|charges=3)
actions+=/a_murder_of_crows
actions+=/lacerate,if=dot.lacerate.ticking&dot.lacerate.remains<=3|target.time_to_die>=5
actions+=/snake_hunter,if=action.mongoose_bite.charges<=1&buff.mongoose_fury.remains>gcd.max*4|action.mongoose_bite.charges=0&buff.aspect_of_the_eagle.up
actions+=/flanking_strike,if=talent.way_of_the_moknathal.enabled&(buff.moknathal_tactics.remains>=3)|!talent.way_of_the_moknathal.enabled
actions+=/butchery,if=spell_targets.butchery>=2
actions+=/carve,if=spell_targets.carve>=4
actions+=/spitting_cobra
actions+=/throwing_axes
actions+=/raptor_strike,if=!talent.throwing_axes.enabled&focus>75-cooldown.flanking_strike.remains*focus.regen
]]

internal.apls["legion-dev::Tier19H::Hunter_BM_T19H"] = [[
actions.precombat=flask,type=flask_of_the_seventh_demon
actions.precombat+=/food,type=nightborne_delicacy_platter
actions.precombat+=/summon_pet
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=deadly_grace
actions.precombat+=/augmentation,type=defiled
actions=auto_shot
actions+=/arcane_torrent,if=focus.deficit>=30
actions+=/blood_fury
actions+=/berserking
actions+=/potion,name=deadly_grace
actions+=/a_murder_of_crows
actions+=/stampede,if=buff.bloodlust.up|buff.bestial_wrath.up|cooldown.bestial_wrath.remains<=2|target.time_to_die<=14
actions+=/dire_beast,if=cooldown.bestial_wrath.remains>2
actions+=/dire_frenzy,if=cooldown.bestial_wrath.remains>2
actions+=/aspect_of_the_wild,if=buff.bestial_wrath.up
actions+=/barrage,if=spell_targets.barrage>1|(spell_targets.barrage=1&focus>90)
actions+=/titans_thunder,if=cooldown.dire_beast.remains>=3|buff.bestial_wrath.up&pet.dire_beast.active
actions+=/bestial_wrath
actions+=/multi_shot,if=spell_targets.multi_shot>4&(pet.buff.beast_cleave.remains<gcd.max|pet.buff.beast_cleave.down)
actions+=/kill_command
actions+=/multi_shot,if=spell_targets.multi_shot>1&(pet.buff.beast_cleave.remains<gcd.max*2|pet.buff.beast_cleave.down)
actions+=/chimaera_shot,if=focus<90
actions+=/cobra_shot,if=talent.killer_cobra.enabled&(cooldown.bestial_wrath.remains>=4&(buff.bestial_wrath.up&cooldown.kill_command.remains>=2)|focus>119)|!talent.killer_cobra.enabled&focus>90
]]

internal.apls["legion-dev::Tier19H::Hunter_MM_T19H"] = [[
actions.precombat=flask,type=flask_of_the_seventh_demon
actions.precombat+=/food,type=nightborne_delicacy_platter
actions.precombat+=/summon_pet
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=deadly_grace
actions.precombat+=/augmentation,type=defiled
actions.precombat+=/windburst
actions=auto_shot
actions+=/arcane_torrent,if=focus.deficit>=30
actions+=/blood_fury
actions+=/berserking
actions+=/auto_shot
actions+=/call_action_list,name=cooldowns
actions+=/a_murder_of_crows
actions+=/barrage
actions+=/piercing_shot,if=!talent.patient_sniper.enabled&focus>50
actions+=/windburst,if=active_enemies<2&buff.marking_targets.down&(debuff.vulnerability.down|debuff.vulnerability.remains<cast_time)
actions+=/windburst,if=active_enemies<2&buff.marking_targets.down&focus+cast_regen>90
actions+=/windburst,if=active_enemies<2&cooldown.sidewinders.charges=0
actions+=/arcane_shot,if=!talent.patient_sniper.enabled&active_enemies=1&debuff.vulnerability.react<3&buff.marking_targets.react&debuff.hunters_mark.down
actions+=/marked_shot,if=!talent.patient_sniper.enabled&debuff.vulnerability.react<3
actions+=/marked_shot,if=prev_off_gcd.sentinel
actions+=/sentinel,if=debuff.hunters_mark.down&buff.marking_targets.down
actions+=/explosive_shot
actions+=/marked_shot,if=active_enemies>=4&cooldown.sidewinders.charges_fractional>=0.8
actions+=/sidewinders,if=active_enemies>1&debuff.hunters_mark.down&(buff.marking_targets.react|buff.trueshot.react|charges=2)
actions+=/arcane_shot,if=talent.steady_focus.enabled&active_enemies=1&(buff.steady_focus.down|buff.steady_focus.remains<2)
actions+=/multishot,if=talent.steady_focus.enabled&active_enemies>1&(buff.steady_focus.down|buff.steady_focus.remains<2)
actions+=/arcane_shot,if=talent.true_aim.enabled&active_enemies=1&(debuff.true_aim.react<1|debuff.true_aim.remains<2)
actions+=/aimed_shot,if=buff.lock_and_load.up&debuff.vulnerability.remains>gcd.max
actions+=/piercing_shot,if=talent.patient_sniper.enabled&focus>80
actions+=/marked_shot,if=!talent.sidewinders.enabled&(debuff.vulnerability.remains<2|buff.marking_targets.react)
actions+=/pool_resource,for_next=1,if=talent.sidewinders.enabled&(focus<60&cooldown.sidewinders.charges_fractional<=1.2)
actions+=/aimed_shot,if=cast_time<debuff.vulnerability.remains&(focus+cast_regen>80|debuff.hunters_mark.down)
actions+=/marked_shot
actions+=/black_arrow
actions+=/sidewinders,if=debuff.hunters_mark.down&(buff.marking_targets.remains>6|buff.trueshot.react|charges=2)
actions+=/sidewinders,if=focus<30&charges<=1&recharge_time<=5
actions+=/multishot,if=spell_targets.barrage>1&(debuff.hunters_mark.down&buff.marking_targets.react|focus.time_to_max>=2)
actions+=/arcane_shot,if=spell_targets.barrage=1&(debuff.hunters_mark.down&buff.marking_targets.react|focus.time_to_max>=2)
actions+=/arcane_shot,if=focus.deficit<10
actions.cooldowns=potion,name=deadly_grace,if=(buff.trueshot.react&buff.bloodlust.react)|buff.bullseye.react>=23
actions.cooldowns+=/trueshot,if=(buff.bloodlust.react|target.health.pct>20+(cooldown.trueshot.remains+15))|buff.bullseye.react>25
]]

internal.apls["legion-dev::Tier19H::Hunter_SV_T19H"] = [[
actions.precombat=flask,type=flask_of_the_seventh_demon
actions.precombat+=/food,type=seedbattered_fish_plate
actions.precombat+=/summon_pet
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=potion_of_the_old_war
actions.precombat+=/augmentation,type=defiled
actions.precombat+=/harpoon
actions=auto_attack
actions+=/arcane_torrent,if=focus.deficit>=30
actions+=/blood_fury
actions+=/berserking
actions+=/potion,name=old_war
actions+=/steel_trap
actions+=/explosive_trap
actions+=/dragonsfire_grenade
actions+=/caltrops
actions+=/carve,cycle_targets=1,if=talent.serpent_sting.enabled&active_enemies>=3&(!dot.serpent_sting.ticking|dot.serpent_sting.remains<=gcd.max)
actions+=/raptor_strike,cycle_targets=1,if=talent.serpent_sting.enabled&active_enemies<=2&(!dot.serpent_sting.ticking|dot.serpent_sting.remains<=gcd.max)|talent.way_of_the_moknathal.enabled&(buff.moknathal_tactics.remains<gcd.max|buff.moknathal_tactics.down)
actions+=/aspect_of_the_eagle
actions+=/fury_of_the_eagle,if=buff.mongoose_fury.up&(buff.mongoose_fury.stack=6|action.mongoose_bite.charges=0&cooldown.snake_hunter.remains|buff.mongoose_fury.remains<=gcd.max*2)
actions+=/mongoose_bite,if=buff.aspect_of_the_eagle.up&(charges>=2|charges>=1&cooldown.mongoose_bite.remains<=2)|(buff.mongoose_fury.up|cooldown.fury_of_the_eagle.remains<5|charges=3)
actions+=/a_murder_of_crows
actions+=/lacerate,if=dot.lacerate.ticking&dot.lacerate.remains<=3|target.time_to_die>=5
actions+=/snake_hunter,if=action.mongoose_bite.charges<=1&buff.mongoose_fury.remains>gcd.max*4|action.mongoose_bite.charges=0&buff.aspect_of_the_eagle.up
actions+=/flanking_strike,if=talent.way_of_the_moknathal.enabled&(buff.moknathal_tactics.remains>=3)|!talent.way_of_the_moknathal.enabled
actions+=/butchery,if=spell_targets.butchery>=2
actions+=/carve,if=spell_targets.carve>=4
actions+=/spitting_cobra
actions+=/throwing_axes
actions+=/raptor_strike,if=!talent.throwing_axes.enabled&focus>75-cooldown.flanking_strike.remains*focus.regen
]]

