if GetBuildInfo and select(4,GetBuildInfo()) < 80000 then return end

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
actions+=/potion
actions+=/wind_shear
actions+=/totem_mastery,if=talent.totem_mastery.enabled&buff.resonance_totem.remains<2
actions+=/fire_elemental,if=!talent.storm_elemental.enabled
actions+=/storm_elemental,if=talent.storm_elemental.enabled
actions+=/earth_elemental,if=cooldown.fire_elemental.remains<120&!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120&talent.storm_elemental.enabled
actions+=/use_items
actions+=/blood_fury,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
actions+=/berserking,if=!talent.ascendance.enabled|buff.ascendance.up
actions+=/run_action_list,name=aoe,if=active_enemies>2&(spell_targets.chain_lightning>2|spell_targets.lava_beam>2)
actions+=/run_action_list,name=single_target
actions.aoe=stormkeeper,if=talent.stormkeeper.enabled
actions.aoe+=/ascendance,if=talent.ascendance.enabled&(talent.storm_elemental.enabled&cooldown.storm_elemental.remains<120&cooldown.storm_elemental.remains>15|!talent.storm_elemental.enabled)
actions.aoe+=/liquid_magma_totem,if=talent.liquid_magma_totem.enabled
actions.aoe+=/flame_shock,if=spell_targets.chain_lightning<4,target_if=refreshable
actions.aoe+=/earthquake
actions.aoe+=/lava_burst,if=(buff.lava_surge.up|buff.ascendance.up)&spell_targets.chain_lightning<4
actions.aoe+=/elemental_blast,if=talent.elemental_blast.enabled&spell_targets.chain_lightning<4
actions.aoe+=/lava_beam,if=talent.ascendance.enabled
actions.aoe+=/chain_lightning
actions.aoe+=/lava_burst,moving=1,if=talent.ascendance.enabled
actions.aoe+=/flame_shock,moving=1,target_if=refreshable
actions.aoe+=/frost_shock,moving=1
actions.single_target=flame_shock,if=!ticking|dot.flame_shock.remains<=gcd
actions.single_target+=/ascendance,if=talent.ascendance.enabled&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&!talent.storm_elemental.enabled
actions.single_target+=/ascendance,if=talent.ascendance.enabled&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&cooldown.storm_elemental.remains<=120
actions.single_target+=/elemental_blast,if=talent.elemental_blast.enabled&(talent.master_of_the_elements.enabled&buff.master_of_the_elements.up&maelstrom<60|!talent.master_of_the_elements.enabled)
actions.single_target+=/stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)
actions.single_target+=/liquid_magma_totem,if=talent.liquid_magma_totem.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)
actions.single_target+=/earthquake,if=active_enemies>1&spell_targets.chain_lightning>1&!talent.exposed_elements.enabled
actions.single_target+=/lightning_bolt,if=talent.exposed_elements.enabled&debuff.exposed_elements.up&maelstrom>=60&!buff.ascendance.up
actions.single_target+=/earth_shock,if=talent.master_of_the_elements.enabled&(buff.master_of_the_elements.up|maelstrom>=92)|!talent.master_of_the_elements.enabled
actions.single_target+=/lava_burst,if=cooldown_react|buff.ascendance.up
actions.single_target+=/flame_shock,target_if=refreshable
actions.single_target+=/totem_mastery,if=talent.totem_mastery.enabled&(buff.resonance_totem.remains<6|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15))
actions.single_target+=/frost_shock,if=talent.icefury.enabled&buff.icefury.up
actions.single_target+=/icefury,if=talent.icefury.enabled
actions.single_target+=/lava_beam,if=talent.ascendance.enabled&active_enemies>1&spell_targets.lava_beam>1
actions.single_target+=/chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1
actions.single_target+=/lightning_bolt
actions.single_target+=/flame_shock,moving=1,target_if=refreshable
actions.single_target+=/flame_shock,moving=1,if=movement.distance>6
actions.single_target+=/frost_shock,moving=1
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
actions+=/variable,name=furyCheck45,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>45))
actions+=/variable,name=furyCheck35,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>35))
actions+=/variable,name=furyCheck25,value=(!talent.fury_of_air.enabled|(talent.fury_of_air.enabled&maelstrom>25))
actions+=/variable,name=OCPool80,value=(!talent.overcharge.enabled|active_enemies>1|(talent.overcharge.enabled&active_enemies=1&(cooldown.lightning_bolt.remains>=2*gcd|maelstrom>80)))
actions+=/variable,name=OCPool70,value=(!talent.overcharge.enabled|active_enemies>1|(talent.overcharge.enabled&active_enemies=1&(cooldown.lightning_bolt.remains>=2*gcd|maelstrom>70)))
actions+=/variable,name=OCPool60,value=(!talent.overcharge.enabled|active_enemies>1|(talent.overcharge.enabled&active_enemies=1&(cooldown.lightning_bolt.remains>=2*gcd|maelstrom>60)))
actions+=/auto_attack
actions+=/use_items
actions+=/call_action_list,name=opener
actions+=/call_action_list,name=asc,if=buff.ascendance.up
actions+=/call_action_list,name=buffs
actions+=/call_action_list,name=cds
actions+=/call_action_list,name=core
actions+=/call_action_list,name=filler
actions.asc=crash_lightning,if=!buff.crash_lightning.up&active_enemies>1&variable.furyCheck25
actions.asc+=/rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7
actions.asc+=/windstrike
actions.buffs=crash_lightning,if=!buff.crash_lightning.up&active_enemies>1&variable.furyCheck25
actions.buffs+=/rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7
actions.buffs+=/fury_of_air,if=!ticking&maelstrom>=20
actions.buffs+=/flametongue,if=!buff.flametongue.up
actions.buffs+=/frostbrand,if=talent.hailstorm.enabled&!buff.frostbrand.up&variable.furyCheck25
actions.buffs+=/flametongue,if=buff.flametongue.remains<4.8+gcd
actions.buffs+=/frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<4.8+gcd&variable.furyCheck25
actions.buffs+=/totem_mastery,if=buff.resonance_totem.remains<2
actions.cds=bloodlust,if=target.health.pct<25|time>0.500
actions.cds+=/berserking,if=(talent.ascendance.enabled&buff.ascendance.up)|(talent.elemental_spirits.enabled&feral_spirit.remains>5)|(!talent.ascendance.enabled&!talent.elemental_spirits.enabled)
actions.cds+=/blood_fury,if=(talent.ascendance.enabled&(buff.ascendance.up|cooldown.ascendance.remains>50))|(!talent.ascendance.enabled&(feral_spirit.remains>5|cooldown.feral_spirit.remains>50))
actions.cds+=/fireblood,if=(talent.ascendance.enabled&(buff.ascendance.up|cooldown.ascendance.remains>50))|(!talent.ascendance.enabled&(feral_spirit.remains>5|cooldown.feral_spirit.remains>50))
actions.cds+=/ancestral_call,if=(talent.ascendance.enabled&(buff.ascendance.up|cooldown.ascendance.remains>50))|(!talent.ascendance.enabled&(feral_spirit.remains>5|cooldown.feral_spirit.remains>50))
actions.cds+=/potion,if=buff.ascendance.up|!talent.ascendance.enabled&feral_spirit.remains>5|target.time_to_die<=60
actions.cds+=/feral_spirit
actions.cds+=/ascendance,if=cooldown.strike.remains>0
actions.cds+=/earth_elemental
actions.core=earthen_spike,if=variable.furyCheck25
actions.core+=/sundering,if=active_enemies>=3
actions.core+=/stormstrike,cycle_targets=1,if=azerite.lightning_conduit.enabled&!debuff.lightning_conduit.up&active_enemies>1&(buff.stormbringer.up|(variable.OCPool70&variable.furyCheck35))
actions.core+=/stormstrike,if=buff.stormbringer.up|(buff.gathering_storms.up&variable.OCPool70&variable.furyCheck35)
actions.core+=/crash_lightning,if=active_enemies>=3&variable.furyCheck25
actions.core+=/lightning_bolt,if=talent.overcharge.enabled&active_enemies=1&variable.furyCheck45&maelstrom>=40
actions.core+=/stormstrike,if=variable.OCPool70&variable.furyCheck35
actions.core+=/sundering
actions.core+=/crash_lightning,if=talent.forceful_winds.enabled&active_enemies>1&variable.furyCheck25
actions.core+=/flametongue,if=talent.searing_assault.enabled
actions.core+=/lava_lash,if=talent.hot_hand.enabled&buff.hot_hand.react
actions.core+=/crash_lightning,if=active_enemies>1&variable.furyCheck25
actions.filler=rockbiter,if=maelstrom<70
actions.filler+=/crash_lightning,if=talent.crashing_storm.enabled&variable.OCPool60
actions.filler+=/lava_lash,if=variable.OCPool80&variable.furyCheck45
actions.filler+=/rockbiter
actions.filler+=/flametongue
actions.opener=rockbiter,if=maelstrom<15&time<gcd
]])

