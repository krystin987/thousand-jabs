if GetBuildInfo and select(4,GetBuildInfo()) < 80000 then return end

if select(3, UnitClass('player')) ~= 3 then return end

local TJ = LibStub('AceAddon-3.0'):GetAddon('ThousandJabs')

TJ:RegisterActionProfileList('simc::hunter::beast_mastery', 'Simulationcraft Hunter Profile: Beast Mastery', 3, 1, [[
actions.precombat=flask
actions.precombat+=/augmentation
actions.precombat+=/food
actions.precombat+=/summon_pet
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions.precombat+=/aspect_of_the_wild
actions=auto_shot
actions+=/use_items
actions+=/berserking,if=cooldown.bestial_wrath.remains>30
actions+=/blood_fury,if=cooldown.bestial_wrath.remains>30
actions+=/ancestral_call,if=cooldown.bestial_wrath.remains>30
actions+=/fireblood,if=cooldown.bestial_wrath.remains>30
actions+=/lights_judgment
actions+=/potion,if=buff.bestial_wrath.up&buff.aspect_of_the_wild.up
actions+=/barbed_shot,if=pet.cat.buff.frenzy.up&pet.cat.buff.frenzy.remains<=gcd.max
actions+=/a_murder_of_crows
actions+=/spitting_cobra
actions+=/stampede,if=buff.bestial_wrath.up|cooldown.bestial_wrath.remains<gcd|target.time_to_die<15
actions+=/aspect_of_the_wild
actions+=/bestial_wrath,if=!buff.bestial_wrath.up
actions+=/multishot,if=spell_targets>2&(pet.cat.buff.beast_cleave.remains<gcd.max|pet.cat.buff.beast_cleave.down)
actions+=/chimaera_shot
actions+=/kill_command
actions+=/dire_beast
actions+=/barbed_shot,if=pet.cat.buff.frenzy.down&charges_fractional>1.4|full_recharge_time<gcd.max|target.time_to_die<9
actions+=/multishot,if=spell_targets>1&(pet.cat.buff.beast_cleave.remains<gcd.max|pet.cat.buff.beast_cleave.down)
actions+=/cobra_shot,if=(active_enemies<2|cooldown.kill_command.remains>focus.time_to_max)&(buff.bestial_wrath.up&active_enemies>1|cooldown.kill_command.remains>1+gcd&cooldown.bestial_wrath.remains>focus.time_to_max|focus-cost+focus.regen*(cooldown.kill_command.remains-1)>action.kill_command.cost)
]])

TJ:RegisterActionProfileList('simc::hunter::marksmanship', 'Simulationcraft Hunter Profile: Marksmanship', 3, 2, [[
actions.precombat=flask
actions.precombat+=/augmentation
actions.precombat+=/food
actions.precombat+=/summon_pet,if=active_enemies<3
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions.precombat+=/hunters_mark
actions.precombat+=/double_tap,precast_time=5
actions.precombat+=/aimed_shot,if=active_enemies<3
actions.precombat+=/explosive_shot,if=active_enemies>2
actions=auto_shot
actions+=/use_items
actions+=/call_action_list,name=cds
actions+=/call_action_list,name=st,if=active_enemies<3
actions+=/call_action_list,name=trickshots,if=active_enemies>2
actions.cds=hunters_mark,if=debuff.hunters_mark.down
actions.cds+=/double_tap,if=cooldown.rapid_fire.remains<gcd
actions.cds+=/berserking,if=cooldown.trueshot.remains>30
actions.cds+=/blood_fury,if=cooldown.trueshot.remains>30
actions.cds+=/ancestral_call,if=cooldown.trueshot.remains>30
actions.cds+=/fireblood,if=cooldown.trueshot.remains>30
actions.cds+=/lights_judgment
actions.cds+=/potion,if=(buff.trueshot.react&buff.bloodlust.react)|((consumable.prolonged_power&target.time_to_die<62)|target.time_to_die<31)
actions.cds+=/trueshot,if=cooldown.aimed_shot.charges<1|talent.barrage.enabled&cooldown.aimed_shot.charges_fractional<1.3
actions.st=explosive_shot
actions.st+=/barrage,if=active_enemies>1
actions.st+=/arcane_shot,if=buff.precise_shots.up&(cooldown.aimed_shot.full_recharge_time<gcd*buff.precise_shots.stack+action.aimed_shot.cast_time|buff.lethal_shots.up)
actions.st+=/rapid_fire,if=(!talent.lethal_shots.enabled|buff.lethal_shots.up)&azerite.focused_fire.enabled|azerite.in_the_rhythm.rank>1
actions.st+=/aimed_shot,if=buff.precise_shots.down&(buff.double_tap.down&full_recharge_time<cast_time+gcd|buff.lethal_shots.up)
actions.st+=/rapid_fire,if=!talent.lethal_shots.enabled|buff.lethal_shots.up
actions.st+=/piercing_shot
actions.st+=/a_murder_of_crows
actions.st+=/serpent_sting,if=refreshable
actions.st+=/aimed_shot,if=buff.precise_shots.down&(!talent.steady_focus.enabled&focus>70|!talent.lethal_shots.enabled|buff.lethal_shots.up)
actions.st+=/arcane_shot,if=buff.precise_shots.up|focus>60&(!talent.lethal_shots.enabled|buff.lethal_shots.up)
actions.st+=/steady_shot,if=focus+cast_regen<focus.max|(talent.lethal_shots.enabled&buff.lethal_shots.down)
actions.st+=/arcane_shot
actions.trickshots=barrage
actions.trickshots+=/explosive_shot
actions.trickshots+=/rapid_fire,if=buff.trick_shots.up&!talent.barrage.enabled
actions.trickshots+=/aimed_shot,if=buff.trick_shots.up&buff.precise_shots.down&buff.double_tap.down&(!talent.lethal_shots.enabled|buff.lethal_shots.up|focus>60)
actions.trickshots+=/rapid_fire,if=buff.trick_shots.up
actions.trickshots+=/multishot,if=buff.trick_shots.down|(buff.precise_shots.up|buff.lethal_shots.up)&(!talent.barrage.enabled&buff.steady_focus.down&focus>45|focus>70)
actions.trickshots+=/piercing_shot
actions.trickshots+=/a_murder_of_crows
actions.trickshots+=/serpent_sting,if=refreshable
actions.trickshots+=/steady_shot,if=focus+cast_regen<focus.max|(talent.lethal_shots.enabled&buff.lethal_shots.down)
]])

TJ:RegisterActionProfileList('simc::hunter::survival', 'Simulationcraft Hunter Profile: Survival', 3, 3, [[
actions.precombat=flask
actions.precombat+=/augmentation
actions.precombat+=/food
actions.precombat+=/summon_pet
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions.precombat+=/steel_trap
actions.precombat+=/harpoon
actions=auto_attack
actions+=/use_items
actions+=/call_action_list,name=cds
actions+=/call_action_list,name=wfi_st,if=active_enemies<2&talent.wildfire_infusion.enabled
actions+=/call_action_list,name=st,if=active_enemies<2&!talent.wildfire_infusion.enabled
actions+=/call_action_list,name=cleave,if=active_enemies>1
actions.cds=berserking,if=cooldown.coordinated_assault.remains>30
actions.cds+=/blood_fury,if=cooldown.coordinated_assault.remains>30
actions.cds+=/ancestral_call,if=cooldown.coordinated_assault.remains>30
actions.cds+=/fireblood,if=cooldown.coordinated_assault.remains>30
actions.cds+=/lights_judgment
actions.cds+=/arcane_torrent,if=cooldown.kill_command.remains>gcd.max&focus<=30
actions.cds+=/potion,if=buff.coordinated_assault.up&(buff.berserking.up|buff.blood_fury.up|!race.troll&!race.orc)
actions.cds+=/aspect_of_the_eagle,if=target.distance>=6
actions.cleave=variable,name=carve_cdr,op=setif,value=active_enemies,value_else=5,condition=active_enemies<5
actions.cleave+=/a_murder_of_crows
actions.cleave+=/coordinated_assault
actions.cleave+=/carve,if=dot.shrapnel_bomb.ticking
actions.cleave+=/wildfire_bomb,if=!talent.guerrilla_tactics.enabled|full_recharge_time<gcd
actions.cleave+=/chakrams
actions.cleave+=/kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max
actions.cleave+=/butchery,if=full_recharge_time<gcd|!talent.wildfire_infusion.enabled|dot.shrapnel_bomb.ticking&dot.internal_bleeding.stack<3
actions.cleave+=/carve,if=talent.guerrilla_tactics.enabled
actions.cleave+=/flanking_strike,if=focus+cast_regen<focus.max
actions.cleave+=/wildfire_bomb,if=dot.wildfire_bomb.refreshable|talent.wildfire_infusion.enabled
actions.cleave+=/serpent_sting,target_if=min:remains,if=buff.vipers_venom.up
actions.cleave+=/carve,if=cooldown.wildfire_bomb.remains>variable.carve_cdr%2
actions.cleave+=/steel_trap
actions.cleave+=/harpoon,if=talent.terms_of_engagement.enabled
actions.cleave+=/serpent_sting,target_if=min:remains,if=refreshable&buff.tip_of_the_spear.stack<3
actions.cleave+=/mongoose_bite_eagle
actions.cleave+=/mongoose_bite
actions.cleave+=/raptor_strike_eagle
actions.cleave+=/raptor_strike
actions.st=a_murder_of_crows
actions.st+=/coordinated_assault
actions.st+=/raptor_strike_eagle,if=talent.birds_of_prey.enabled&buff.coordinated_assault.up&buff.coordinated_assault.remains<gcd
actions.st+=/raptor_strike,if=talent.birds_of_prey.enabled&buff.coordinated_assault.up&buff.coordinated_assault.remains<gcd
actions.st+=/mongoose_bite_eagle,if=talent.birds_of_prey.enabled&buff.coordinated_assault.up&buff.coordinated_assault.remains<gcd
actions.st+=/mongoose_bite,if=talent.birds_of_prey.enabled&buff.coordinated_assault.up&buff.coordinated_assault.remains<gcd
actions.st+=/kill_command,if=focus+cast_regen<focus.max&buff.tip_of_the_spear.stack<3
actions.st+=/chakrams
actions.st+=/steel_trap
actions.st+=/wildfire_bomb,if=focus+cast_regen<focus.max&(full_recharge_time<gcd|dot.wildfire_bomb.refreshable&buff.mongoose_fury.down)
actions.st+=/harpoon,if=talent.terms_of_engagement.enabled
actions.st+=/flanking_strike,if=focus+cast_regen<focus.max
actions.st+=/serpent_sting,if=buff.vipers_venom.up|refreshable&(!talent.mongoose_bite.enabled&focus<90|!talent.vipers_venom.enabled)
actions.st+=/mongoose_bite_eagle,if=buff.mongoose_fury.up|focus>60
actions.st+=/mongoose_bite,if=buff.mongoose_fury.up|focus>60
actions.st+=/raptor_strike_eagle
actions.st+=/raptor_strike
actions.st+=/wildfire_bomb,if=dot.wildfire_bomb.refreshable
actions.st+=/serpent_sting,if=refreshable
actions.wfi_st=a_murder_of_crows
actions.wfi_st+=/coordinated_assault
actions.wfi_st+=/kill_command,if=focus+cast_regen<focus.max&buff.tip_of_the_spear.stack<3
actions.wfi_st+=/raptor_strike,if=dot.internal_bleeding.stack<3&dot.shrapnel_bomb.ticking&!talent.mongoose_bite.enabled
actions.wfi_st+=/wildfire_bomb,if=full_recharge_time<gcd|(focus+cast_regen<focus.max)&(next_wi_bomb.volatile&dot.serpent_sting.ticking&dot.serpent_sting.refreshable|next_wi_bomb.pheromone&focus+cast_regen<focus.max-action.kill_command.cast_regen*3)
actions.wfi_st+=/wildfire_bomb,if=next_wi_bomb.shrapnel&buff.mongoose_fury.down&(cooldown.kill_command.remains>gcd|focus>60)
actions.wfi_st+=/steel_trap
actions.wfi_st+=/flanking_strike,if=focus+cast_regen<focus.max
actions.wfi_st+=/serpent_sting,if=buff.vipers_venom.up|refreshable&(!talent.mongoose_bite.enabled|next_wi_bomb.volatile&!dot.shrapnel_bomb.ticking)
actions.wfi_st+=/harpoon,if=talent.terms_of_engagement.enabled
actions.wfi_st+=/mongoose_bite_eagle,if=buff.mongoose_fury.up|focus>60|dot.shrapnel_bomb.ticking
actions.wfi_st+=/mongoose_bite,if=buff.mongoose_fury.up|focus>60|dot.shrapnel_bomb.ticking
actions.wfi_st+=/raptor_strike_eagle
actions.wfi_st+=/raptor_strike
actions.wfi_st+=/serpent_sting,if=refreshable
actions.wfi_st+=/wildfire_bomb,if=next_wi_bomb.volatile&dot.serpent_sting.ticking|next_wi_bomb.pheromone|next_wi_bomb.shrapnel&focus>50
]])
