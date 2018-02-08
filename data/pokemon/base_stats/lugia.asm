	db 106,  90, 130, 110,  90, 154
	;   hp  atk  def  spd  sat  sdf

if DEF(FAITHFUL)
	db PSYCHIC, FLYING
else
	db FLYING, PSYCHIC
endc
	db 3 ; catch rate
	db 220 ; base exp
	db LUM_BERRY ; item 1
	db LUM_BERRY ; item 2
	dn GENDERLESS, 15 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db PRESSURE ; ability 1
if DEF(FAITHFUL)
	db PRESSURE ; ability 2
else
	db CLOUD_NINE ; ability 2
endc
	db MULTISCALE ; hidden ability
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   3
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HAIL, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, GIGA_DRAIN, SAFEGUARD, BULLDOZE, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, PSYCHIC, SHADOW_BALL, ROOST, DOUBLE_TEAM, REFLECT, SANDSTORM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, STEEL_WING, ROCK_SMASH, ENDURE, DRAGON_PULSE, WATER_PULSE, AVALANCHE, GIGA_IMPACT, FLASH, THUNDER_WAVE, FLY, SURF, STRENGTH, WHIRLPOOL, WATERFALL, AQUA_TAIL, BODY_SLAM, DOUBLE_EDGE, DREAM_EATER, EARTH_POWER, HEADBUTT, HYPER_VOICE, ICY_WIND, IRON_HEAD, SKILL_SWAP, SLEEP_TALK, SWAGGER, TRICK, ZAP_CANNON, ZEN_HEADBUTT
	; end
