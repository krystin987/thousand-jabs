local _, internal = ...
internal.apls = internal.apls or {}

internal.apls['custom::monk::brewmaster'] = [[
actions=auto_attack
actions+=/variable,name=heal_threshold,value=health.pct<80
actions+=/purifying_brew,if=stagger.heavy
actions+=/ironskin_brew,if=charges>1&buff.ironskin_brew.down&incoming_damage_1s>0
actions+=/chi_wave,if=talent.chi_wave.enabled&variable.heal_threshold
actions+=/call_action_list,name=ooc,if=!in_combat
actions+=/call_action_list,name=oh_shit,if=incoming_damage_5s>=health.max*0.65|health.pct<35
actions+=/call_action_list,name=st,if=active_enemies<3
actions+=/call_action_list,name=aoe,if=active_enemies>=3
actions.ooc+=/purifying_brew,if=stagger.any
actions.ooc+=/expel_harm,if=variable.heal_threshold
actions.ooc+=/effuse,if=variable.heal_threshold
actions.oh_shit=fortifying_brew
actions.oh_shit+=/ironskin_brew,if=buff.ironskin_brew.down
actions.oh_shit+=/purifying_brew,if=stagger.heavy|stagger.moderate
actions.oh_shit+=/healing_elixir,if=talent.healing_elixir.enabled
actions.oh_shit+=/expel_harm
actions.oh_shit+=/black_ox_brew,if=spell.ironskin_brew.charges=0
actions.st=keg_smash
actions.st+=/exploding_keg
actions.st+=/tiger_palm,if=energy>65
actions.st+=/tiger_palm,if=buff.eye_of_the_tiger.down|buff.eye_of_the_tiger.remains<gcd*2
actions.st+=/blackout_strike
actions.st+=/rushing_jade_wind,if=talent.rushing_jade_wind.enabled
actions.st+=/breath_of_fire,if=debuff.keg_smash.up
actions.st+=/chi_burst,if=talent.chi_burst.enabled
actions.st+=/expel_harm,if=charges=3&variable.heal_threshold
actions.aoe=keg_smash
actions.aoe+=/exploding_keg
actions.aoe+=/chi_burst,if=talent.chi_burst.enabled
actions.aoe+=/breath_of_fire,if=debuff.keg_smash.up
actions.aoe+=/rushing_jade_wind,if=talent.rushing_jade_wind.enabled
actions.aoe+=/tiger_palm,if=energy>65
actions.aoe+=/tiger_palm,if=buff.eye_of_the_tiger.down|buff.eye_of_the_tiger.remains<gcd*2
actions.aoe+=/blackout_strike
actions.aoe+=/expel_harm,if=charges=3&variable.heal_threshold
]]

internal.apls['legion-dev::monk::brewmaster'] = [[
actions.precombat=flask,type=greater_draenic_agility_flask
actions.precombat+=/food,type=sleeper_sushi
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=draenic_agility
actions.precombat+=/dampen_harm
actions.precombat+=/chi_burst
actions.precombat+=/chi_wave
actions=auto_attack
actions+=/call_action_list,name=st,if=active_enemies<3
actions.st=keg_smash
actions.st+=/blackout_strike
actions.st+=/exploding_keg
actions.st+=/chi_burst
actions.st+=/chi_wave
actions.st+=/rushing_jade_wind
actions.st+=/breath_of_fire
actions.st+=/tiger_palm
]]

internal.apls['legion-dev::monk::windwalker'] = [[
actions.precombat=flask,type=flask_of_the_seventh_demon
actions.precombat+=/food,type=the_hungry_magister
actions.precombat+=/augmentation,type=defiled
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=old_war
actions=auto_attack
actions+=/spear_hand_strike,if=target.debuff.casting.react
actions+=/potion,name=old_war,if=buff.serenity.up|buff.storm_earth_and_fire.up|(!talent.serenity.enabled&trinket.proc.agility.react)|buff.bloodlust.react|target.time_to_die<=60
actions+=/call_action_list,name=serenity,if=(talent.serenity.enabled&cooldown.serenity.remains<=0)|buff.serenity.up
actions+=/call_action_list,name=sef,if=!talent.serenity.enabled&((artifact.strike_of_the_windlord.enabled&cooldown.strike_of_the_windlord.remains<=14&cooldown.fists_of_fury.remains<=6&cooldown.rising_sun_kick.remains<=6)|buff.storm_earth_and_fire.up)
actions+=/call_action_list,name=sef,if=!talent.serenity.enabled&((!artifact.strike_of_the_windlord.enabled&cooldown.fists_of_fury.remains<=9&cooldown.rising_sun_kick.remains<=5)|buff.storm_earth_and_fire.up)
actions+=/call_action_list,name=st
actions.cd=invoke_xuen
actions.cd+=/blood_fury
actions.cd+=/berserking
actions.cd+=/touch_of_death,cycle_targets=1,max_cycle_targets=2,if=!artifact.gale_burst.enabled&equipped.137057&(prev_gcd.2.touch_of_death|prev_gcd.3.touch_of_death|prev_gcd.4.touch_of_death)
actions.cd+=/touch_of_death,if=!artifact.gale_burst.enabled&!equipped.137057
actions.cd+=/touch_of_death,cycle_targets=1,max_cycle_targets=2,if=artifact.gale_burst.enabled&equipped.137057&cooldown.strike_of_the_windlord.remains<8&cooldown.fists_of_fury.remains<=4&cooldown.rising_sun_kick.remains<7&(prev_gcd.2.touch_of_death|prev_gcd.3.touch_of_death|prev_gcd.4.touch_of_death)
actions.cd+=/touch_of_death,if=artifact.gale_burst.enabled&!equipped.137057&cooldown.strike_of_the_windlord.remains<8&cooldown.fists_of_fury.remains<=4&cooldown.rising_sun_kick.remains<7
actions.sef=energizing_elixir
actions.sef+=/arcane_torrent,if=chi.max-chi>=1&energy.time_to_max>=0.5
actions.sef+=/call_action_list,name=cd
actions.sef+=/storm_earth_and_fire
actions.sef+=/call_action_list,name=st
actions.serenity=call_action_list,name=cd
actions.serenity+=/serenity
actions.serenity+=/strike_of_the_windlord
actions.serenity+=/rising_sun_kick,cycle_targets=1,if=active_enemies<3
actions.serenity+=/fists_of_fury
actions.serenity+=/spinning_crane_kick,if=active_enemies>=3&!prev_gcd.1.spinning_crane_kick
actions.serenity+=/rising_sun_kick,cycle_targets=1,if=active_enemies>=3
actions.serenity+=/spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick
actions.serenity+=/blackout_kick,cycle_targets=1,if=!prev_gcd.1.blackout_kick
actions.serenity+=/rushing_jade_wind,if=!prev_gcd.1.rushing_jade_wind
actions.st=call_action_list,name=cd
actions.st+=/arcane_torrent,if=chi.max-chi>=1&energy.time_to_max>=0.5
actions.st+=/energizing_elixir,if=energy<energy.max&chi<=1
actions.st+=/strike_of_the_windlord,if=equipped.140806&talent.serenity.enabled&cooldown.serenity.remains>=10
actions.st+=/strike_of_the_windlord,if=equipped.140806&!talent.serenity.enabled
actions.st+=/strike_of_the_windlord,if=!equipped.140806
actions.st+=/fists_of_fury,if=equipped.140806&talent.serenity.enabled&cooldown.serenity.remains>=5
actions.st+=/fists_of_fury,if=equipped.140806&!talent.serenity.enabled
actions.st+=/fists_of_fury,if=!equipped.140806
actions.st+=/rising_sun_kick,cycle_targets=1,if=equipped.140806&talent.serenity.enabled&cooldown.serenity.remains>=2
actions.st+=/rising_sun_kick,cycle_targets=1,if=equipped.140806&!talent.serenity.enabled
actions.st+=/rising_sun_kick,cycle_targets=1,if=!equipped.140806
actions.st+=/whirling_dragon_punch
actions.st+=/crackling_jade_lightning,if=equipped.144239&buff.the_emperors_capacitor.stack>=19
actions.st+=/spinning_crane_kick,if=active_enemies>=3&!prev_gcd.1.spinning_crane_kick
actions.st+=/rushing_jade_wind,if=chi.max-chi>1&!prev_gcd.1.rushing_jade_wind
actions.st+=/blackout_kick,cycle_targets=1,if=(chi>1|buff.bok_proc.up)&!prev_gcd.1.blackout_kick
actions.st+=/chi_wave,if=energy.time_to_max>=2.25
actions.st+=/chi_burst,if=energy.time_to_max>=2.25
actions.st+=/tiger_palm,cycle_targets=1,if=!prev_gcd.1.tiger_palm
]]

