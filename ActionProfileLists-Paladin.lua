local _, internal = ...
internal.apls = internal.apls or {}

internal.apls["legion-dev::Tier19P::Paladin_Prot_T19P"] = [[
actions.precombat=flask,type=flask_of_ten_thousand_scars
actions.precombat+=/food,type=seed_battered_fish_plate
actions.precombat+=/snapshot_stats
actions=auto_attack,damage=3300000,range=1000000,attack_speed=1.5
actions+=/spell_nuke,damage=3000000,cooldown=30
actions+=/spell_dot,damage=50000,cooldown=20
]]

internal.apls["legion-dev::Tier19P::Paladin_Retribution_T19P"] = [[
actions.precombat=flask,type=flask_of_the_countless_armies
actions.precombat+=/food,type=azshari_salad
actions.precombat+=/greater_blessing_of_might
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=the_old_war
actions=auto_attack
actions+=/rebuke
actions+=/potion,name=the_old_war
actions+=/holy_wrath
actions+=/avenging_wrath
actions+=/crusade,if=holy_power>=5
actions+=/wake_of_ashes,if=holy_power>=0&time<2
actions+=/blood_fury
actions+=/berserking
actions+=/arcane_torrent
actions+=/call_action_list,name=VB,if=talent.virtues_blade.enabled
actions+=/call_action_list,name=BoW,if=talent.blade_of_wrath.enabled
actions+=/call_action_list,name=DH,if=talent.divine_hammer.enabled
actions.VB=divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.VB+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
actions.VB+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
actions.VB+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.VB+=/divine_storm,if=holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.VB+=/justicars_vengeance,if=holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
actions.VB+=/templars_verdict,if=holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.VB+=/wake_of_ashes,if=holy_power<=1|(holy_power<=2&cooldown.blade_of_justice.remains>gcd&(cooldown.zeal.charges_fractional<=0.67|cooldown.crusader_strike.charges_fractional<=0.67))
actions.VB+=/zeal,if=charges=2&holy_power<=4
actions.VB+=/crusader_strike,if=charges=2&holy_power<=4
actions.VB+=/blade_of_justice,if=holy_power<=2|(holy_power<=3&(cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34))
actions.VB+=/judgment,if=holy_power>=3|((cooldown.zeal.charges_fractional<=1.67|cooldown.crusader_strike.charges_fractional<=1.67)&cooldown.blade_of_justice.remains>gcd)|(talent.greater_judgment.enabled&target.health.pct>50)
actions.VB+=/consecration
actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=4&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.VB+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
actions.VB+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
actions.VB+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=4&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.VB+=/zeal,if=holy_power<=4
actions.VB+=/crusader_strike,if=holy_power<=4
actions.VB+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
actions.BoW=divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&debuff.judgment.up&debuff.judgment.remains<gcd&talent.the_fires_of_justice.enabled
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
actions.BoW+=/templars_verdict,if=debuff.judgment.up&debuff.judgment.remains<gcd&talent.the_fires_of_justice.enabled
actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.BoW+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
actions.BoW+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.BoW+=/divine_storm,if=holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.BoW+=/justicars_vengeance,if=holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
actions.BoW+=/templars_verdict,if=holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.BoW+=/wake_of_ashes,if=holy_power<=1|(holy_power<=2&cooldown.blade_of_justice.remains>gcd&(cooldown.zeal.charges_fractional<=0.67|cooldown.crusader_strike.charges_fractional<=0.67))
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react&talent.the_fires_of_justice.enabled
actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim&talent.the_fires_of_justice.enabled
actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react&talent.the_fires_of_justice.enabled
actions.BoW+=/zeal,if=charges=2&holy_power<=4
actions.BoW+=/crusader_strike,if=charges=2&holy_power<=4&!talent.the_fires_of_justice.enabled
actions.BoW+=/blade_of_wrath,if=holy_power<=2|(holy_power<=3&(cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34))
actions.BoW+=/crusader_strike,if=charges=2&holy_power<=4&talent.the_fires_of_justice.enabled
actions.BoW+=/judgment
actions.BoW+=/consecration
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&(holy_power>=4|talent.divine_purpose.enabled)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.BoW+=/templars_verdict,if=debuff.judgment.up&(holy_power>=4|talent.divine_purpose.enabled)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.BoW+=/zeal,if=holy_power<=4
actions.BoW+=/crusader_strike,if=holy_power<=4
actions.BoW+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
actions.BoW+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
actions.DH=divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.DH+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
actions.DH+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
actions.DH+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.DH+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
actions.DH+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.DH+=/divine_storm,if=holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.DH+=/justicars_vengeance,if=holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
actions.DH+=/templars_verdict,if=holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.DH+=/wake_of_ashes,if=holy_power<=1|(holy_power<=2&cooldown.blade_of_justice.remains>gcd&(cooldown.zeal.charges_fractional<=0.67|cooldown.crusader_strike.charges_fractional<=0.67))
actions.DH+=/zeal,if=charges=2&holy_power<=4
actions.DH+=/crusader_strike,if=charges=2&holy_power<=4&!talent.the_fires_of_justice.enabled
actions.DH+=/divine_hammer,if=holy_power<=3
actions.DH+=/crusader_strike,if=charges=2&holy_power<=4&talent.the_fires_of_justice.enabled
actions.DH+=/judgment
actions.DH+=/consecration
actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*6)
actions.DH+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
actions.DH+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
actions.DH+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
actions.DH+=/templars_verdict,if=debuff.judgment.up&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*6)
actions.DH+=/zeal,if=holy_power<=4
actions.DH+=/crusader_strike,if=holy_power<=4
]]

internal.apls["legion-dev::Tier19H::Paladin_Retribution_T19H"] = [[
actions.precombat=flask,type=flask_of_the_countless_armies
actions.precombat+=/food,type=azshari_salad
actions.precombat+=/greater_blessing_of_might
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=the_old_war
actions=auto_attack
actions+=/rebuke
actions+=/potion,name=the_old_war
actions+=/holy_wrath
actions+=/avenging_wrath
actions+=/crusade,if=holy_power>=5
actions+=/wake_of_ashes,if=holy_power>=0&time<2
actions+=/blood_fury
actions+=/berserking
actions+=/arcane_torrent
actions+=/call_action_list,name=VB,if=talent.virtues_blade.enabled
actions+=/call_action_list,name=BoW,if=talent.blade_of_wrath.enabled
actions+=/call_action_list,name=DH,if=talent.divine_hammer.enabled
actions.VB=divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.VB+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
actions.VB+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
actions.VB+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.VB+=/divine_storm,if=holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.VB+=/justicars_vengeance,if=holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
actions.VB+=/templars_verdict,if=holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.VB+=/wake_of_ashes,if=holy_power<=1|(holy_power<=2&cooldown.blade_of_justice.remains>gcd&(cooldown.zeal.charges_fractional<=0.67|cooldown.crusader_strike.charges_fractional<=0.67))
actions.VB+=/zeal,if=charges=2&holy_power<=4
actions.VB+=/crusader_strike,if=charges=2&holy_power<=4
actions.VB+=/blade_of_justice,if=holy_power<=2|(holy_power<=3&(cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34))
actions.VB+=/judgment,if=holy_power>=3|((cooldown.zeal.charges_fractional<=1.67|cooldown.crusader_strike.charges_fractional<=1.67)&cooldown.blade_of_justice.remains>gcd)|(talent.greater_judgment.enabled&target.health.pct>50)
actions.VB+=/consecration
actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=4&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.VB+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
actions.VB+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
actions.VB+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=4&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.VB+=/zeal,if=holy_power<=4
actions.VB+=/crusader_strike,if=holy_power<=4
actions.VB+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
actions.BoW=divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&debuff.judgment.up&debuff.judgment.remains<gcd&talent.the_fires_of_justice.enabled
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
actions.BoW+=/templars_verdict,if=debuff.judgment.up&debuff.judgment.remains<gcd&talent.the_fires_of_justice.enabled
actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.BoW+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
actions.BoW+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.BoW+=/divine_storm,if=holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.BoW+=/justicars_vengeance,if=holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
actions.BoW+=/templars_verdict,if=holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.BoW+=/wake_of_ashes,if=holy_power<=1|(holy_power<=2&cooldown.blade_of_justice.remains>gcd&(cooldown.zeal.charges_fractional<=0.67|cooldown.crusader_strike.charges_fractional<=0.67))
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react&talent.the_fires_of_justice.enabled
actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim&talent.the_fires_of_justice.enabled
actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react&talent.the_fires_of_justice.enabled
actions.BoW+=/zeal,if=charges=2&holy_power<=4
actions.BoW+=/crusader_strike,if=charges=2&holy_power<=4&!talent.the_fires_of_justice.enabled
actions.BoW+=/blade_of_wrath,if=holy_power<=2|(holy_power<=3&(cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34))
actions.BoW+=/crusader_strike,if=charges=2&holy_power<=4&talent.the_fires_of_justice.enabled
actions.BoW+=/judgment
actions.BoW+=/consecration
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&(holy_power>=4|talent.divine_purpose.enabled)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.BoW+=/templars_verdict,if=debuff.judgment.up&(holy_power>=4|talent.divine_purpose.enabled)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.BoW+=/zeal,if=holy_power<=4
actions.BoW+=/crusader_strike,if=holy_power<=4
actions.BoW+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
actions.BoW+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
actions.DH=divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.DH+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
actions.DH+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
actions.DH+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
actions.DH+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
actions.DH+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
actions.DH+=/divine_storm,if=holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.DH+=/justicars_vengeance,if=holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
actions.DH+=/templars_verdict,if=holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
actions.DH+=/wake_of_ashes,if=holy_power<=1|(holy_power<=2&cooldown.blade_of_justice.remains>gcd&(cooldown.zeal.charges_fractional<=0.67|cooldown.crusader_strike.charges_fractional<=0.67))
actions.DH+=/zeal,if=charges=2&holy_power<=4
actions.DH+=/crusader_strike,if=charges=2&holy_power<=4&!talent.the_fires_of_justice.enabled
actions.DH+=/divine_hammer,if=holy_power<=3
actions.DH+=/crusader_strike,if=charges=2&holy_power<=4&talent.the_fires_of_justice.enabled
actions.DH+=/judgment
actions.DH+=/consecration
actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*6)
actions.DH+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
actions.DH+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
actions.DH+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
actions.DH+=/templars_verdict,if=debuff.judgment.up&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*6)
actions.DH+=/zeal,if=holy_power<=4
actions.DH+=/crusader_strike,if=holy_power<=4
]]

internal.apls["legion-dev::legion::Paladin_Prot_Legion"] = [[
actions.precombat=flask,type=flask_of_the_seventh_demon
actions.precombat+=/food,type=the_hungry_magister
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=draenic_strength_potion
actions=auto_attack,damage=3300000,range=1000000,attack_speed=1.5
actions+=/spell_nuke,damage=3000000,cooldown=30
actions+=/spell_dot,damage=50000,cooldown=20
]]
