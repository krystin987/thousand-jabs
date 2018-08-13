if GetBuildInfo and select(4,GetBuildInfo()) < 80000 then return end

if select(3, UnitClass('player')) ~= 11 then return end

local TJ = LibStub('AceAddon-3.0'):GetAddon('ThousandJabs')

TJ:RegisterActionProfileList('simc::druid::balance', 'Simulationcraft Druid Profile: Balance', 11, 1, [[
actions.precombat=flask
actions.precombat+=/food
actions.precombat+=/augmentation
actions.precombat+=/moonkin_form
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions.precombat+=/solar_wrath
actions=potion,if=buff.celestial_alignment.up|buff.incarnation.up
actions+=/blood_fury,if=buff.celestial_alignment.up|buff.incarnation.up
actions+=/berserking,if=buff.celestial_alignment.up|buff.incarnation.up
actions+=/arcane_torrent,if=buff.celestial_alignment.up|buff.incarnation.up
actions+=/lights_judgment,if=buff.celestial_alignment.up|buff.incarnation.up
actions+=/fireblood,if=buff.celestial_alignment.up|buff.incarnation.up
actions+=/ancestral_call,if=buff.celestial_alignment.up|buff.incarnation.up
actions+=/use_items
actions+=/warrior_of_elune
actions+=/run_action_list,name=ed,if=equipped.the_emerald_dreamcatcher&active_enemies<=1
actions+=/innervate,if=azerite.lively_spirit.enabled&(cooldown.incarnation.up|cooldown.celestial_alignment.remains<12)&(((raid_event.adds.duration%15)*(4)<(raid_event.adds.in%180))|(raid_event.adds.up))
actions+=/incarnation,if=astral_power>=40&(((raid_event.adds.duration%30)*(4)<(raid_event.adds.in%180))|(raid_event.adds.up))
actions+=/celestial_alignment,if=astral_power>=40&(!azerite.lively_spirit.enabled|buff.lively_spirit.up)&(((raid_event.adds.duration%15)*(4)<(raid_event.adds.in%180))|(raid_event.adds.up))
actions+=/run_action_list,name=aoe,if=spell_targets.starfall>=3
actions+=/run_action_list,name=st
actions.aoe=fury_of_elune,if=(((raid_event.adds.duration%8)*(4)<(raid_event.adds.in%60))|(raid_event.adds.up))&((buff.celestial_alignment.up|buff.incarnation.up)|(cooldown.celestial_alignment.remains>30|cooldown.incarnation.remains>30))
actions.aoe+=/force_of_nature,if=(buff.celestial_alignment.up|buff.incarnation.up)|(cooldown.celestial_alignment.remains>30|cooldown.incarnation.remains>30)
actions.aoe+=/sunfire,target_if=refreshable,if=astral_power.deficit>7&target.time_to_die>4
actions.aoe+=/moonfire,target_if=refreshable,if=astral_power.deficit>7&target.time_to_die>4
actions.aoe+=/stellar_flare,target_if=refreshable,if=target.time_to_die>10
actions.aoe+=/lunar_strike,if=(buff.lunar_empowerment.stack=3|buff.solar_empowerment.stack=2&buff.lunar_empowerment.stack=2&astral_power>=40)&astral_power.deficit>14
actions.aoe+=/solar_wrath,if=buff.solar_empowerment.stack=3&astral_power.deficit>10
actions.aoe+=/starsurge,if=buff.oneths_intuition.react|target.time_to_die<=4
actions.aoe+=/starfall,if=!buff.starlord.up|buff.starlord.remains>=4
actions.aoe+=/new_moon,if=astral_power.deficit>12
actions.aoe+=/half_moon,if=astral_power.deficit>22
actions.aoe+=/full_moon,if=astral_power.deficit>42
actions.aoe+=/solar_wrath,if=(buff.solar_empowerment.up&!buff.warrior_of_elune.up|buff.solar_empowerment.stack>=3)&buff.lunar_empowerment.stack<3
actions.aoe+=/lunar_strike
actions.aoe+=/moonfire
actions.ed=incarnation,if=astral_power>=30
actions.ed+=/celestial_alignment,if=astral_power>=30
actions.ed+=/fury_of_elune,if=(buff.celestial_alignment.up|buff.incarnation.up)|(cooldown.celestial_alignment.remains>30|cooldown.incarnation.remains>30)&(buff.the_emerald_dreamcatcher.remains>gcd.max|!buff.the_emerald_dreamcatcher.up)
actions.ed+=/force_of_nature,if=(buff.celestial_alignment.up|buff.incarnation.up)|(cooldown.celestial_alignment.remains>30|cooldown.incarnation.remains>30)&(buff.the_emerald_dreamcatcher.remains>gcd.max|!buff.the_emerald_dreamcatcher.up)
actions.ed+=/starsurge,if=(gcd.max*astral_power%30)>target.time_to_die
actions.ed+=/moonfire,target_if=refreshable,if=buff.the_emerald_dreamcatcher.remains>gcd.max|!buff.the_emerald_dreamcatcher.up
actions.ed+=/sunfire,target_if=refreshable,if=buff.the_emerald_dreamcatcher.remains>gcd.max|!buff.the_emerald_dreamcatcher.up
actions.ed+=/stellar_flare,target_if=refreshable,if=buff.the_emerald_dreamcatcher.remains>gcd.max|!buff.the_emerald_dreamcatcher.up
actions.ed+=/starfall,if=buff.oneths_overconfidence.up&(buff.the_emerald_dreamcatcher.remains>gcd.max|!buff.the_emerald_dreamcatcher.up)
actions.ed+=/new_moon,if=buff.the_emerald_dreamcatcher.remains>execute_time|!buff.the_emerald_dreamcatcher.up
actions.ed+=/half_moon,if=astral_power.deficit>=20&(buff.the_emerald_dreamcatcher.remains>execute_time|!buff.the_emerald_dreamcatcher.up)
actions.ed+=/full_moon,if=astral_power.deficit>=40&(buff.the_emerald_dreamcatcher.remains>execute_time|!buff.the_emerald_dreamcatcher.up)
actions.ed+=/lunar_strike,,if=buff.lunar_empowerment.up&buff.the_emerald_dreamcatcher.remains>execute_time
actions.ed+=/solar_wrath,if=buff.solar_empowerment.up&buff.the_emerald_dreamcatcher.remains>execute_time
actions.ed+=/starsurge,if=(buff.the_emerald_dreamcatcher.up&buff.the_emerald_dreamcatcher.remains<gcd.max)|astral_power>=50
actions.ed+=/solar_wrath
actions.st=fury_of_elune,if=(((raid_event.adds.duration%8)*(4)<(raid_event.adds.in%60))|(raid_event.adds.up))&((buff.celestial_alignment.up|buff.incarnation.up)|(cooldown.celestial_alignment.remains>30|cooldown.incarnation.remains>30))
actions.st+=/force_of_nature,if=(buff.celestial_alignment.up|buff.incarnation.up)|(cooldown.celestial_alignment.remains>30|cooldown.incarnation.remains>30)
actions.st+=/moonfire,target_if=refreshable,if=target.time_to_die>8
actions.st+=/sunfire,target_if=refreshable,if=target.time_to_die>8
actions.st+=/stellar_flare,target_if=refreshable,if=target.time_to_die>10
actions.st+=/solar_wrath,if=(buff.solar_empowerment.stack=3|buff.solar_empowerment.stack=2&buff.lunar_empowerment.stack=2&astral_power>=40)&astral_power.deficit>10
actions.st+=/lunar_strike,if=buff.lunar_empowerment.stack=3&astral_power.deficit>14
actions.st+=/starfall,if=buff.oneths_overconfidence.react
actions.st+=/starsurge,if=!buff.starlord.up|buff.starlord.remains>=4|(gcd.max*(astral_power%40))>target.time_to_die
actions.st+=/lunar_strike,if=(buff.warrior_of_elune.up|!buff.solar_empowerment.up)&buff.lunar_empowerment.up
actions.st+=/new_moon,if=astral_power.deficit>10
actions.st+=/half_moon,if=astral_power.deficit>20
actions.st+=/full_moon,if=astral_power.deficit>40
actions.st+=/solar_wrath
actions.st+=/moonfire
]])

TJ:RegisterActionProfileList('simc::druid::feral', 'Simulationcraft Druid Profile: Feral', 11, 2, [[
actions.precombat=flask
actions.precombat+=/food
actions.precombat+=/augmentation
actions.precombat+=/regrowth,if=talent.bloodtalons.enabled
actions.precombat+=/variable,name=use_thrash,value=0
actions.precombat+=/variable,name=use_thrash,value=1,if=equipped.luffa_wrappings
actions.precombat+=/cat_form
actions.precombat+=/prowl
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions=run_action_list,name=single_target,if=dot.rip.ticking|time>15
actions+=/rake,if=!ticking|buff.prowl.up
actions+=/dash,if=!buff.cat_form.up
actions+=/auto_attack
actions+=/moonfire_cat,if=talent.lunar_inspiration.enabled&!ticking
actions+=/savage_roar,if=!buff.savage_roar.up
actions+=/berserk
actions+=/incarnation
actions+=/tigers_fury
actions+=/regrowth,if=(talent.sabertooth.enabled|buff.predatory_swiftness.up)&talent.bloodtalons.enabled&buff.bloodtalons.down&combo_points=5
actions+=/rip,if=combo_points=5
actions+=/thrash_cat,if=!ticking&variable.use_thrash>0
actions+=/shred
actions.cooldowns=dash,if=!buff.cat_form.up
actions.cooldowns+=/prowl,if=buff.incarnation.remains<0.5&buff.jungle_stalker.up
actions.cooldowns+=/berserk,if=energy>=30&(cooldown.tigers_fury.remains>5|buff.tigers_fury.up)
actions.cooldowns+=/tigers_fury,if=energy.deficit>=60
actions.cooldowns+=/berserking
actions.cooldowns+=/feral_frenzy,if=combo_points=0
actions.cooldowns+=/incarnation,if=energy>=30&(cooldown.tigers_fury.remains>15|buff.tigers_fury.up)
actions.cooldowns+=/potion,name=prolonged_power,if=target.time_to_die<65|(time_to_die<180&(buff.berserk.up|buff.incarnation.up))
actions.cooldowns+=/shadowmeld,if=combo_points<5&energy>=action.rake.cost&dot.rake.pmultiplier<2.1&buff.tigers_fury.up&(buff.bloodtalons.up|!talent.bloodtalons.enabled)&(!talent.incarnation.enabled|cooldown.incarnation.remains>18)&!buff.incarnation.up
actions.cooldowns+=/use_items
actions.single_target=cat_form,if=!buff.cat_form.up
actions.single_target+=/rake,if=buff.prowl.up|buff.shadowmeld.up
actions.single_target+=/auto_attack
actions.single_target+=/call_action_list,name=cooldowns
actions.single_target+=/ferocious_bite,target_if=dot.rip.ticking&dot.rip.remains<3&target.time_to_die>10&(target.health.pct<25|talent.sabertooth.enabled)
actions.single_target+=/regrowth,if=combo_points=5&buff.predatory_swiftness.up&talent.bloodtalons.enabled&buff.bloodtalons.down&(!buff.incarnation.up|dot.rip.remains<8)
actions.single_target+=/regrowth,if=combo_points>3&talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.apex_predator.up&buff.incarnation.down
actions.single_target+=/ferocious_bite,if=buff.apex_predator.up&((combo_points>4&(buff.incarnation.up|talent.moment_of_clarity.enabled))|(talent.bloodtalons.enabled&buff.bloodtalons.up&combo_points>3))
actions.single_target+=/run_action_list,name=st_finishers,if=combo_points>4
actions.single_target+=/run_action_list,name=st_generators
actions.st_finishers=pool_resource,for_next=1
actions.st_finishers+=/savage_roar,if=buff.savage_roar.down
actions.st_finishers+=/pool_resource,for_next=1
actions.st_finishers+=/rip,target_if=!ticking|(remains<=duration*0.3)&(target.health.pct>25&!talent.sabertooth.enabled)|(remains<=duration*0.8&persistent_multiplier>dot.rip.pmultiplier)&target.time_to_die>8
actions.st_finishers+=/pool_resource,for_next=1
actions.st_finishers+=/savage_roar,if=buff.savage_roar.remains<12
actions.st_finishers+=/ferocious_bite,max_energy=1
actions.st_generators=regrowth,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.bloodtalons.down&combo_points=4&dot.rake.remains<4
actions.st_generators+=/regrowth,if=equipped.ailuro_pouncers&talent.bloodtalons.enabled&(buff.predatory_swiftness.stack>2|(buff.predatory_swiftness.stack>1&dot.rake.remains<3))&buff.bloodtalons.down
actions.st_generators+=/brutal_slash,if=spell_targets.brutal_slash>desired_targets
actions.st_generators+=/pool_resource,for_next=1
actions.st_generators+=/thrash_cat,if=refreshable&(spell_targets.thrash_cat>2)
actions.st_generators+=/pool_resource,for_next=1
actions.st_generators+=/thrash_cat,if=spell_targets.thrash_cat>3&equipped.luffa_wrappings&talent.brutal_slash.enabled
actions.st_generators+=/pool_resource,for_next=1
actions.st_generators+=/rake,target_if=!ticking|(!talent.bloodtalons.enabled&remains<duration*0.3)&target.time_to_die>4
actions.st_generators+=/pool_resource,for_next=1
actions.st_generators+=/rake,target_if=talent.bloodtalons.enabled&buff.bloodtalons.up&((remains<=7)&persistent_multiplier>dot.rake.pmultiplier*0.85)&target.time_to_die>4
actions.st_generators+=/brutal_slash,if=(buff.tigers_fury.up&(raid_event.adds.in>(1+max_charges-charges_fractional)*recharge_time))
actions.st_generators+=/moonfire_cat,target_if=refreshable
actions.st_generators+=/pool_resource,for_next=1
actions.st_generators+=/thrash_cat,if=refreshable&(variable.use_thrash=2|spell_targets.thrash_cat>1)
actions.st_generators+=/thrash_cat,if=refreshable&variable.use_thrash=1&buff.clearcasting.react
actions.st_generators+=/pool_resource,for_next=1
actions.st_generators+=/swipe_cat,if=spell_targets.swipe_cat>1
actions.st_generators+=/shred,if=dot.rake.remains>(action.shred.cost+action.rake.cost-energy)%energy.regen|buff.clearcasting.react
]])

TJ:RegisterActionProfileList('simc::druid::guardian', 'Simulationcraft Druid Profile: Guardian', 11, 3, [[
actions.precombat=flask
actions.precombat+=/food
actions.precombat+=/augmentation
actions.precombat+=/bear_form
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions=auto_attack
actions+=/call_action_list,name=cooldowns
actions+=/maul,if=rage.deficit<10&active_enemies<4
actions+=/pulverize,target_if=dot.thrash_bear.stack=dot.thrash_bear.max_stacks
actions+=/moonfire,target_if=dot.moonfire.refreshable&active_enemies<2
actions+=/incarnation
actions+=/thrash,if=(buff.incarnation.down&active_enemies>1)|(buff.incarnation.up&active_enemies>4)
actions+=/swipe,if=buff.incarnation.down&active_enemies>4
actions+=/mangle,if=dot.thrash_bear.ticking
actions+=/moonfire,target_if=buff.galactic_guardian.up&active_enemies<2
actions+=/thrash
actions+=/maul
actions+=/swipe
actions.cooldowns=potion
actions.cooldowns+=/blood_fury
actions.cooldowns+=/berserking
actions.cooldowns+=/arcane_torrent
actions.cooldowns+=/lights_judgment
actions.cooldowns+=/fireblood
actions.cooldowns+=/ancestral_call
actions.cooldowns+=/barkskin,if=buff.bear_form.up
actions.cooldowns+=/lunar_beam,if=buff.bear_form.up
actions.cooldowns+=/bristling_fur,if=buff.bear_form.up
actions.cooldowns+=/use_items
]])

