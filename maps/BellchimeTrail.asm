BellchimeTrail_MapScriptHeader:
	db 1 ; scene scripts
	scene_script BellchimeTrailStepDownTrigger

	db 1 ; callbacks
	callback MAPCALLBACK_OBJECTS, SetupValerieMorningWalkCallback

	db 3 ; warp events
	warp_event  4,  4, WISE_TRIOS_ROOM, 1
	warp_event  4,  5, WISE_TRIOS_ROOM, 2
	warp_event 21,  9, TIN_TOWER_1F, 1 ; hole

	db 1 ; coord events
	coord_event 21,  9, 1, BellchimeTrailPanUpTrigger

	db 1 ; bg events
	bg_event 22, 12, SIGNPOST_JUMPTEXT, TinTowerSignText

	db 1 ; object events
	object_event 16,  6, SPRITE_VALERIE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BellchimeTrailValerieScript, EVENT_VALERIE_BELLCHIME_TRAIL

	const_def 1 ; object constants
	const BELLCHIMETRAIL_VALERIE

BellchimeTrailStepDownTrigger:
	priorityjump .Script
	end

.Script:
	checkcode VAR_YCOORD
	if_not_equal $9, .Done
	checkcode VAR_XCOORD
	if_not_equal $15, .Done
	applyonemovement PLAYER, step_down
.Done
	dotrigger $1
	end

SetupValerieMorningWalkCallback:
	checkevent EVENT_FOUGHT_SUICUNE
	iffalse .Disappear
	checkevent EVENT_BEAT_VALERIE
	iffalse .Appear
	checkflag ENGINE_VALERIE_MORNING_WALK
	iftrue .Disappear
	checkmorn
	iffalse .Disappear
.Appear:
	appear BELLCHIMETRAIL_VALERIE
	return

.Disappear:
	disappear BELLCHIMETRAIL_VALERIE
	return

BellchimeTrailPanUpTrigger:
	playsound SFX_EXIT_BUILDING
	applyonemovement PLAYER, hide_person
	waitsfx
	applymovement PLAYER, .PanUpMovement
	disappear PLAYER
	pause 10
	special Special_FadeOutMusic
	special FadeOutPalettes
	pause 15
	dotrigger $0
	warpfacing UP, TIN_TOWER_1F, 7, 15
	end

.PanUpMovement:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

TinTowerSignText:
	text "Bell Tower"

	para "A legendary #-"
	line "mon is said to"
	cont "roost here."
	done

BellchimeTrailValerieScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_VALERIE
	iftrue .Rematch
	checkevent EVENT_LISTENED_TO_VALERIE
	iftrue .Listened
	writetext .IntroText
	waitbutton
	setevent EVENT_LISTENED_TO_VALERIE
.Listened:
	writetext .BattleText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .AcceptedText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BELLCHIMETRAIL_VALERIE
	loadtrainer VALERIE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_VALERIE
	opentext
	writetext .RewardText
	buttonsound
	verbosegivetmhm TM_DAZZLINGLEAM
	setevent EVENT_GOT_TM49_DAZZLINGLEAM_FROM_VALERIE
	writetext .FarewellText
.Depart
	waitbutton
	closetext
	checkcode VAR_FACING
	if_not_equal RIGHT, .SkipGoAround
	applymovement BELLCHIMETRAIL_VALERIE, .ValerieGoesAroundMovement
.SkipGoAround
	applymovement BELLCHIMETRAIL_VALERIE, .ValerieDepartsMovement
	disappear BELLCHIMETRAIL_VALERIE
	clearevent EVENT_VALERIE_ECRUTEAK_CITY
	setflag ENGINE_VALERIE_MORNING_WALK
	end

.Rematch:
	writetext .RematchText
	waitbutton
	closetext
	winlosstext .RematchBeatenText, 0
	setlasttalked BELLCHIMETRAIL_VALERIE
	checkcode VAR_BADGES
	if_equal 16, .Battle3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .Battle2
	loadtrainer VALERIE, 1
	startbattle
	reloadmapafterbattle
	jump .AfterRematch

.Battle2:
	loadtrainer VALERIE, 2
	startbattle
	reloadmapafterbattle
	jump .AfterRematch

.Battle3:
	loadtrainer VALERIE, 3
	startbattle
	reloadmapafterbattle
	jump .AfterRematch

.AfterRematch:
	opentext
	writetext .RematchFarewellText
	jump .Depart

.IntroText:
	text "If it isn't the"
	line "trainer who faced"
	cont "Suicune…"

	para "I am Valerie."
	line "I come to this"

	para "trail to be"
	line "captivated by its"
	cont "beauty."

	para "Today I was for-"
	line "tunate enough to"

	para "witness your"
	line "battle with a"
	cont "legend…"

	para "I would love to"
	line "contend with one"

	para "who caught the eye"
	line "of a legendary"
	cont "#mon."
	done

.BattleText:
	text "Valerie: I train"
	line "the elusive Fairy"
	cont "type."

	para "They appear frail"
	line "and delicate, but"
	cont "they are strong."

	para "Will you battle"
	line "with me?"
	done

.RefusedText:
	text "Valerie: Alas…"
	done

.AcceptedText:
	text "Valerie: I hope"
	line "our battle will"

	para "prove entertaining"
	line "to you."
	done

.BeatenText:
	text "I hope the sun is"
	line "shining tomorrow…"

	para "That would be"
	line "reason enough to"
	cont "smile."
	done

.RewardText:
	text "Valerie: Yes… that"
	line "was a fine battle."

	para "I shall reward you"
	line "for this great"
	cont "victory."

	para "Please consider"
	line "this as a personal"
	cont "gift from me."
	done

.FarewellText:
	text "Valerie: Oh? My,"
	line "what a curious"
	cont "feeling…"

	para "I can't seem to"
	line "recall which move"

	para "is contained in"
	line "that TM."

	para "I hope you might"
	line "forgive me."

	para "That was truly a"
	line "captivating"
	cont "battle."

	para "I might just be"
	line "captivated by you."

	para "Until we meet"
	line "again, farewell."
	done

.RematchText:
	text "Valerie: Oh, if it"
	line "isn't my young"
	cont "trainer…"

	para "It is lovely to"
	line "meet you again"
	cont "like this."

	para "Then I suppose you"
	line "have earned your-"

	para "self the right to"
	line "a battle."

	para "The elusive Fairy"
	line "may appear frail"

	para "as the breeze and"
	line "delicate as a"

	para "bloom, but it is"
	line "strong."
	done

.RematchBeatenText:
	text "I hope that you"
	line "will find things"

	para "worth smiling"
	line "about tomorrow…"
	done

.RematchFarewellText:
	text "That was truly a"
	line "captivating"
	cont "battle."

	para "I might just be"
	line "captivated by you."

	para "Until we meet"
	line "again, farewell."
	done

.ValerieGoesAroundMovement:
	step_down
	step_left
	step_end

.ValerieDepartsMovement:
	step_left
	step_left
	step_left
	step_up
	step_up
	step_left
	step_left
	step_end
