--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Legion only.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if select(4, GetBuildInfo()) >= 80000 then
    return
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if select(3, UnitClass('player')) ~= 11 then return end

local TJ = LibStub('AceAddon-3.0'):GetAddon('ThousandJabs')

TJ:RegisterActionProfileList('simc::druid::balance', 'Simulationcraft Druid Profile: Balance', 11, 1, [[
actions.precombat=flask
actions.precombat+=/food
actions.precombat+=/augmentation
actions.precombat+=/moonkin_form
actions.precombat+=/variable,name=starfall_st,value=talent.soul_of_the_forest.enabled
actions.precombat+=/variable,name=flare_st,value=talent.stellar_flare.enabled
actions.precombat+=/blessing_of_elune,if=!variable.starfall_st
actions.precombat+=/blessing_of_anshe,if=variable.starfall_st
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions.precombat+=/new_moon
actions=potion,name=potion_of_prolonged_power,if=buff.celestial_alignment.up|buff.incarnation.up
actions+=/blessing_of_elune,if=active_enemies<=2&(!variable.starfall_st|(variable.starfall_st&buff.celestial_alignment.up))
actions+=/blessing_of_anshe,if=active_enemies>=3|variable.starfall_st&!buff.celestial_alignment.up&cooldown.celestial_alignment.remains>15
actions+=/blood_fury,if=buff.celestial_alignment.up|buff.incarnation.up
actions+=/berserking,if=buff.celestial_alignment.up|buff.incarnation.up
actions+=/arcane_torrent,if=buff.celestial_alignment.up|buff.incarnation.up
actions+=/lights_judgment,if=buff.celestial_alignment.up|buff.incarnation.up
actions+=/use_items
actions+=/call_action_list,name=fury_of_elune,if=talent.fury_of_elune.enabled&cooldown.fury_of_elune.remains<target.time_to_die
actions+=/call_action_list,name=ed,if=equipped.the_emerald_dreamcatcher&active_enemies<=1
actions+=/astral_communion,if=astral_power.deficit>=79
actions+=/warrior_of_elune
actions+=/incarnation,if=astral_power>=40
actions+=/celestial_alignment,if=astral_power>=40&(!variable.starfall_st|time>=7*gcd.max)
actions+=/call_action_list,name=aoe,if=(spell_targets.starfall>=2&talent.stellar_drift.enabled)|spell_targets.starfall>=3
actions+=/call_action_list,name=st
actions.aoe=starfall,if=buff.starfall.remains<gcd.max*2|astral_power.deficit<22.5|(buff.celestial_alignment.remains>8|buff.incarnation.remains>8)|target.time_to_die<8
actions.aoe+=/stellar_flare,target_if=refreshable,if=target.time_to_die>10
actions.aoe+=/sunfire,target_if=refreshable,if=astral_power.deficit>7&target.time_to_die>4
actions.aoe+=/moonfire,target_if=refreshable,if=astral_power.deficit>7&target.time_to_die>4
actions.aoe+=/force_of_nature
actions.aoe+=/starsurge,if=buff.oneths_intuition.react&(!buff.astral_acceleration.up|buff.astral_acceleration.remains>5|astral_power.deficit<44)
actions.aoe+=/new_moon,if=astral_power.deficit>14&(!(buff.celestial_alignment.up|buff.incarnation.up)|(charges=2&recharge_time<5)|charges=3)
actions.aoe+=/half_moon,if=astral_power.deficit>24
actions.aoe+=/full_moon,if=astral_power.deficit>44
actions.aoe+=/lunar_strike,if=buff.warrior_of_elune.up
actions.aoe+=/solar_wrath,if=buff.solar_empowerment.up
actions.aoe+=/lunar_strike,if=buff.lunar_empowerment.up
actions.aoe+=/lunar_strike,if=spell_targets.lunar_strike>=4|spell_haste<0.45
actions.aoe+=/solar_wrath
actions.ed=astral_communion,if=astral_power.deficit>=75&buff.the_emerald_dreamcatcher.up
actions.ed+=/incarnation,if=astral_power>=60|buff.bloodlust.up
actions.ed+=/celestial_alignment,if=astral_power>=60&!buff.the_emerald_dreamcatcher.up
actions.ed+=/starsurge,if=(gcd.max*astral_power%26)>target.time_to_die
actions.ed+=/stellar_flare,cycle_targets=1,max_cycle_targets=4,if=active_enemies<4&remains<7.2
actions.ed+=/moonfire,if=((talent.natures_balance.enabled&remains<3)|(remains<6.6&!talent.natures_balance.enabled))&(buff.the_emerald_dreamcatcher.remains>gcd.max|!buff.the_emerald_dreamcatcher.up)
actions.ed+=/sunfire,if=((talent.natures_balance.enabled&remains<3)|(remains<5.4&!talent.natures_balance.enabled))&(buff.the_emerald_dreamcatcher.remains>gcd.max|!buff.the_emerald_dreamcatcher.up)
actions.ed+=/force_of_nature,if=buff.the_emerald_dreamcatcher.remains>execute_time
actions.ed+=/starfall,if=buff.oneths_overconfidence.react&buff.the_emerald_dreamcatcher.remains>execute_time
actions.ed+=/new_moon,if=astral_power.deficit>=10&buff.the_emerald_dreamcatcher.remains>execute_time&astral_power>=16
actions.ed+=/half_moon,if=astral_power.deficit>=20&buff.the_emerald_dreamcatcher.remains>execute_time&astral_power>=6
actions.ed+=/full_moon,if=astral_power.deficit>=40&buff.the_emerald_dreamcatcher.remains>execute_time
actions.ed+=/lunar_strike,if=(buff.lunar_empowerment.up&buff.the_emerald_dreamcatcher.remains>execute_time&(!(buff.celestial_alignment.up|buff.incarnation.up)&astral_power.deficit>=15|(buff.celestial_alignment.up|buff.incarnation.up)&astral_power.deficit>=22.5))&spell_haste<0.4
actions.ed+=/solar_wrath,if=buff.solar_empowerment.stack>1&buff.the_emerald_dreamcatcher.remains>2*execute_time&astral_power>=6&(dot.moonfire.remains>5|(dot.sunfire.remains<5.4&dot.moonfire.remains>6.6))&(!(buff.celestial_alignment.up|buff.incarnation.up)&astral_power.deficit>=10|(buff.celestial_alignment.up|buff.incarnation.up)&astral_power.deficit>=15)
actions.ed+=/lunar_strike,if=buff.lunar_empowerment.up&buff.the_emerald_dreamcatcher.remains>execute_time&astral_power>=11&(!(buff.celestial_alignment.up|buff.incarnation.up)&astral_power.deficit>=15|(buff.celestial_alignment.up|buff.incarnation.up)&astral_power.deficit>=22.5)
actions.ed+=/solar_wrath,if=buff.solar_empowerment.up&buff.the_emerald_dreamcatcher.remains>execute_time&astral_power>=16&(!(buff.celestial_alignment.up|buff.incarnation.up)&astral_power.deficit>=10|(buff.celestial_alignment.up|buff.incarnation.up)&astral_power.deficit>=15)
actions.ed+=/starsurge,if=(buff.the_emerald_dreamcatcher.up&buff.the_emerald_dreamcatcher.remains<gcd.max)|astral_power>85|((buff.celestial_alignment.up|buff.incarnation.up)&astral_power>30)
actions.ed+=/starfall,if=buff.oneths_overconfidence.up
actions.ed+=/new_moon,if=astral_power.deficit>=10
actions.ed+=/half_moon,if=astral_power.deficit>=20
actions.ed+=/full_moon,if=astral_power.deficit>=40
actions.ed+=/solar_wrath,if=buff.solar_empowerment.up
actions.ed+=/lunar_strike,if=buff.lunar_empowerment.up
actions.ed+=/solar_wrath
actions.fury_of_elune=incarnation,if=astral_power>=95&cooldown.fury_of_elune.remains<=gcd
actions.fury_of_elune+=/force_of_nature,if=!buff.fury_of_elune.up
actions.fury_of_elune+=/fury_of_elune,if=astral_power>=95
actions.fury_of_elune+=/new_moon,if=((charges=2&recharge_time<5)|charges=3)&&(buff.fury_of_elune.up|(cooldown.fury_of_elune.remains>gcd*3&astral_power<=90))
actions.fury_of_elune+=/half_moon,if=((charges=2&recharge_time<5)|charges=3)&&(buff.fury_of_elune.up|(cooldown.fury_of_elune.remains>gcd*3&astral_power<=80))
actions.fury_of_elune+=/full_moon,if=((charges=2&recharge_time<5)|charges=3)&&(buff.fury_of_elune.up|(cooldown.fury_of_elune.remains>gcd*3&astral_power<=60))
actions.fury_of_elune+=/astral_communion,if=buff.fury_of_elune.up&astral_power<=25
actions.fury_of_elune+=/warrior_of_elune,if=buff.fury_of_elune.up|(cooldown.fury_of_elune.remains>=35&buff.lunar_empowerment.up)
actions.fury_of_elune+=/lunar_strike,if=buff.warrior_of_elune.up&(astral_power<=90|(astral_power<=85&buff.incarnation.up))
actions.fury_of_elune+=/new_moon,if=astral_power<=90&buff.fury_of_elune.up
actions.fury_of_elune+=/half_moon,if=astral_power<=80&buff.fury_of_elune.up&astral_power>cast_time*12
actions.fury_of_elune+=/full_moon,if=astral_power<=60&buff.fury_of_elune.up&astral_power>cast_time*12
actions.fury_of_elune+=/moonfire,if=buff.fury_of_elune.down&remains<=6.6
actions.fury_of_elune+=/sunfire,if=buff.fury_of_elune.down&remains<5.4
actions.fury_of_elune+=/stellar_flare,if=remains<7.2&active_enemies=1
actions.fury_of_elune+=/starfall,if=(active_enemies>=2&talent.stellar_flare.enabled|active_enemies>=3)&buff.fury_of_elune.down&cooldown.fury_of_elune.remains>10
actions.fury_of_elune+=/starsurge,if=active_enemies<=2&buff.fury_of_elune.down&cooldown.fury_of_elune.remains>7
actions.fury_of_elune+=/starsurge,if=buff.fury_of_elune.down&((astral_power>=92&cooldown.fury_of_elune.remains>gcd*3)|(cooldown.warrior_of_elune.remains<=5&cooldown.fury_of_elune.remains>=35&buff.lunar_empowerment.stack<2))
actions.fury_of_elune+=/solar_wrath,if=buff.solar_empowerment.up
actions.fury_of_elune+=/lunar_strike,if=buff.lunar_empowerment.stack=3|(buff.lunar_empowerment.remains<5&buff.lunar_empowerment.up)|active_enemies>=2
actions.fury_of_elune+=/solar_wrath
actions.st=starfall,if=(buff.oneths_overconfidence.react&((!variable.flare_st&(astral_power.deficit<40|(set_bonus.tier21_4pc&!buff.solar_solstice.up)|(!variable.starfall_st&!buff.solar_empowerment.up&!buff.lunar_empowerment.up&cooldown.moon_cd.charges=0)))|astral_power.deficit<35|buff.astral_acceleration.remains>5|(buff.celestial_alignment.up|buff.incarnation.up)))|(variable.starfall_st&!buff.starfall.up)
actions.st+=/force_of_nature
actions.st+=/stellar_flare,target_if=refreshable,if=target.time_to_die>10
actions.st+=/moonfire,target_if=refreshable,if=((talent.natures_balance.enabled&remains<3)|remains<6.6)&astral_power.deficit>7&target.time_to_die>8
actions.st+=/sunfire,target_if=refreshable,if=((talent.natures_balance.enabled&remains<3)|remains<5.4)&astral_power.deficit>7&target.time_to_die>8
actions.st+=/solar_wrath,if=buff.solar_empowerment.stack=3&astral_power.deficit>10
actions.st+=/lunar_strike,if=buff.lunar_empowerment.stack=3&astral_power.deficit>15
actions.st+=/starsurge,if=buff.oneths_intuition.react|((!variable.flare_st&(astral_power.deficit<40|(set_bonus.tier21_4pc&!buff.solar_solstice.up)|(!variable.starfall_st&!buff.solar_empowerment.up&!buff.lunar_empowerment.up&cooldown.moon_cd.charges=0)))|astral_power.deficit<35|buff.astral_acceleration.remains>5|(buff.celestial_alignment.up|buff.incarnation.up))|(gcd.max*(astral_power%40))>target.time_to_die
actions.st+=/new_moon,if=astral_power.deficit>10&(!(buff.celestial_alignment.up|buff.incarnation.up)|(charges=2&recharge_time<5)|charges=3)
actions.st+=/half_moon,if=astral_power.deficit>20&(!(buff.celestial_alignment.up|buff.incarnation.up)|(charges=2&recharge_time<5)|charges=3)
actions.st+=/full_moon,if=astral_power.deficit>40&(!(buff.celestial_alignment.up|buff.incarnation.up)|(charges=2&recharge_time<5)|charges=3)
actions.st+=/lunar_strike,if=buff.warrior_of_elune.up&buff.lunar_empowerment.up
actions.st+=/solar_wrath,if=buff.solar_empowerment.up
actions.st+=/lunar_strike,if=buff.lunar_empowerment.up
actions.st+=/solar_wrath
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
actions+=/ashamanes_frenzy
actions+=/regrowth,if=(talent.sabertooth.enabled|buff.predatory_swiftness.up)&talent.bloodtalons.enabled&buff.bloodtalons.down&combo_points=5
actions+=/rip,if=combo_points=5
actions+=/thrash_cat,if=!ticking&variable.use_thrash>0
actions+=/shred
actions.cooldowns=dash,if=!buff.cat_form.up
actions.cooldowns+=/prowl,if=buff.incarnation.remains<0.5&buff.jungle_stalker.up
actions.cooldowns+=/berserk,if=energy>=30&(cooldown.tigers_fury.remains>5|buff.tigers_fury.up)
actions.cooldowns+=/tigers_fury,if=energy.deficit>=60
actions.cooldowns+=/berserking
actions.cooldowns+=/elunes_guidance,if=combo_points=0&energy>=50
actions.cooldowns+=/incarnation,if=energy>=30&(cooldown.tigers_fury.remains>15|buff.tigers_fury.up)
actions.cooldowns+=/potion,name=prolonged_power,if=target.time_to_die<65|(time_to_die<180&(buff.berserk.up|buff.incarnation.up))
actions.cooldowns+=/ashamanes_frenzy,if=combo_points>=2&(!talent.bloodtalons.enabled|buff.bloodtalons.up)
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
actions.st_finishers+=/maim,if=buff.fiery_red_maimers.up
actions.st_finishers+=/ferocious_bite,max_energy=1
actions.st_generators=regrowth,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.bloodtalons.down&combo_points>=2&cooldown.ashamanes_frenzy.remains<gcd
actions.st_generators+=/regrowth,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.bloodtalons.down&combo_points=4&dot.rake.remains<4
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
actions.precombat+=/variable,name=thrash_over_mangle,value=equipped.luffa_wrappings|artifact.jagged_claws.rank>5
actions.precombat+=/bear_form
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions=auto_attack
actions+=/call_action_list,name=cooldowns
actions+=/call_action_list,name=st,if=active_enemies=1
actions+=/call_action_list,name=aoe,if=active_enemies>1
actions.aoe=moonfire,target_if=buff.galactic_guardian.up&equipped.lady_and_the_child&cooldown.thrash_bear.remains<2*gcd&buff.galactic_guardian.remains<2*gcd&(active_enemies<4|equipped.fury_of_nature&active_enemies<5)
actions.aoe+=/pulverize,target_if=cooldown.thrash_bear.remains<2*gcd&dot.thrash_bear.stack=dot.thrash_bear.max_stacks
actions.aoe+=/mangle,if=buff.incarnation.up&!variable.thrash_over_mangle&active_enemies<4
actions.aoe+=/thrash_bear
actions.aoe+=/moonfire,target_if=buff.galactic_guardian.up&equipped.lady_and_the_child&buff.galactic_guardian.remains<gcd&(active_enemies<4|equipped.fury_of_nature&active_enemies<5)
actions.aoe+=/maul,if=rage.deficit<8&(!talent.incarnation.enabled&active_enemies<4|talent.incarnation.enabled&active_enemies<6)
actions.aoe+=/mangle,if=!talent.galactic_guardian.enabled&active_enemies<5|talent.galactic_guardian.enabled&active_enemies<4
actions.aoe+=/moonfire,target_if=!talent.galactic_guardian.enabled&dot.moonfire.refreshable&(!equipped.fury_of_nature&active_enemies<8|equipped.fury_of_nature&active_enemies<11)|buff.galactic_guardian.up&!equipped.lady_and_the_child&active_enemies<3
actions.aoe+=/maul,if=!talent.incarnation.enabled&active_enemies<5|talent.incarnation.enabled&active_enemies<6
actions.aoe+=/moonfire,target_if=!equipped.lady_and_the_child&dot.moonfire.refreshable&active_enemies<3
actions.aoe+=/swipe_bear
actions.cooldowns=rage_of_the_sleeper
actions.cooldowns+=/potion,if=buff.rage_of_the_sleeper.up
actions.cooldowns+=/blood_fury
actions.cooldowns+=/berserking
actions.cooldowns+=/arcane_torrent
actions.cooldowns+=/lights_judgment
actions.cooldowns+=/lunar_beam,if=buff.rage_of_the_sleeper.up
actions.cooldowns+=/incarnation
actions.cooldowns+=/barkskin,if=talent.brambles.enabled&(buff.rage_of_the_sleeper.up|talent.survival_of_the_fittest.enabled)
actions.cooldowns+=/proc_sephuz,if=cooldown.thrash_bear.remains=0
actions.cooldowns+=/use_items,if=cooldown.rage_of_the_sleeper.remains>12|buff.rage_of_the_sleeper.up|target.time_to_die<22
actions.st=maul,if=rage.deficit<8
actions.st+=/moonfire,if=buff.incarnation.up&dot.moonfire.refreshable|!dot.moonfire.ticking
actions.st+=/pulverize,if=cooldown.thrash_bear.remains<2*gcd&dot.thrash_bear.stack=dot.thrash_bear.max_stacks
actions.st+=/thrash_bear,if=variable.thrash_over_mangle|talent.rend_and_tear.enabled&dot.thrash_bear.stack<dot.thrash_bear.max_stacks
actions.st+=/mangle
actions.st+=/thrash_bear
actions.st+=/moonfire,if=buff.galactic_guardian.up|(!talent.galactic_guardian.enabled&dot.moonfire.refreshable)
actions.st+=/maul
actions.st+=/moonfire,if=dot.moonfire.refreshable&talent.galactic_guardian.enabled&!equipped.lady_and_the_child
actions.st+=/swipe_bear
]])
