if GetBuildInfo and select(4,GetBuildInfo()) >= 80000 then return end

if select(3, UnitClass('player')) ~= 7 then return end

local TJ = LibStub('AceAddon-3.0'):GetAddon('ThousandJabs')

TJ:RegisterActionProfileList('simc::shaman::elemental', 'Simulationcraft Shaman Profile: Elemental', 7, 1, [[
actions.precombat=flask
actions.precombat+=/food
actions.precombat+=/augmentation
actions.precombat+=/snapshot_stats
actions.precombat+=/totem_mastery
actions.precombat+=/fire_elemental
actions.precombat+=/potion
actions.precombat+=/elemental_blast
actions=bloodlust,if=target.health.pct<25|time>0.500
actions+=/potion,if=cooldown.fire_elemental.remains>280|target.time_to_die<=60
actions+=/wind_shear
actions+=/totem_mastery,if=buff.resonance_totem.remains<2
actions+=/fire_elemental
actions+=/storm_elemental
actions+=/elemental_mastery
actions+=/use_items
actions+=/use_item,name=gnawed_thumb_ring,if=equipped.gnawed_thumb_ring&(talent.ascendance.enabled&!buff.ascendance.up|!talent.ascendance.enabled)
actions+=/blood_fury,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
actions+=/berserking,if=!talent.ascendance.enabled|buff.ascendance.up
actions+=/run_action_list,name=aoe,if=active_enemies>2&(spell_targets.chain_lightning>2|spell_targets.lava_beam>2)
actions+=/run_action_list,name=single_asc,if=talent.ascendance.enabled
actions+=/run_action_list,name=single_if,if=talent.icefury.enabled
actions+=/run_action_list,name=single_lr,if=talent.lightning_rod.enabled
actions.aoe=stormkeeper
actions.aoe+=/ascendance
actions.aoe+=/liquid_magma_totem
actions.aoe+=/flame_shock,if=spell_targets.chain_lightning<4&maelstrom>=20,target_if=refreshable
actions.aoe+=/earthquake
actions.aoe+=/lava_burst,if=dot.flame_shock.remains>cast_time&buff.lava_surge.up&!talent.lightning_rod.enabled&spell_targets.chain_lightning<4
actions.aoe+=/elemental_blast,if=!talent.lightning_rod.enabled&spell_targets.chain_lightning<4
actions.aoe+=/lava_beam,target_if=debuff.lightning_rod.down
actions.aoe+=/lava_beam
actions.aoe+=/chain_lightning,target_if=debuff.lightning_rod.down
actions.aoe+=/chain_lightning
actions.aoe+=/lava_burst,moving=1
actions.aoe+=/flame_shock,moving=1,target_if=refreshable
actions.single_asc=ascendance,if=dot.flame_shock.remains>buff.ascendance.duration&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&!buff.stormkeeper.up
actions.single_asc+=/flame_shock,if=!ticking|dot.flame_shock.remains<=gcd
actions.single_asc+=/flame_shock,if=maelstrom>=20&remains<=buff.ascendance.duration&cooldown.ascendance.remains+buff.ascendance.duration<=duration
actions.single_asc+=/elemental_blast
actions.single_asc+=/earthquake,if=buff.echoes_of_the_great_sundering.up&(buff.earthen_strength.up|buff.echoes_of_the_great_sundering.duration<=3|maelstrom>=117)|(buff.earthen_strength.up|maelstrom>=104)&spell_targets.earthquake>1&!equipped.echoes_of_the_great_sundering
actions.single_asc+=/earth_shock,if=(maelstrom>=117|!artifact.swelling_maelstrom.enabled&maelstrom>=92)&(spell_targets.earthquake=1|equipped.echoes_of_the_great_sundering)
actions.single_asc+=/stormkeeper,if=(raid_event.adds.count<3|raid_event.adds.in>50)&time>5&!buff.ascendance.up
actions.single_asc+=/liquid_magma_totem,if=raid_event.adds.count<3|raid_event.adds.in>50
actions.single_asc+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&buff.stormkeeper.up&spell_targets.chain_lightning<3
actions.single_asc+=/lava_burst,if=dot.flame_shock.remains>cast_time&(cooldown_react|buff.ascendance.up)
actions.single_asc+=/flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
actions.single_asc+=/earthquake,if=buff.echoes_of_the_great_sundering.up&(maelstrom>=111|!artifact.swelling_maelstrom.enabled&maelstrom>=86|equipped.the_deceivers_blood_pact&maelstrom>85&talent.aftershock.enabled)
actions.single_asc+=/earth_shock,if=(spell_targets.earthquake=1|equipped.echoes_of_the_great_sundering)&(maelstrom>=111|!artifact.swelling_maelstrom.enabled&maelstrom>=86|equipped.the_deceivers_blood_pact&talent.aftershock.enabled&(maelstrom>85&equipped.echoes_of_the_great_sundering|maelstrom>70&equipped.smoldering_heart))
actions.single_asc+=/totem_mastery,if=buff.resonance_totem.remains<10|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15)
actions.single_asc+=/lava_beam,if=active_enemies>1&spell_targets.lava_beam>1
actions.single_asc+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3
actions.single_asc+=/chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1
actions.single_asc+=/lightning_bolt
actions.single_asc+=/flame_shock,moving=1,target_if=refreshable
actions.single_asc+=/earth_shock,moving=1
actions.single_asc+=/flame_shock,moving=1,if=movement.distance>6
actions.single_if=flame_shock,if=!ticking|dot.flame_shock.remains<=gcd
actions.single_if+=/elemental_blast
actions.single_if+=/earthquake,if=buff.echoes_of_the_great_sundering.up&(buff.earthen_strength.up|buff.echoes_of_the_great_sundering.duration<=3|maelstrom>=117)|(buff.earthen_strength.up|maelstrom>=104)&spell_targets.earthquake>1&!equipped.echoes_of_the_great_sundering
actions.single_if+=/earth_shock,if=(maelstrom>=111|!artifact.swelling_maelstrom.enabled&maelstrom>=92)&(spell_targets.earthquake=1|equipped.echoes_of_the_great_sundering)&buff.earthen_strength.up
actions.single_if+=/frost_shock,if=buff.icefury.up&maelstrom>=20&!buff.ascendance.up&buff.earthen_strength.up
actions.single_if+=/earth_shock,if=(maelstrom>=117|!artifact.swelling_maelstrom.enabled&maelstrom>=92)&(spell_targets.earthquake=1|equipped.echoes_of_the_great_sundering)
actions.single_if+=/stormkeeper,if=(raid_event.adds.count<3|raid_event.adds.in>50)&!buff.ascendance.up
actions.single_if+=/icefury,if=(raid_event.movement.in<5|maelstrom<=101&artifact.swelling_maelstrom.enabled|!artifact.swelling_maelstrom.enabled&maelstrom<=76)&!buff.ascendance.up
actions.single_if+=/liquid_magma_totem,if=raid_event.adds.count<3|raid_event.adds.in>50
actions.single_if+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&buff.stormkeeper.up&spell_targets.chain_lightning<3
actions.single_if+=/lava_burst,if=dot.flame_shock.remains>cast_time&cooldown_react
actions.single_if+=/frost_shock,if=buff.icefury.up&((maelstrom>=20&raid_event.movement.in>buff.icefury.remains)|buff.icefury.remains<(1.5*spell_haste*buff.icefury.stack+1))
actions.single_if+=/flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
actions.single_if+=/earthquake,if=buff.echoes_of_the_great_sundering.up&(maelstrom>=111|!artifact.swelling_maelstrom.enabled&maelstrom>=86|equipped.the_deceivers_blood_pact&maelstrom>85&talent.aftershock.enabled)
actions.single_if+=/frost_shock,moving=1,if=buff.icefury.up
actions.single_if+=/earth_shock,if=(spell_targets.earthquake=1|equipped.echoes_of_the_great_sundering)&(maelstrom>=111|!artifact.swelling_maelstrom.enabled&maelstrom>=86|equipped.the_deceivers_blood_pact&talent.aftershock.enabled&(maelstrom>85&equipped.echoes_of_the_great_sundering|maelstrom>70&equipped.smoldering_heart))
actions.single_if+=/totem_mastery,if=buff.resonance_totem.remains<10
actions.single_if+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3
actions.single_if+=/lava_beam,if=active_enemies>1&spell_targets.lava_beam>1
actions.single_if+=/chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1
actions.single_if+=/lightning_bolt
actions.single_if+=/flame_shock,moving=1,target_if=refreshable
actions.single_if+=/earth_shock,moving=1
actions.single_if+=/flame_shock,moving=1,if=movement.distance>6
actions.single_lr=flame_shock,if=!ticking|dot.flame_shock.remains<=gcd
actions.single_lr+=/elemental_blast
actions.single_lr+=/earthquake,if=buff.echoes_of_the_great_sundering.up&(buff.earthen_strength.up|buff.echoes_of_the_great_sundering.duration<=3|maelstrom>=117)|(buff.earthen_strength.up|maelstrom>=104)&spell_targets.earthquake>1&!equipped.echoes_of_the_great_sundering
actions.single_lr+=/earth_shock,if=(maelstrom>=117|!artifact.swelling_maelstrom.enabled&maelstrom>=92)&(spell_targets.earthquake=1|equipped.echoes_of_the_great_sundering)
actions.single_lr+=/stormkeeper,if=(raid_event.adds.count<3|raid_event.adds.in>50)&!buff.ascendance.up
actions.single_lr+=/liquid_magma_totem,if=raid_event.adds.count<3|raid_event.adds.in>50
actions.single_lr+=/lava_burst,if=dot.flame_shock.remains>cast_time&cooldown_react
actions.single_lr+=/flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
actions.single_lr+=/earthquake,if=buff.echoes_of_the_great_sundering.up&(maelstrom>=111|!artifact.swelling_maelstrom.enabled&maelstrom>=86|equipped.the_deceivers_blood_pact&maelstrom>85&talent.aftershock.enabled)
actions.single_lr+=/earth_shock,if=(spell_targets.earthquake=1|equipped.echoes_of_the_great_sundering)&(maelstrom>=111|!artifact.swelling_maelstrom.enabled&maelstrom>=86|equipped.the_deceivers_blood_pact&talent.aftershock.enabled&(maelstrom>85&equipped.echoes_of_the_great_sundering|maelstrom>70&equipped.smoldering_heart))
actions.single_lr+=/totem_mastery,if=buff.resonance_totem.remains<10|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15)
actions.single_lr+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3,target_if=debuff.lightning_rod.down
actions.single_lr+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3
actions.single_lr+=/lava_beam,if=active_enemies>1&spell_targets.lava_beam>1,target_if=debuff.lightning_rod.down
actions.single_lr+=/lava_beam,if=active_enemies>1&spell_targets.lava_beam>1
actions.single_lr+=/chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1,target_if=debuff.lightning_rod.down
actions.single_lr+=/chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1
actions.single_lr+=/lightning_bolt,target_if=debuff.lightning_rod.down
actions.single_lr+=/lightning_bolt
actions.single_lr+=/flame_shock,moving=1,target_if=refreshable
actions.single_lr+=/earth_shock,moving=1
actions.single_lr+=/flame_shock,moving=1,if=movement.distance>6
actions+=/run_action_list,name=single_lr,if=level<100
]])

TJ:RegisterActionProfileList('simc::shaman::enhancement', 'Simulationcraft Shaman Profile: Enhancement', 7, 2, [[
actions.precombat=flask
actions.precombat+=/food
actions.precombat+=/augmentation
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions.precombat+=/lightning_shield
actions=wind_shear
actions+=/variable,name=hailstormCheck,value=((talent.hailstorm.enabled&!buff.frostbrand.up)|!talent.hailstorm.enabled)
actions+=/variable,name=furyCheck80,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>80))
actions+=/variable,name=furyCheck70,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>70))
actions+=/variable,name=furyCheck45,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>45))
actions+=/variable,name=furyCheck25,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>25))
actions+=/variable,name=overcharge,value=(talent.overcharge.enabled&variable.furyCheck45&maelstrom>=40)
actions+=/variable,name=OCPool100,value=(!talent.overcharge.enabled|(talent.overcharge.enabled&(maelstrom>100|cooldown.lightning_bolt.remains>gcd)))
actions+=/variable,name=OCPool80,value=(!talent.overcharge.enabled|(talent.overcharge.enabled&(maelstrom>80|cooldown.lightning_bolt.remains>gcd)))
actions+=/variable,name=OCPool70,value=(!talent.overcharge.enabled|(talent.overcharge.enabled&(maelstrom>70|cooldown.lightning_bolt.remains>gcd)))
actions+=/variable,name=OCPool60,value=(!talent.overcharge.enabled|(talent.overcharge.enabled&(maelstrom>60|cooldown.lightning_bolt.remains>gcd)))
actions+=/variable,name=heartEquipped,value=(equipped.151819)
actions+=/variable,name=akainuEquipped,value=(equipped.137084)
actions+=/variable,name=stormTempests,value=(equipped.137103&!debuff.storm_tempests.up)
actions+=/variable,name=akainuAS,value=(variable.akainuEquipped&buff.hot_hand.react&!buff.frostbrand.up)
actions+=/variable,name=LightningCrashNotUp,value=(!buff.lightning_crash.up&set_bonus.tier20_2pc)
actions+=/variable,name=alphaWolfCheck,value=((pet.frost_wolf.buff.alpha_wolf.remains<2&pet.fiery_wolf.buff.alpha_wolf.remains<2&pet.lightning_wolf.buff.alpha_wolf.remains<2)&feral_spirit.remains>4)
actions+=/auto_attack
actions+=/use_items
actions+=/call_action_list,name=opener
actions+=/call_action_list,name=asc,if=buff.ascendance.up
actions+=/call_action_list,name=buffs
actions+=/call_action_list,name=cds
actions+=/call_action_list,name=core
actions+=/call_action_list,name=filler
actions.asc=earthen_spike
actions.asc+=/doom_winds,if=cooldown.strike.up
actions.asc+=/crash_lightning,if=!buff.crash_lightning.up&active_enemies>=2
actions.asc+=/windstrike,target_if=variable.stormTempests
actions.asc+=/windstrike
actions.buffs=rockbiter,if=talent.landslide.enabled&!buff.landslide.up
actions.buffs+=/fury_of_air,if=!ticking&maelstrom>22
actions.buffs+=/crash_lightning,if=artifact.alpha_wolf.rank&prev_gcd.1.feral_spirit
actions.buffs+=/flametongue,if=!buff.flametongue.up
actions.buffs+=/frostbrand,if=talent.hailstorm.enabled&!buff.frostbrand.up&variable.furyCheck45
actions.buffs+=/flametongue,if=buff.flametongue.remains<6+gcd&cooldown.doom_winds.remains<gcd*2
actions.buffs+=/frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<6+gcd&cooldown.doom_winds.remains<gcd*2
actions.cds=bloodlust,if=target.health.pct<25|time>0.500
actions.cds+=/berserking,if=buff.ascendance.up|(cooldown.doom_winds.up)|level<100
actions.cds+=/blood_fury,if=buff.ascendance.up|(feral_spirit.remains>5)|level<100
actions.cds+=/potion,if=buff.ascendance.up|(!talent.ascendance.enabled&!variable.heartEquipped&feral_spirit.remains>5)|target.time_to_die<=60
actions.cds+=/feral_spirit
actions.cds+=/doom_winds,if=cooldown.ascendance.remains>6|talent.boulderfist.enabled|debuff.earthen_spike.up
actions.cds+=/ascendance,if=(cooldown.strike.remains>0)&buff.ascendance.down
actions.core=earthen_spike,if=variable.furyCheck25
actions.core+=/crash_lightning,if=!buff.crash_lightning.up&active_enemies>=2
actions.core+=/windsong
actions.core+=/crash_lightning,if=active_enemies>=8|(active_enemies>=6&talent.crashing_storm.enabled)
actions.core+=/rockbiter,if=buff.force_of_the_mountain.up&charges_fractional>1.7&active_enemies<=4
actions.core+=/stormstrike,target_if=variable.stormTempests
actions.core+=/stormstrike,if=buff.stormbringer.up&variable.furyCheck25
actions.core+=/lightning_bolt,if=variable.overcharge&debuff.exposed_elements.up
actions.core+=/crash_lightning,if=active_enemies>=4|(active_enemies>=2&talent.crashing_storm.enabled)
actions.core+=/rockbiter,if=buff.force_of_the_mountain.up
actions.core+=/lava_lash,if=(buff.hot_hand.react&((variable.akainuEquipped&buff.frostbrand.up)|(!variable.akainuEquipped)))
actions.core+=/lava_lash,if=(maelstrom>=50&variable.OCPool70&variable.furyCheck80&debuff.exposed_elements.up&debuff.lashing_flames.stack>90)
actions.core+=/lightning_bolt,if=variable.overcharge
actions.core+=/stormstrike,if=variable.furyCheck45&(variable.OCPool80|buff.doom_winds.up)
actions.core+=/frostbrand,if=variable.akainuAS
actions.core+=/sundering,if=active_enemies>=3
actions.core+=/crash_lightning,if=active_enemies>=3|variable.LightningCrashNotUp|variable.alphaWolfCheck
actions.filler=rockbiter,if=maelstrom<120&charges_fractional>1.7
actions.filler+=/flametongue,if=buff.flametongue.remains<4.8
actions.filler+=/crash_lightning,if=(talent.crashing_storm.enabled|active_enemies>=2)&debuff.earthen_spike.up&maelstrom>=40&variable.OCPool80
actions.filler+=/frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<4.8&maelstrom>40
actions.filler+=/frostbrand,if=variable.akainuEquipped&!buff.frostbrand.up&maelstrom>=75
actions.filler+=/sundering
actions.filler+=/lava_lash,if=maelstrom>=50&variable.OCPool100&variable.furyCheck70
actions.filler+=/rockbiter
actions.filler+=/crash_lightning,if=(maelstrom>=45|talent.crashing_storm.enabled|active_enemies>=2)&variable.OCPool80
actions.filler+=/flametongue
actions.opener=rockbiter,if=maelstrom<15&time<gcd
]])

