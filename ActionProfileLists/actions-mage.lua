local _, internal = ...
internal.apls = internal.apls or {}

internal.apls["legion-dev::mage::arcane"] = [[
actions.precombat=flask,type=flask_of_the_whispered_pact
actions.precombat+=/food,type=the_hungry_magister
actions.precombat+=/augmentation,type=defiled
actions.precombat+=/summon_arcane_familiar
actions.precombat+=/snapshot_stats
actions.precombat+=/mirror_image
actions.precombat+=/potion,name=deadly_grace
actions.precombat+=/arcane_blast
actions=counterspell,if=target.debuff.casting.react
actions+=/time_warp,if=(time=0&buff.bloodlust.down)|(buff.bloodlust.down&equipped.132410)
actions+=/mirror_image,if=buff.arcane_power.down
actions+=/stop_burn_phase,if=prev_gcd.evocation&burn_phase_duration>gcd.max
actions+=/mark_of_aluneth,if=cooldown.arcane_power.remains>20
actions+=/call_action_list,name=build,if=buff.arcane_charge.stack<4
actions+=/call_action_list,name=init_burn,if=buff.arcane_power.down&buff.arcane_charge.stack=4&(cooldown.mark_of_aluneth.remains=0|cooldown.mark_of_aluneth.remains>20)&(!talent.rune_of_power.enabled|(cooldown.arcane_power.remains<=action.rune_of_power.cast_time|action.rune_of_power.recharge_time<cooldown.arcane_power.remains))|target.time_to_die<45
actions+=/call_action_list,name=burn,if=burn_phase
actions+=/call_action_list,name=rop_phase,if=buff.rune_of_power.up&!burn_phase
actions+=/call_action_list,name=conserve
actions.build=charged_up,if=buff.arcane_charge.stack<=1
actions.build+=/arcane_missiles,if=buff.arcane_missiles.react=3
actions.build+=/arcane_orb
actions.build+=/arcane_explosion,if=active_enemies>1
actions.build+=/arcane_blast
actions.burn=call_action_list,name=cooldowns
actions.burn+=/arcane_missiles,if=buff.arcane_missiles.react=3
actions.burn+=/arcane_explosion,if=buff.quickening.remains<action.arcane_blast.cast_time&talent.quickening.enabled
actions.burn+=/presence_of_mind,if=buff.arcane_power.remains>2*gcd
actions.burn+=/nether_tempest,if=dot.nether_tempest.remains<=2|!ticking
actions.burn+=/arcane_blast,if=active_enemies<=1&mana.pct%10*execute_time>target.time_to_die
actions.burn+=/arcane_explosion,if=active_enemies>1&mana.pct%10*execute_time>target.time_to_die
actions.burn+=/arcane_missiles,if=buff.arcane_missiles.react>1
actions.burn+=/arcane_explosion,if=active_enemies>1&buff.arcane_power.remains>cast_time
actions.burn+=/arcane_blast,if=buff.presence_of_mind.up|buff.arcane_power.remains>cast_time
actions.burn+=/supernova,if=mana.pct<100
actions.burn+=/arcane_missiles,if=mana.pct>10&(talent.overpowered.enabled|buff.arcane_power.down)
actions.burn+=/arcane_explosion,if=active_enemies>1
actions.burn+=/arcane_blast
actions.burn+=/evocation,interrupt_if=mana.pct>99
actions.conserve=arcane_missiles,if=buff.arcane_missiles.react=3
actions.conserve+=/arcane_explosion,if=buff.quickening.remains<action.arcane_blast.cast_time&talent.quickening.enabled
actions.conserve+=/arcane_blast,if=mana.pct>99
actions.conserve+=/nether_tempest,if=(refreshable|!ticking)
actions.conserve+=/arcane_blast,if=buff.rhonins_assaulting_armwraps.up&equipped.132413
actions.conserve+=/arcane_missiles
actions.conserve+=/supernova,if=mana.pct<100
actions.conserve+=/frost_nova,if=equipped.132452
actions.conserve+=/arcane_explosion,if=mana.pct>=82&equipped.132451&active_enemies>1
actions.conserve+=/arcane_blast,if=mana.pct>=82&equipped.132451
actions.conserve+=/arcane_barrage,if=mana.pct<100&cooldown.arcane_power.remains>5
actions.conserve+=/arcane_explosion,if=active_enemies>1
actions.conserve+=/arcane_blast
actions.cooldowns=rune_of_power,if=mana.pct>45&buff.arcane_power.down
actions.cooldowns+=/arcane_power
actions.cooldowns+=/blood_fury
actions.cooldowns+=/berserking
actions.cooldowns+=/arcane_torrent
actions.cooldowns+=/potion,name=deadly_grace,if=buff.arcane_power.up&(buff.berserking.up|buff.blood_fury.up)
actions.init_burn=mark_of_aluneth
actions.init_burn+=/frost_nova,if=equipped.132452
actions.init_burn+=/nether_tempest,if=dot.nether_tempest.remains<10&(prev_gcd.mark_of_aluneth|(talent.rune_of_power.enabled&cooldown.rune_of_power.remains<gcd.max))
actions.init_burn+=/rune_of_power
actions.init_burn+=/start_burn_phase,if=((cooldown.evocation.remains-(2*burn_phase_duration))%2<burn_phase_duration)|cooldown.arcane_power.remains=0|target.time_to_die<55
actions.rop_phase=arcane_missiles,if=buff.arcane_missiles.react=3
actions.rop_phase+=/arcane_explosion,if=buff.quickening.remains<action.arcane_blast.cast_time&talent.quickening.enabled
actions.rop_phase+=/nether_tempest,if=dot.nether_tempest.remains<=2|!ticking
actions.rop_phase+=/arcane_missiles,if=buff.arcane_charge.stack=4
actions.rop_phase+=/arcane_explosion,if=active_enemies>1
actions.rop_phase+=/arcane_blast,if=mana.pct>45
actions.rop_phase+=/arcane_barrage
]]

internal.apls["legion-dev::mage::fire"] = [[
actions.precombat=flask,type=flask_of_the_whispered_pact
actions.precombat+=/food,type=the_hungry_magister
actions.precombat+=/augmentation,type=defiled
actions.precombat+=/snapshot_stats
actions.precombat+=/mirror_image
actions.precombat+=/potion,name=deadly_grace
actions.precombat+=/pyroblast
actions=counterspell,if=target.debuff.casting.react
actions+=/time_warp,if=(time=0&buff.bloodlust.down)|(buff.bloodlust.down&equipped.132410)
actions+=/mirror_image,if=buff.combustion.down
actions+=/rune_of_power,if=cooldown.combustion.remains>40&buff.combustion.down&(cooldown.flame_on.remains<5|cooldown.flame_on.remains>30)&!talent.kindling.enabled|target.time_to_die.remains<11|talent.kindling.enabled&(charges_fractional>1.8|time<40)&cooldown.combustion.remains>40
actions+=/call_action_list,name=combustion_phase,if=cooldown.combustion.remains<=action.rune_of_power.cast_time+(!talent.kindling.enabled*gcd)|buff.combustion.up
actions+=/call_action_list,name=rop_phase,if=buff.rune_of_power.up&buff.combustion.down
actions+=/call_action_list,name=single_target
actions.active_talents=flame_on,if=action.fire_blast.charges=0&(cooldown.combustion.remains>40+(talent.kindling.enabled*25)|target.time_to_die.remains<cooldown.combustion.remains)
actions.active_talents+=/blast_wave,if=(buff.combustion.down)|(buff.combustion.up&action.fire_blast.charges<1&action.phoenixs_flames.charges<1)
actions.active_talents+=/meteor,if=cooldown.combustion.remains>30|(cooldown.combustion.remains>target.time_to_die)|buff.rune_of_power.up
actions.active_talents+=/cinderstorm,if=cooldown.combustion.remains<cast_time&(buff.rune_of_power.up|!talent.rune_on_power.enabled)|cooldown.combustion.remains>10*spell_haste&!buff.combustion.up
actions.active_talents+=/dragons_breath,if=equipped.132863
actions.active_talents+=/living_bomb,if=active_enemies>1&buff.combustion.down
actions.combustion_phase=rune_of_power,if=buff.combustion.down
actions.combustion_phase+=/call_action_list,name=active_talents
actions.combustion_phase+=/combustion
actions.combustion_phase+=/potion,name=deadly_grace
actions.combustion_phase+=/blood_fury
actions.combustion_phase+=/berserking
actions.combustion_phase+=/arcane_torrent
actions.combustion_phase+=/pyroblast,if=buff.hot_streak.up
actions.combustion_phase+=/fire_blast,if=buff.heating_up.up
actions.combustion_phase+=/phoenixs_flames
actions.combustion_phase+=/scorch,if=buff.combustion.remains>cast_time
actions.combustion_phase+=/scorch,if=target.health.pct<=25&equipped.132454
actions.rop_phase=rune_of_power
actions.rop_phase+=/pyroblast,if=buff.hot_streak.up
actions.rop_phase+=/call_action_list,name=active_talents
actions.rop_phase+=/pyroblast,if=buff.kaelthas_ultimate_ability.react
actions.rop_phase+=/fire_blast,if=!prev_off_gcd.fire_blast
actions.rop_phase+=/phoenixs_flames,if=!prev_gcd.phoenixs_flames
actions.rop_phase+=/scorch,if=target.health.pct<=25&equipped.132454
actions.rop_phase+=/fireball
actions.single_target=pyroblast,if=buff.hot_streak.up&buff.hot_streak.remains<action.fireball.execute_time
actions.single_target+=/phoenixs_flames,if=charges_fractional>2.7&active_enemies>2
actions.single_target+=/flamestrike,if=talent.flame_patch.enabled&active_enemies>2&buff.hot_streak.react
actions.single_target+=/pyroblast,if=buff.hot_streak.up&!prev_gcd.pyroblast
actions.single_target+=/pyroblast,if=buff.hot_streak.react&target.health.pct<=25&equipped.132454
actions.single_target+=/pyroblast,if=buff.kaelthas_ultimate_ability.react
actions.single_target+=/call_action_list,name=active_talents
actions.single_target+=/fire_blast,if=!talent.kindling.enabled&buff.heating_up.up&(!talent.rune_of_power.enabled|charges_fractional>1.4|cooldown.combustion.remains<40)&(3-charges_fractional)*(12*spell_haste)<cooldown.combustion.remains+3|target.time_to_die.remains<4
actions.single_target+=/fire_blast,if=talent.kindling.enabled&buff.heating_up.up&(!talent.rune_of_power.enabled|charges_fractional>1.5|cooldown.combustion.remains<40)&(3-charges_fractional)*(18*spell_haste)<cooldown.combustion.remains+3|target.time_to_die.remains<4
actions.single_target+=/phoenixs_flames,if=(buff.combustion.up|buff.rune_of_power.up|buff.incanters_flow.stack>3|talent.mirror_image.enabled)&artifact.phoenix_reborn.enabled&(4-charges_fractional)*13<cooldown.combustion.remains+5|target.time_to_die.remains<10
actions.single_target+=/phoenixs_flames,if=(buff.combustion.up|buff.rune_of_power.up)&(4-charges_fractional)*30<cooldown.combustion.remains+5
actions.single_target+=/scorch,if=target.health.pct<=25&equipped.132454
actions.single_target+=/fireball
]]

internal.apls["legion-dev::mage::frost"] = [[
actions.precombat=flask,type=flask_of_the_whispered_pact
actions.precombat+=/food,type=azshari_salad
actions.precombat+=/augmentation,type=defiled
actions.precombat+=/water_elemental
actions.precombat+=/snapshot_stats
actions.precombat+=/mirror_image
actions.precombat+=/potion,name=deadly_grace
actions.precombat+=/frostbolt
actions=counterspell,if=target.debuff.casting.react
actions+=/ice_lance,if=buff.fingers_of_frost.react=0&prev_gcd.flurry
actions+=/time_warp,if=(time=0&buff.bloodlust.down)|(buff.bloodlust.down&equipped.132410)
actions+=/call_action_list,name=cooldowns
actions+=/ice_nova,if=debuff.winters_chill.up
actions+=/frostbolt,if=prev_off_gcd.water_jet
actions+=/water_jet,if=prev_gcd.frostbolt&buff.fingers_of_frost.stack<(2+artifact.icy_hand.enabled)&buff.brain_freeze.react=0
actions+=/ray_of_frost,if=buff.icy_veins.up|(cooldown.icy_veins.remains>action.ray_of_frost.cooldown&buff.rune_of_power.down)
actions+=/flurry,if=buff.brain_freeze.react&buff.fingers_of_frost.react=0&prev_gcd.frostbolt
actions+=/frozen_touch,if=buff.fingers_of_frost.stack<=(0+artifact.icy_hand.enabled)&((cooldown.icy_veins.remains>30&talent.thermal_void.enabled)|!talent.thermal_void.enabled)
actions+=/frost_bomb,if=debuff.frost_bomb.remains<action.ice_lance.travel_time&buff.fingers_of_frost.react>0
actions+=/ice_lance,if=buff.fingers_of_frost.react>0&cooldown.icy_veins.remains>10|buff.fingers_of_frost.react>2
actions+=/frozen_orb
actions+=/ice_nova
actions+=/comet_storm
actions+=/blizzard,if=talent.arctic_gale.enabled|active_enemies>1|((buff.zannesu_journey.stack>4|buff.zannesu_journey.remains<cast_time+1)&equipped.133970)
actions+=/ebonbolt,if=buff.fingers_of_frost.stack<=(0+artifact.icy_hand.enabled)
actions+=/glacial_spike
actions+=/frostbolt
actions.cooldowns=rune_of_power,if=cooldown.icy_veins.remains<cast_time|charges_fractional>1.9&cooldown.icy_veins.remains>10|buff.icy_veins.up|target.time_to_die.remains+5<charges_fractional*10
actions.cooldowns+=/icy_veins,if=buff.icy_veins.down
actions.cooldowns+=/mirror_image
actions.cooldowns+=/blood_fury
actions.cooldowns+=/berserking
actions.cooldowns+=/arcane_torrent
actions.cooldowns+=/potion,name=potion_of_prolonged_power,if=cooldown.icy_veins.remains<1
]]

