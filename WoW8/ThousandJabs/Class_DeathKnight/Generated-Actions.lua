if GetBuildInfo and select(4,GetBuildInfo()) < 80000 then return end

if select(3, UnitClass('player')) ~= 6 then return end

local TJ = LibStub('AceAddon-3.0'):GetAddon('ThousandJabs')

TJ:RegisterActionProfileList('custom::deathknight::blood', 'Thousand Jabs Custom Death Knight Profile: Blood', 6, 1, [[
actions=auto_attack
actions+=/mind_freeze
actions+=/call_action_list,name=st,if=active_enemies=1
actions+=/call_action_list,name=cleave,if=active_enemies=2
actions+=/call_action_list,name=aoe,if=active_enemies>=3
actions.st=blood_boil,if=debuff.blood_plague.down
actions.st+=/death_strike,if=runic_power>95
actions.st+=/death_and_decay,if=buff.crimson_scourge.up
actions.st+=/marrowrend,if=buff.bone_shield.stack<5
actions.st+=/death_strike,if=runic_power>80
actions.st+=/death_strike,if=incoming_damage_3s>health.max*0.25
actions.st+=/blood_boil,if=buff.bone_shield.stack<5
actions.st+=/death_and_decay
actions.st+=/consumption
actions.st+=/heart_strike
actions.cleave=blood_boil,if=debuff.blood_plague.down
actions.cleave+=/death_strike,if=runic_power>95
actions.cleave+=/death_and_decay,if=buff.crimson_scourge.up
actions.cleave+=/marrowrend,if=buff.bone_shield.stack<5
actions.cleave+=/blood_boil,if=buff.bone_shield.stack<5
actions.cleave+=/death_strike,if=runic_power>80
actions.cleave+=/death_strike,if=incoming_damage_3s>health.max*0.25
actions.cleave+=/death_and_decay
actions.cleave+=/consumption
actions.cleave+=/heart_strike
actions.aoe=blood_boil,if=debuff.blood_plague.down
actions.aoe+=/death_strike,if=runic_power>95
actions.aoe+=/death_and_decay,if=buff.crimson_scourge.up
actions.aoe+=/marrowrend,if=buff.bone_shield.stack<1
actions.aoe+=/blood_boil,if=buff.bone_shield.stack<1
actions.aoe+=/death_strike,if=runic_power>80
actions.aoe+=/death_strike,if=incoming_damage_3s>health.max*0.25
actions.aoe+=/death_and_decay
actions.aoe+=/consumption
actions.aoe+=/heart_strike
]])

TJ:RegisterActionProfileList('simc::deathknight::blood', 'Simulationcraft Death Knight Profile: Blood', 6, 1, [[
actions.precombat=flask
actions.precombat+=/food
actions.precombat+=/augmentation
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions=auto_attack
actions+=/mind_freeze
actions+=/blood_fury,if=cooldown.dancing_rune_weapon.ready&(!cooldown.blooddrinker.ready|!talent.blooddrinker.enabled)
actions+=/berserking
actions+=/use_items
actions+=/potion,if=buff.dancing_rune_weapon.up
actions+=/dancing_rune_weapon,if=!talent.blooddrinker.enabled|!cooldown.blooddrinker.ready
actions+=/tombstone,if=buff.bone_shield.stack>=7
actions+=/call_action_list,name=standard
actions.standard=death_strike,if=runic_power.deficit<=10
actions.standard+=/blooddrinker,if=!buff.dancing_rune_weapon.up
actions.standard+=/marrowrend,if=(buff.bone_shield.remains<=rune.time_to_3|buff.bone_shield.remains<=(gcd+cooldown.blooddrinker.ready*talent.blooddrinker.enabled*2)|buff.bone_shield.stack<3)&runic_power.deficit>=20
actions.standard+=/blood_boil,if=charges_fractional>=1.8&(buff.hemostasis.stack<=(5-spell_targets.blood_boil)|spell_targets.blood_boil>2)
actions.standard+=/marrowrend,if=buff.bone_shield.stack<5&talent.ossuary.enabled&runic_power.deficit>=15
actions.standard+=/bonestorm,if=runic_power>=100&!buff.dancing_rune_weapon.up
actions.standard+=/death_strike,if=runic_power.deficit<=(15+buff.dancing_rune_weapon.up*5+spell_targets.heart_strike*talent.heartbreaker.enabled*2)|target.time_to_die<10
actions.standard+=/death_and_decay,if=spell_targets.death_and_decay>=3
actions.standard+=/rune_strike,if=(charges_fractional>=1.8|buff.dancing_rune_weapon.up)&rune.time_to_3>=gcd
actions.standard+=/heart_strike,if=buff.dancing_rune_weapon.up|rune.time_to_4<gcd
actions.standard+=/blood_boil,if=buff.dancing_rune_weapon.up
actions.standard+=/death_and_decay,if=buff.crimson_scourge.up|talent.rapid_decomposition.enabled|spell_targets.death_and_decay>=2
actions.standard+=/consumption
actions.standard+=/blood_boil
actions.standard+=/heart_strike,if=rune.time_to_3<gcd|buff.bone_shield.stack>6
actions.standard+=/rune_strike
actions.standard+=/arcane_torrent,if=runic_power.deficit>20
]])

TJ:RegisterActionProfileList('simc::deathknight::frost', 'Simulationcraft Death Knight Profile: Frost', 6, 2, [[
actions.precombat=flask
actions.precombat+=/food
actions.precombat+=/augmentation
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions=auto_attack
actions+=/mind_freeze
actions+=/howling_blast,if=!dot.frost_fever.ticking&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
actions+=/glacial_advance,if=buff.icy_talons.remains<=gcd&buff.icy_talons.up&spell_targets.glacial_advance>=2&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
actions+=/frost_strike,if=buff.icy_talons.remains<=gcd&buff.icy_talons.up&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
actions+=/breath_of_sindragosa,if=cooldown.empower_rune_weapon.remains&cooldown.pillar_of_frost.remains
actions+=/call_action_list,name=cooldowns
actions+=/run_action_list,name=bos_pooling,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains<5
actions+=/run_action_list,name=bos_ticking,if=dot.breath_of_sindragosa.ticking
actions+=/run_action_list,name=obliteration,if=buff.pillar_of_frost.up&talent.obliteration.enabled
actions+=/run_action_list,name=aoe,if=active_enemies>=2
actions+=/call_action_list,name=standard
actions.aoe=remorseless_winter,if=talent.gathering_storm.enabled
actions.aoe+=/glacial_advance,if=talent.frostscythe.enabled
actions.aoe+=/frost_strike,if=cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled
actions.aoe+=/howling_blast,if=buff.rime.up
actions.aoe+=/frostscythe,if=buff.killing_machine.up
actions.aoe+=/glacial_advance,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
actions.aoe+=/frost_strike,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
actions.aoe+=/remorseless_winter
actions.aoe+=/frostscythe
actions.aoe+=/obliterate,if=runic_power.deficit>(25+talent.runic_attenuation.enabled*3)
actions.aoe+=/glacial_advance
actions.aoe+=/frost_strike
actions.aoe+=/horn_of_winter
actions.aoe+=/arcane_torrent
actions.bos_pooling=howling_blast,if=buff.rime.up
actions.bos_pooling+=/obliterate,if=rune.time_to_4<gcd&runic_power.deficit>=25
actions.bos_pooling+=/glacial_advance,if=runic_power.deficit<20&cooldown.pillar_of_frost.remains>rune.time_to_4
actions.bos_pooling+=/frost_strike,if=runic_power.deficit<20&cooldown.pillar_of_frost.remains>rune.time_to_4
actions.bos_pooling+=/frostscythe,if=buff.killing_machine.up&runic_power.deficit>(15+talent.runic_attenuation.enabled*3)
actions.bos_pooling+=/obliterate,if=runic_power.deficit>=(25+talent.runic_attenuation.enabled*3)
actions.bos_pooling+=/glacial_advance,if=cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40&spell_targets.glacial_advance>=2
actions.bos_pooling+=/frost_strike,if=cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40
actions.bos_ticking=obliterate,if=runic_power<=30
actions.bos_ticking+=/remorseless_winter,if=talent.gathering_storm.enabled
actions.bos_ticking+=/howling_blast,if=buff.rime.up
actions.bos_ticking+=/obliterate,if=rune.time_to_5<gcd|runic_power<=45
actions.bos_ticking+=/frostscythe,if=buff.killing_machine.up
actions.bos_ticking+=/horn_of_winter,if=runic_power.deficit>=30&rune.time_to_3>gcd
actions.bos_ticking+=/remorseless_winter
actions.bos_ticking+=/frostscythe,if=spell_targets.frostscythe>=2
actions.bos_ticking+=/obliterate,if=runic_power.deficit>25|rune>3
actions.bos_ticking+=/arcane_torrent,if=runic_power.deficit>20
actions.cold_heart=chains_of_ice,if=(buff.cold_heart_item.stack>5|buff.cold_heart_talent.stack>5)&target.time_to_die<gcd
actions.cold_heart+=/chains_of_ice,if=(buff.pillar_of_frost.remains<=gcd*(1+cooldown.frostwyrms_fury.ready)|buff.pillar_of_frost.remains<rune.time_to_3)&buff.pillar_of_frost.up
actions.cooldowns=use_items
actions.cooldowns+=/use_item,name=horn_of_valor,if=buff.pillar_of_frost.up&(!talent.breath_of_sindragosa.enabled|!cooldown.breath_of_sindragosa.remains)
actions.cooldowns+=/potion,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
actions.cooldowns+=/blood_fury,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
actions.cooldowns+=/berserking,if=buff.pillar_of_frost.up
actions.cooldowns+=/pillar_of_frost,if=cooldown.empower_rune_weapon.remains
actions.cooldowns+=/empower_rune_weapon,if=cooldown.pillar_of_frost.ready&!talent.breath_of_sindragosa.enabled&rune.time_to_5>gcd&runic_power.deficit>=10
actions.cooldowns+=/empower_rune_weapon,if=cooldown.pillar_of_frost.ready&talent.breath_of_sindragosa.enabled&rune>=3&runic_power>60
actions.cooldowns+=/call_action_list,name=cold_heart,if=(equipped.cold_heart|talent.cold_heart.enabled)&(((buff.cold_heart_item.stack>=10|buff.cold_heart_talent.stack>=10)&debuff.razorice.stack=5)|target.time_to_die<=gcd)
actions.cooldowns+=/frostwyrms_fury,if=(buff.pillar_of_frost.remains<=gcd&buff.pillar_of_frost.up)
actions.obliteration=remorseless_winter,if=talent.gathering_storm.enabled
actions.obliteration+=/obliterate,if=!talent.frostscythe.enabled&!buff.rime.up&spell_targets.howling_blast>=3
actions.obliteration+=/frostscythe,if=(buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance)))&(rune.time_to_4>gcd|spell_targets.frostscythe>=2)
actions.obliteration+=/obliterate,if=buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance))
actions.obliteration+=/glacial_advance,if=(!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd)&spell_targets.glacial_advance>=2
actions.obliteration+=/howling_blast,if=buff.rime.up&spell_targets.howling_blast>=2
actions.obliteration+=/frost_strike,if=!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd
actions.obliteration+=/howling_blast,if=buff.rime.up
actions.obliteration+=/obliterate
actions.standard=remorseless_winter
actions.standard+=/frost_strike,if=cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled
actions.standard+=/howling_blast,if=buff.rime.up
actions.standard+=/obliterate,if=!buff.frozen_pulse.up&talent.frozen_pulse.enabled
actions.standard+=/frost_strike,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
actions.standard+=/frostscythe,if=buff.killing_machine.up&rune.time_to_4>=gcd
actions.standard+=/obliterate,if=runic_power.deficit>(25+talent.runic_attenuation.enabled*3)
actions.standard+=/frost_strike
actions.standard+=/horn_of_winter
actions.standard+=/arcane_torrent
]])

TJ:RegisterActionProfileList('simc::deathknight::unholy', 'Simulationcraft Death Knight Profile: Unholy', 6, 3, [[
actions.precombat=flask
actions.precombat+=/food
actions.precombat+=/augmentation
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions.precombat+=/raise_dead
actions.precombat+=/army_of_the_dead
actions=auto_attack
actions+=/mind_freeze
actions+=/variable,name=pooling_for_gargoyle,value=(cooldown.summon_gargoyle.remains<5&(cooldown.dark_transformation.remains<5|!equipped.137075))&talent.summon_gargoyle.enabled
actions+=/arcane_torrent,if=runic_power.deficit>65&(pet.gargoyle.active|!talent.summon_gargoyle.enabled)&rune.deficit>=5
actions+=/blood_fury,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled
actions+=/berserking,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled
actions+=/use_items
actions+=/use_item,name=feloiled_infernal_machine,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled
actions+=/use_item,name=ring_of_collapsing_futures,if=(buff.temptation.stack=0&target.time_to_die>60)|target.time_to_die<60
actions+=/potion,if=cooldown.army_of_the_dead.ready|pet.gargoyle.active|buff.unholy_frenzy.up
actions+=/outbreak,target_if=(dot.virulent_plague.tick_time_remains+tick_time<=dot.virulent_plague.remains)&dot.virulent_plague.remains<=gcd
actions+=/call_action_list,name=cooldowns
actions+=/run_action_list,name=aoe,if=active_enemies>=2
actions+=/call_action_list,name=generic
actions.aoe=death_and_decay,if=cooldown.apocalypse.remains
actions.aoe+=/defile
actions.aoe+=/epidemic,if=death_and_decay.ticking&rune<2&!variable.pooling_for_gargoyle
actions.aoe+=/death_coil,if=death_and_decay.ticking&rune<2&!variable.pooling_for_gargoyle
actions.aoe+=/scourge_strike,if=death_and_decay.ticking&cooldown.apocalypse.remains
actions.aoe+=/clawing_shadows,if=death_and_decay.ticking&cooldown.apocalypse.remains
actions.aoe+=/epidemic,if=!variable.pooling_for_gargoyle
actions.aoe+=/festering_strike,if=talent.bursting_sores.enabled&spell_targets.bursting_sores>=2&debuff.festering_wound.stack<=1
actions.aoe+=/death_coil,if=buff.sudden_doom.react&rune.deficit>=4
actions.aoe+=/death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active
actions.aoe+=/death_coil,if=runic_power.deficit<14&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)&!variable.pooling_for_gargoyle
actions.aoe+=/scourge_strike,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&cooldown.army_of_the_dead.remains>5
actions.aoe+=/clawing_shadows,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&cooldown.army_of_the_dead.remains>5
actions.aoe+=/death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
actions.aoe+=/festering_strike,if=((((debuff.festering_wound.stack<4&!buff.unholy_frenzy.up)|debuff.festering_wound.stack<3)&cooldown.apocalypse.remains<3)|debuff.festering_wound.stack<1)&cooldown.army_of_the_dead.remains>5
actions.aoe+=/death_coil,if=!variable.pooling_for_gargoyle
actions.cold_heart=chains_of_ice,if=buff.unholy_strength.remains<gcd&buff.unholy_strength.react&buff.cold_heart_item.stack>16
actions.cold_heart+=/chains_of_ice,if=buff.master_of_ghouls.remains<gcd&buff.master_of_ghouls.up&buff.cold_heart_item.stack>17
actions.cold_heart+=/chains_of_ice,if=buff.cold_heart_item.stack=20&buff.unholy_strength.react
actions.cooldowns=call_action_list,name=cold_heart,if=equipped.cold_heart&buff.cold_heart_item.stack>10
actions.cooldowns+=/army_of_the_dead
actions.cooldowns+=/apocalypse,if=debuff.festering_wound.stack>=4
actions.cooldowns+=/dark_transformation,if=(equipped.137075&cooldown.summon_gargoyle.remains>40)|(!equipped.137075|!talent.summon_gargoyle.enabled)
actions.cooldowns+=/summon_gargoyle,if=runic_power.deficit<14
actions.cooldowns+=/unholy_frenzy,if=debuff.festering_wound.stack<4
actions.cooldowns+=/unholy_frenzy,if=active_enemies>=2&((cooldown.death_and_decay.remains<=gcd&!talent.defile.enabled)|(cooldown.defile.remains<=gcd&talent.defile.enabled))
actions.cooldowns+=/soul_reaper,target_if=(target.time_to_die<8|rune<=2)&!buff.unholy_frenzy.up
actions.cooldowns+=/unholy_blight
actions.generic=death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active
actions.generic+=/death_coil,if=runic_power.deficit<14&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)&!variable.pooling_for_gargoyle
actions.generic+=/death_and_decay,if=talent.pestilence.enabled&cooldown.apocalypse.remains
actions.generic+=/defile,if=cooldown.apocalypse.remains
actions.generic+=/scourge_strike,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&cooldown.army_of_the_dead.remains>5
actions.generic+=/clawing_shadows,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&cooldown.army_of_the_dead.remains>5
actions.generic+=/death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
actions.generic+=/festering_strike,if=((((debuff.festering_wound.stack<4&!buff.unholy_frenzy.up)|debuff.festering_wound.stack<3)&cooldown.apocalypse.remains<3)|debuff.festering_wound.stack<1)&cooldown.army_of_the_dead.remains>5
actions.generic+=/death_coil,if=!variable.pooling_for_gargoyle
]])

