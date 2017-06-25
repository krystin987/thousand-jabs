local addonName = ...
if select(3, UnitClass('player')) ~= 2 then return end
local TJ = LibStub('LibSandbox-5.0'):GetSandbox(addonName).TJ
local Engine = LibStub('LibSandbox-5.0'):GetSandbox(addonName).Engine

Engine:RegisterActionProfileList('simc::paladin::protection', 'Simulationcraft Paladin Profile: Protection', 2, 2, [[
actions.precombat=flask,type=flask_of_ten_thousand_scars
actions.precombat+=/flask,type=flask_of_the_countless_armies,if=role.attack|using_apl.max_dps
actions.precombat+=/food,type=seedbattered_fish_plate
actions.precombat+=/food,type=azshari_salad,if=role.attack|using_apl.max_dps
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=unbending_potion
actions=auto_attack
actions+=/blood_fury
actions+=/berserking
actions+=/arcane_torrent
actions+=/blood_fury
actions+=/berserking
actions+=/arcane_torrent
actions+=/call_action_list,name=prot
actions.max_dps=auto_attack
actions.max_dps+=/blood_fury
actions.max_dps+=/berserking
actions.max_dps+=/arcane_torrent
actions.max_survival=auto_attack
actions.max_survival+=/blood_fury
actions.max_survival+=/berserking
actions.max_survival+=/arcane_torrent
actions.prot=seraphim,if=talent.seraphim.enabled&action.shield_of_the_righteous.charges>=2
actions.prot+=/shield_of_the_righteous,if=(!talent.seraphim.enabled|action.shield_of_the_righteous.charges>2)&!(debuff.eye_of_tyr.up&buff.aegis_of_light.up&buff.ardent_defender.up&buff.guardian_of_ancient_kings.up&buff.divine_shield.up&buff.potion.up)
actions.prot+=/shield_of_the_righteous,if=(talent.bastion_of_light.enabled&talent.seraphim.enabled&buff.seraphim.up&cooldown.bastion_of_light.up)&!(debuff.eye_of_tyr.up&buff.aegis_of_light.up&buff.ardent_defender.up&buff.guardian_of_ancient_kings.up&buff.divine_shield.up&buff.potion.up)
actions.prot+=/shield_of_the_righteous,if=(talent.bastion_of_light.enabled&!talent.seraphim.enabled&cooldown.bastion_of_light.up)&!(debuff.eye_of_tyr.up&buff.aegis_of_light.up&buff.ardent_defender.up&buff.guardian_of_ancient_kings.up&buff.divine_shield.up&buff.potion.up)
actions.prot+=/bastion_of_light,if=talent.bastion_of_light.enabled&action.shield_of_the_righteous.charges<1
actions.prot+=/light_of_the_protector,if=(health.pct<40)
actions.prot+=/hand_of_the_protector,if=(health.pct<40)
actions.prot+=/light_of_the_protector,if=(incoming_damage_10000ms<health.max*1.25)&health.pct<55&talent.righteous_protector.enabled
actions.prot+=/light_of_the_protector,if=(incoming_damage_13000ms<health.max*1.6)&health.pct<55
actions.prot+=/hand_of_the_protector,if=(incoming_damage_6000ms<health.max*0.7)&health.pct<65&talent.righteous_protector.enabled
actions.prot+=/hand_of_the_protector,if=(incoming_damage_9000ms<health.max*1.2)&health.pct<55
actions.prot+=/divine_steed,if=talent.knight_templar.enabled&incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
actions.prot+=/eye_of_tyr,if=incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
actions.prot+=/aegis_of_light,if=incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
actions.prot+=/guardian_of_ancient_kings,if=incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
actions.prot+=/divine_shield,if=talent.final_stand.enabled&incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
actions.prot+=/ardent_defender,if=incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
actions.prot+=/lay_on_hands,if=health.pct<15
actions.prot+=/potion,name=unbending_potion
actions.prot+=/potion,name=draenic_strength,if=incoming_damage_2500ms>health.max*0.4&&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)|target.time_to_die<=25
actions.prot+=/stoneform,if=incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
actions.prot+=/avenging_wrath,if=!talent.seraphim.enabled
actions.prot+=/avenging_wrath,if=talent.seraphim.enabled&buff.seraphim.up
actions.prot+=/judgment
actions.prot+=/avengers_shield,if=talent.crusaders_judgment.enabled&buff.grand_crusader.up
actions.prot+=/blessed_hammer
actions.prot+=/avengers_shield
actions.prot+=/consecration
actions.prot+=/blinding_light
actions.prot+=/hammer_of_the_righteous
]])

Engine:RegisterActionProfileList('simc::paladin::retribution', 'Simulationcraft Paladin Profile: Retribution', 2, 3, [[
actions.precombat=flask,type=flask_of_the_countless_armies
actions.precombat+=/food,type=azshari_salad
actions.precombat+=/augmentation,type=defiled
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=old_war
actions=auto_attack
actions+=/rebuke
actions+=/call_action_list,name=opener,if=time<2
actions+=/call_action_list,name=cooldowns
actions+=/call_action_list,name=priority
actions.cooldowns=potion,name=old_war,if=(buff.bloodlust.react|buff.avenging_wrath.up|buff.crusade.up&buff.crusade.remains<25|target.time_to_die<=40)
actions.cooldowns+=/blood_fury
actions.cooldowns+=/berserking
actions.cooldowns+=/arcane_torrent,if=holy_power<=4
actions.cooldowns+=/holy_wrath
actions.cooldowns+=/shield_of_vengeance
actions.cooldowns+=/avenging_wrath
actions.cooldowns+=/crusade,if=holy_power>=3|((equipped.137048|race.blood_elf)&holy_power>=2)
actions.opener=blood_fury
actions.opener+=/berserking
actions.opener+=/arcane_torrent
actions.opener+=/judgment
actions.opener+=/blade_of_justice,if=equipped.137048|race.blood_elf|!cooldown.wake_of_ashes.up
actions.opener+=/divine_hammer,if=equipped.137048|race.blood_elf|!cooldown.wake_of_ashes.up
actions.opener+=/wake_of_ashes
actions.priority=execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5|debuff.judgment.remains>gcd*4.5)
actions.priority+=/variable,name=ds_castable,value=spell_targets.divine_storm>=2|(buff.scarlet_inquisitors_expurgation.stack>=29&(buff.avenging_wrath.up|(buff.crusade.up&buff.crusade.stack>=15)|(cooldown.crusade.remains>15&!buff.crusade.up)|cooldown.avenging_wrath.remains>15))
actions.priority+=/divine_storm,if=debuff.judgment.up&variable.ds_castable&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.priority+=/divine_storm,if=debuff.judgment.up&variable.ds_castable&holy_power>=5&buff.divine_purpose.react
actions.priority+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=3&(buff.crusade.up&buff.crusade.stack<15|buff.liadrins_fury_unleashed.up)
actions.priority+=/divine_storm,if=debuff.judgment.up&variable.ds_castable&holy_power>=5
actions.priority+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.137020
actions.priority+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.137020
actions.priority+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.priority+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
actions.priority+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(buff.crusade.up&buff.crusade.stack<15|buff.liadrins_fury_unleashed.up)
actions.priority+=/templars_verdict,if=debuff.judgment.up&holy_power>=5
actions.priority+=/divine_storm,if=debuff.judgment.up&variable.ds_castable&artifact.wake_of_ashes.enabled&cooldown.wake_of_ashes.remains<gcd*2
actions.priority+=/divine_storm,if=debuff.judgment.up&variable.ds_castable&buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd*1.5
actions.priority+=/templars_verdict,if=(equipped.137020|debuff.judgment.up)&artifact.wake_of_ashes.enabled&cooldown.wake_of_ashes.remains<gcd*2
actions.priority+=/templars_verdict,if=debuff.judgment.up&buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd*1.5
actions.priority+=/judgment,if=dot.execution_sentence.ticking&dot.execution_sentence.remains<gcd*2&debuff.judgment.remains<gcd*2
actions.priority+=/consecration,if=(cooldown.blade_of_justice.remains>gcd*2|cooldown.divine_hammer.remains>gcd*2)
actions.priority+=/wake_of_ashes,if=(!raid_event.adds.exists|raid_event.adds.in>15)&(holy_power<=0|holy_power=1&(cooldown.blade_of_justice.remains>gcd|cooldown.divine_hammer.remains>gcd)|holy_power=2&((cooldown.zeal.charges_fractional<=0.65|cooldown.crusader_strike.charges_fractional<=0.65)))
actions.priority+=/blade_of_justice,if=holy_power<=3-set_bonus.tier20_4pc
actions.priority+=/divine_hammer,if=holy_power<=3-set_bonus.tier20_4pc
actions.priority+=/judgment
actions.priority+=/zeal,if=cooldown.zeal.charges_fractional>=1.65&holy_power<=4&(cooldown.blade_of_justice.remains>gcd*2|cooldown.divine_hammer.remains>gcd*2)&debuff.judgment.remains>gcd
actions.priority+=/crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.65-talent.the_fires_of_justice.enabled*0.25&holy_power<=4&(cooldown.blade_of_justice.remains>gcd*2|cooldown.divine_hammer.remains>gcd*2)&debuff.judgment.remains>gcd
actions.priority+=/consecration
actions.priority+=/divine_storm,if=debuff.judgment.up&variable.ds_castable&buff.divine_purpose.react
actions.priority+=/divine_storm,if=debuff.judgment.up&variable.ds_castable&buff.the_fires_of_justice.react
actions.priority+=/divine_storm,if=debuff.judgment.up&variable.ds_castable
actions.priority+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.137020
actions.priority+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
actions.priority+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react
actions.priority+=/templars_verdict,if=debuff.judgment.up&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>gcd*2)
actions.priority+=/hammer_of_justice,if=equipped.137065&target.health.pct>=75&holy_power<=4
actions.priority+=/zeal,if=holy_power<=4
actions.priority+=/crusader_strike,if=holy_power<=4
]])

