local _, internal = ...
internal.apls = internal.apls or {}

internal.apls["legion-dev::Tier19P::Monk_Windwalker_T19P"] = [[
actions.precombat=flask,type=flask_of_the_seventh_demon
actions.precombat+=/food,type=fishbrul_special
actions.precombat+=/augmentation,type=defiled
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=old_war
actions=auto_attack
actions+=/invoke_xuen
actions+=/call_action_list,name=opener,if=time<15
actions+=/potion,name=old_war,if=buff.serenity.up|buff.storm_earth_and_fire.up|(!talent.serenity.enabled&trinket.proc.agility.react)|buff.bloodlust.react|target.time_to_die<=60
actions+=/serenity,if=cooldown.strike_of_the_windlord.remains<14&cooldown.fists_of_fury.remains<=15&cooldown.rising_sun_kick.remains<7
actions+=/touch_of_death,cycle_targets=1,max_cycle_targets=2,if=!artifact.gale_burst.enabled&equipped.137057&!prev_gcd.touch_of_death
actions+=/touch_of_death,if=!artifact.gale_burst.enabled&!equipped.137057
actions+=/touch_of_death,cycle_targets=1,max_cycle_targets=2,if=artifact.gale_burst.enabled&equipped.137057&cooldown.strike_of_the_windlord.remains<8&cooldown.fists_of_fury.remains<=4&cooldown.rising_sun_kick.remains<7&!prev_gcd.touch_of_death
actions+=/touch_of_death,if=artifact.gale_burst.enabled&!equipped.137057&cooldown.strike_of_the_windlord.remains<8&cooldown.fists_of_fury.remains<=4&cooldown.rising_sun_kick.remains<7
actions+=/blood_fury
actions+=/berserking
actions+=/arcane_torrent,if=chi.max-chi>=1
actions+=/storm_earth_and_fire,if=artifact.strike_of_the_windlord.enabled&cooldown.strike_of_the_windlord.remains<13&cooldown.fists_of_fury.remains<=9&cooldown.rising_sun_kick.remains<=5
actions+=/storm_earth_and_fire,if=!artifact.strike_of_the_windlord.enabled&cooldown.fists_of_fury.remains<=9&cooldown.rising_sun_kick.remains<=5
actions+=/serenity,if=!artifact.strike_of_the_windlord.enabled&cooldown.strike_of_the_windlord.remains<14&cooldown.fists_of_fury.remains<=15&cooldown.rising_sun_kick.remains<7
actions+=/call_action_list,name=serenity,if=buff.serenity.up
actions+=/energizing_elixir,if=energy<energy.max&chi<=1&buff.serenity.down
actions+=/strike_of_the_windlord,if=talent.serenity.enabled|active_enemies<6
actions+=/fists_of_fury
actions+=/rising_sun_kick,cycle_targets=1
actions+=/whirling_dragon_punch
actions+=/call_action_list,name=st,if=active_enemies<3
actions+=/call_action_list,name=aoe,if=active_enemies>=3
actions.aoe=spinning_crane_kick,if=!prev_gcd.spinning_crane_kick
actions.aoe+=/rushing_jade_wind,if=chi>1&!prev_gcd.rushing_jade_wind
actions.aoe+=/blackout_kick,cycle_targets=1,if=(chi>1|buff.bok_proc.up)&!prev_gcd.blackout_kick
actions.aoe+=/chi_wave,if=energy.time_to_max>2
actions.aoe+=/chi_burst,if=energy.time_to_max>2
actions.aoe+=/tiger_palm,cycle_targets=1,if=chi.max-chi>1&!prev_gcd.tiger_palm
actions.opener=blood_fury
actions.opener+=/berserking
actions.opener+=/energizing_elixir
actions.opener+=/touch_of_death,cycle_targets=1,max_cycle_targets=2,if=equipped.137057&!prev_gcd.touch_of_death
actions.opener+=/touch_of_death,if=!equipped.137057
actions.opener+=/serenity
actions.opener+=/storm_earth_and_fire
actions.opener+=/rising_sun_kick,cycle_targets=1,if=buff.serenity.up
actions.opener+=/strike_of_the_windlord,if=talent.serenity.enabled|active_enemies<6
actions.opener+=/fists_of_fury
actions.opener+=/rising_sun_kick,cycle_targets=1
actions.opener+=/whirling_dragon_punch
actions.opener+=/spinning_crane_kick,if=buff.serenity.up&cooldown.rising_sun_kick.remains>1&!prev_gcd.spinning_crane_kick
actions.opener+=/rushing_jade_wind,if=(buff.serenity.up|chi>1)&cooldown.rising_sun_kick.remains>1&!prev_gcd.rushing_jade_wind
actions.opener+=/blackout_kick,cycle_targets=1,if=chi>1&cooldown.rising_sun_kick.remains>1&!prev_gcd.blackout_kick
actions.opener+=/chi_wave
actions.opener+=/chi_burst
actions.opener+=/tiger_palm,cycle_targets=1,if=chi.max-chi>1&!prev_gcd.tiger_palm
actions.opener+=/arcane_torrent,if=chi.max-chi>=1
actions.serenity=strike_of_the_windlord
actions.serenity+=/rising_sun_kick,cycle_targets=1
actions.serenity+=/fists_of_fury
actions.serenity+=/spinning_crane_kick,if=cooldown.rising_sun_kick.remains>1&!prev_gcd.spinning_crane_kick
actions.serenity+=/rushing_jade_wind,if=cooldown.rising_sun_kick.remains>1&!prev_gcd.rushing_jade_wind
actions.serenity+=/blackout_kick,cycle_targets=1,if=cooldown.rising_sun_kick.remains>1&!prev_gcd.blackout_kick
actions.st=rushing_jade_wind,if=chi>1&!prev_gcd.rushing_jade_wind
actions.st+=/blackout_kick,cycle_targets=1,if=(chi>1|buff.bok_proc.up)&!prev_gcd.blackout_kick
actions.st+=/chi_wave,if=energy.time_to_max>2
actions.st+=/chi_burst,if=energy.time_to_max>2
actions.st+=/tiger_palm,cycle_targets=1,if=chi.max-chi>1&!prev_gcd.tiger_palm
]]

internal.apls["legion-dev::Tier19H::Monk_Windwalker_T19H"] = [[
actions.precombat=flask,type=flask_of_the_seventh_demon
actions.precombat+=/food,type=fishbrul_special
actions.precombat+=/augmentation,type=defiled
actions.precombat+=/snapshot_stats
actions.precombat+=/potion,name=old_war
actions=auto_attack
actions+=/invoke_xuen
actions+=/call_action_list,name=opener,if=time<15
actions+=/potion,name=old_war,if=buff.serenity.up|buff.storm_earth_and_fire.up|(!talent.serenity.enabled&trinket.proc.agility.react)|buff.bloodlust.react|target.time_to_die<=60
actions+=/serenity,if=cooldown.strike_of_the_windlord.remains<14&cooldown.fists_of_fury.remains<=15&cooldown.rising_sun_kick.remains<7
actions+=/touch_of_death,cycle_targets=1,max_cycle_targets=2,if=!artifact.gale_burst.enabled&equipped.137057&!prev_gcd.touch_of_death
actions+=/touch_of_death,if=!artifact.gale_burst.enabled&!equipped.137057
actions+=/touch_of_death,cycle_targets=1,max_cycle_targets=2,if=artifact.gale_burst.enabled&equipped.137057&cooldown.strike_of_the_windlord.remains<8&cooldown.fists_of_fury.remains<=4&cooldown.rising_sun_kick.remains<7&!prev_gcd.touch_of_death
actions+=/touch_of_death,if=artifact.gale_burst.enabled&!equipped.137057&cooldown.strike_of_the_windlord.remains<8&cooldown.fists_of_fury.remains<=4&cooldown.rising_sun_kick.remains<7
actions+=/blood_fury
actions+=/berserking
actions+=/arcane_torrent,if=chi.max-chi>=1
actions+=/storm_earth_and_fire,if=artifact.strike_of_the_windlord.enabled&cooldown.strike_of_the_windlord.remains<13&cooldown.fists_of_fury.remains<=9&cooldown.rising_sun_kick.remains<=5
actions+=/storm_earth_and_fire,if=!artifact.strike_of_the_windlord.enabled&cooldown.fists_of_fury.remains<=9&cooldown.rising_sun_kick.remains<=5
actions+=/serenity,if=!artifact.strike_of_the_windlord.enabled&cooldown.strike_of_the_windlord.remains<14&cooldown.fists_of_fury.remains<=15&cooldown.rising_sun_kick.remains<7
actions+=/call_action_list,name=serenity,if=buff.serenity.up
actions+=/energizing_elixir,if=energy<energy.max&chi<=1&buff.serenity.down
actions+=/strike_of_the_windlord,if=talent.serenity.enabled|active_enemies<6
actions+=/fists_of_fury
actions+=/rising_sun_kick,cycle_targets=1
actions+=/whirling_dragon_punch
actions+=/call_action_list,name=st,if=active_enemies<3
actions+=/call_action_list,name=aoe,if=active_enemies>=3
actions.aoe=spinning_crane_kick,if=!prev_gcd.spinning_crane_kick
actions.aoe+=/rushing_jade_wind,if=chi>1&!prev_gcd.rushing_jade_wind
actions.aoe+=/blackout_kick,cycle_targets=1,if=(chi>1|buff.bok_proc.up)&!prev_gcd.blackout_kick
actions.aoe+=/chi_wave,if=energy.time_to_max>2
actions.aoe+=/chi_burst,if=energy.time_to_max>2
actions.aoe+=/tiger_palm,cycle_targets=1,if=chi.max-chi>1&!prev_gcd.tiger_palm
actions.opener=blood_fury
actions.opener+=/berserking
actions.opener+=/energizing_elixir
actions.opener+=/touch_of_death,cycle_targets=1,max_cycle_targets=2,if=equipped.137057&!prev_gcd.touch_of_death
actions.opener+=/touch_of_death,if=!equipped.137057
actions.opener+=/serenity
actions.opener+=/storm_earth_and_fire
actions.opener+=/rising_sun_kick,cycle_targets=1,if=buff.serenity.up
actions.opener+=/strike_of_the_windlord,if=talent.serenity.enabled|active_enemies<6
actions.opener+=/fists_of_fury
actions.opener+=/rising_sun_kick,cycle_targets=1
actions.opener+=/whirling_dragon_punch
actions.opener+=/spinning_crane_kick,if=buff.serenity.up&cooldown.rising_sun_kick.remains>1&!prev_gcd.spinning_crane_kick
actions.opener+=/rushing_jade_wind,if=(buff.serenity.up|chi>1)&cooldown.rising_sun_kick.remains>1&!prev_gcd.rushing_jade_wind
actions.opener+=/blackout_kick,cycle_targets=1,if=chi>1&cooldown.rising_sun_kick.remains>1&!prev_gcd.blackout_kick
actions.opener+=/chi_wave
actions.opener+=/chi_burst
actions.opener+=/tiger_palm,cycle_targets=1,if=chi.max-chi>1&!prev_gcd.tiger_palm
actions.opener+=/arcane_torrent,if=chi.max-chi>=1
actions.serenity=strike_of_the_windlord
actions.serenity+=/rising_sun_kick,cycle_targets=1
actions.serenity+=/fists_of_fury
actions.serenity+=/spinning_crane_kick,if=cooldown.rising_sun_kick.remains>1&!prev_gcd.spinning_crane_kick
actions.serenity+=/rushing_jade_wind,if=cooldown.rising_sun_kick.remains>1&!prev_gcd.rushing_jade_wind
actions.serenity+=/blackout_kick,cycle_targets=1,if=cooldown.rising_sun_kick.remains>1&!prev_gcd.blackout_kick
actions.st=rushing_jade_wind,if=chi>1&!prev_gcd.rushing_jade_wind
actions.st+=/blackout_kick,cycle_targets=1,if=(chi>1|buff.bok_proc.up)&!prev_gcd.blackout_kick
actions.st+=/chi_wave,if=energy.time_to_max>2
actions.st+=/chi_burst,if=energy.time_to_max>2
actions.st+=/tiger_palm,cycle_targets=1,if=chi.max-chi>1&!prev_gcd.tiger_palm
]]

