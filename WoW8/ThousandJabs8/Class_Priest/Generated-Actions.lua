if GetBuildInfo and select(4,GetBuildInfo()) < 80000 then return end

if select(3, UnitClass('player')) ~= 5 then return end

local TJ = LibStub('AceAddon-3.0'):GetAddon('ThousandJabs8')

TJ:RegisterActionProfileList('simc::priest::shadow', 'Simulationcraft Priest Profile: Shadow', 5, 3, [[
actions.precombat=flask
actions.precombat+=/food
actions.precombat+=/augmentation
actions.precombat+=/snapshot_stats
actions.precombat+=/potion
actions.precombat+=/shadowform,if=!buff.shadowform.up
actions.precombat+=/mind_blast
actions.precombat+=/shadow_word_void
actions=potion,if=buff.bloodlust.react|target.time_to_die<=80|target.health.pct<35
actions+=/run_action_list,name=aoe,if=spell_targets.mind_sear>(5+1*talent.misery.enabled)
actions+=/run_action_list,name=cleave,if=active_enemies>1
actions+=/run_action_list,name=single,if=active_enemies=1
actions.aoe=void_eruption
actions.aoe+=/dark_ascension,if=buff.voidform.down&azerite.whispers_of_the_damned.rank=0
actions.aoe+=/dark_ascension,if=buff.voidform.down&(cooldown.mindbender.remains>0|cooldown.shadowfiend.remains>0)&azerite.whispers_of_the_damned.rank>0
actions.aoe+=/void_bolt,if=talent.dark_void.enabled&dot.shadow_word_pain.remains>travel_time
actions.aoe+=/surrender_to_madness,if=buff.voidform.stack>=(15+buff.bloodlust.up)
actions.aoe+=/dark_void
actions.aoe+=/shadowfiend,if=!talent.mindbender.enabled&buff.voidform.up&talent.dark_ascension.enabled&azerite.whispers_of_the_damned.rank>0
actions.aoe+=/shadowfiend,if=!talent.mindbender.enabled&(!talent.dark_ascension.enabled|azerite.whispers_of_the_damned.rank=0)
actions.aoe+=/mindbender,if=talent.mindbender.enabled&buff.voidform.up&talent.dark_ascension.enabled&azerite.whispers_of_the_damned.rank>0
actions.aoe+=/mindbender,if=talent.mindbender.enabled&(!talent.dark_ascension.enabled|azerite.whispers_of_the_damned.rank=0)
actions.aoe+=/shadow_crash,if=raid_event.adds.in>5&raid_event.adds.duration<20
actions.aoe+=/mind_sear,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(cooldown.void_bolt.up|cooldown.mind_blast.up)
actions.aoe+=/shadow_word_pain
actions.cleave=void_eruption
actions.cleave+=/dark_ascension,if=buff.voidform.down&azerite.whispers_of_the_damned.rank=0
actions.cleave+=/dark_ascension,if=buff.voidform.down&(cooldown.mindbender.remains>0|cooldown.shadowfiend.remains>0)&azerite.whispers_of_the_damned.rank>0
actions.cleave+=/void_bolt
actions.cleave+=/shadow_word_death,target_if=target.time_to_die<3|buff.voidform.down
actions.cleave+=/surrender_to_madness,if=buff.voidform.stack>=(15+buff.bloodlust.up)
actions.cleave+=/dark_void
actions.cleave+=/shadowfiend,if=!talent.mindbender.enabled&buff.voidform.up&talent.dark_ascension.enabled&azerite.whispers_of_the_damned.rank>0
actions.cleave+=/shadowfiend,if=!talent.mindbender.enabled&(!talent.dark_ascension.enabled|azerite.whispers_of_the_damned.rank=0)
actions.cleave+=/mindbender,if=talent.mindbender.enabled&buff.voidform.up&talent.dark_ascension.enabled&azerite.whispers_of_the_damned.rank>0
actions.cleave+=/mindbender,if=talent.mindbender.enabled&(!talent.dark_ascension.enabled|azerite.whispers_of_the_damned.rank=0)
actions.cleave+=/mind_blast,if=buff.voidform.down&talent.misery.enabled
actions.cleave+=/shadow_crash,if=(raid_event.adds.in>5&raid_event.adds.duration<2)|raid_event.adds.duration>2
actions.cleave+=/shadow_word_pain,target_if=refreshable&target.time_to_die>4,if=!talent.misery.enabled&!talent.dark_void.enabled
actions.cleave+=/vampiric_touch,target_if=refreshable,if=(target.time_to_die>6)
actions.cleave+=/vampiric_touch,target_if=dot.shadow_word_pain.refreshable,if=(talent.misery.enabled&target.time_to_die>4)
actions.cleave+=/void_torrent
actions.cleave+=/mind_blast,if=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking&azerite.whispers_of_the_damned.rank>0&talent.dark_ascension.enabled
actions.cleave+=/mind_sear,target_if=spell_targets.mind_sear>2,chain=1,interrupt=1
actions.cleave+=/mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(cooldown.void_bolt.up|cooldown.mind_blast.up)
actions.cleave+=/shadow_word_pain
actions.single=void_eruption
actions.single+=/dark_ascension,if=buff.voidform.down&azerite.whispers_of_the_damned.rank=0
actions.single+=/dark_ascension,if=buff.voidform.down&(cooldown.mindbender.remains>0|cooldown.shadowfiend.remains>0)&azerite.whispers_of_the_damned.rank>0
actions.single+=/void_bolt
actions.single+=/shadow_word_death,if=target.time_to_die<3|cooldown.shadow_word_death.charges=2
actions.single+=/surrender_to_madness,if=buff.voidform.stack>=(15+buff.bloodlust.up)&target.time_to_die>200|target.time_to_die<75
actions.single+=/dark_void
actions.single+=/shadowfiend,if=!talent.mindbender.enabled&buff.voidform.up&talent.dark_ascension.enabled&azerite.whispers_of_the_damned.rank>0
actions.single+=/shadowfiend,if=!talent.mindbender.enabled&(!talent.dark_ascension.enabled|azerite.whispers_of_the_damned.rank=0)
actions.single+=/mindbender,if=talent.mindbender.enabled&buff.voidform.up&talent.dark_ascension.enabled&azerite.whispers_of_the_damned.rank>0
actions.single+=/mindbender,if=talent.mindbender.enabled&(!talent.dark_ascension.enabled|azerite.whispers_of_the_damned.rank=0)
actions.single+=/mind_blast,if=(dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking)|(talent.shadow_word_void.enabled&cooldown.shadow_word_void.charges=2)
actions.single+=/shadow_word_death,if=!buff.voidform.up|(cooldown.shadow_word_death.charges=2&buff.voidform.stack<15)
actions.single+=/shadow_crash,if=raid_event.adds.in>5&raid_event.adds.duration<20
actions.single+=/mind_blast,if=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking
actions.single+=/void_torrent,if=dot.shadow_word_pain.remains>4&dot.vampiric_touch.remains>4
actions.single+=/shadow_word_pain,if=refreshable&target.time_to_die>4&!talent.misery.enabled&!talent.dark_void.enabled
actions.single+=/vampiric_touch,if=refreshable&target.time_to_die>6|(talent.misery.enabled&dot.shadow_word_pain.refreshable)
actions.single+=/mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(cooldown.void_bolt.up|cooldown.mind_blast.up)
actions.single+=/shadow_word_pain
]])

