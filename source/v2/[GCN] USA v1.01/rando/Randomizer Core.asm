;╔════════════════════════════════════════════════════════════╗
;║ Randomize Generator                             Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
;---STACK------------------------------------------------------
; 0x0000 Old SP
; 0x0004 LR Reserved
; 0x0008 save r20
; ...    ...
; ...    save r31
;---Compiler Constants-----------------------------------------
gpr_save = 20
header_size = 8

permVar0 = 31
permVar1 = 30
permVar2 = 29
permVar3 = 28
permVar4 = 27
permVar5 = 26

tempVar0 = 23
tempVar1 = 22
tempVar2 = 21
tempVar3 = 20
;---Local Vars-------------------------------------------------
current_generator  = permVar0   ;Generator* current_generator
old_GenObject      = permVar1   ;GenObject* old_GenObject
new_GenObject      = permVar2   ;GenObject* new_GenObject
rando_id           = permVar3   ;int rando_id
curr_itempellet_id = permVar4   ;int curr_itempellet_id
;---Function Pointers------------------------------------------
makeObjectPlant__Fv            = 0x8011accc
makeObjectTeki__Fv             = 0x8011b2cc
makeObjectBoss__Fv             = 0x8014d2d0
makeObjectPellet__Fv           = 0x80099d1c
makeObjectPiki__Fv             = 0x800dad34
makeObjectItem__Fv             = 0x800ee470
makeObjectWorkObject__Fv       = 0x8009b7c4
randomInt__7NSystemFi          = 0x8011e8a4
rand                           = 0x80218070
init__7BossMgrFii              = 0x80150f24
getConfigFromIdx__9PelletMgrFi = 0x80098c88
getConfigIndex__9PelletMgrFUl  = 0x80098c48
isUfoPartsID__6PelletFUl       = 0x800953ac

bossMgr                  = 0x3168
pelletMgr                = 0x301C
current_stage            = -0x7F1C
playerState              = 0x2F6C

none = 0x6E6F6E65
;---Constants--------------------------------------------------
GENOBJECT_TEKI = 0
GENOBJECT_BOSS = 1
GENOBJECT_PLANT = 2
GENOBJECT_PELLET = 3

RANDO_LIMIT   = 0
RANDO_BASIC   = 1
RANDO_HARD    = 2
RANDO_GEYSER  = 3
RANDO_DECOR   = 4
RANDO_DELETE  = 5
RANDO_S_PELLET = 6
RANDO_L_PELLET = 7
RANDO_UFOPART  = 8
;--------------------------------------------------------------

HEADER:;=======================================================
mflr	r0
bl	FOOTER
;==============================================================

PROLOGUE:
	mflr	r0
	stw	r0, 0x0004 (sp)
	stwu	sp, -( 0x0008 + ( ( 32 - gpr_save ) * 4 ) ) (sp)
	stmw	gpr_save, 0x0008 (sp)
	mr	current_generator, r3

BODY:
	old_GenObject_type = tempVar0
	type_from_table    = tempVar1
	GenObject_id_table = tempVar2
	
	lwz	old_GenObject, 0x0034 (current_generator)
	
	mr.	new_GenObject, old_GenObject
	beq-	UPDATE   ;nullptr check because Distant Spring

	bl	SKIP_GenObject_id_table
		.ascii "teki"
		.ascii "boss"
		.ascii "plnt"
		.ascii "pelt"
		.ascii "item"
;		.ascii "piki"
;		.ascii "work"
;		.ascii "debg"
;		.ascii "navi"
;		.ascii "mpar"
;		.ascii "mobj"
;		.ascii "actr"
		.balign 4
	SKIP_GenObject_id_table:
	mflr	GenObject_id_table
	
	lwz	old_GenObject_type, 0x0008 (old_GenObject)
	
	lwz	type_from_table, 0x0000 (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_TEKI
	lwz	type_from_table, 0x0004 (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_BOSS
	lwz	type_from_table, 0x0008 (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_PLANT
	lwz	type_from_table, 0x000C (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_PELLET
	b	UPDATE
	
	IS_PLANT:
		plant_id_table = tempVar0
		old_plant_id   = tempVar1
		
		bl	SKIP_plant_id_table
			.byte RANDO_DECOR     ;clover
			.byte RANDO_DECOR     ;chidome
			.byte RANDO_DECOR     ;hutaba
			.byte RANDO_DECOR     ;ine
			.byte RANDO_DECOR     ;tanpopo
			.byte RANDO_DECOR     ;ooinu_l
			.byte RANDO_DECOR     ;ooinu_s
			.byte RANDO_DECOR     ;mizikusa
			.byte RANDO_DECOR     ;wakame_l
			.byte RANDO_DECOR     ;wakame_s
			.byte RANDO_DECOR     ;kinokolt
			.byte RANDO_LIMIT     ;hae
			.balign 4
		SKIP_plant_id_table:
		mflr	plant_id_table
		lwz	old_plant_id, 0x0018 (old_GenObject)
		lbzx	rando_id, plant_id_table, old_plant_id
		li	curr_itempellet_id, -1   ;Set to none
		b	RANDO_DISAMBIGUATION

	IS_TEKI:
		teki_id_table = tempVar0
		old_teki_id   = tempVar1
		
		bl	SKIP_teki_id_table
			.byte RANDO_BASIC     ;00 frog      Yellow Wollywog
			.byte RANDO_BASIC     ;01 iwagen    Iwagen
			.byte 0               ;02 iwagon    Rolling Boulder
			.byte RANDO_LIMIT     ;03 chappy    Dwarf Bulborb
			.byte RANDO_BASIC     ;04 swallow   Spotty Bulborb
			.byte RANDO_LIMIT     ;05 mizigen   Honeywisps Generator
			.byte 0               ;06 qurione   Lone Honeywisp (invalid)
			.byte RANDO_LIMIT     ;07 palm      Pellet Posy
			.byte RANDO_BASIC     ;08 collec    Breadbug
			.byte RANDO_HARD      ;09 kinoko    Puffstool
			.byte RANDO_BASIC     ;0A shell     Pearly Clamclamp
			.byte RANDO_BASIC     ;0B napkid    Snitchbug
			.byte RANDO_DELETE    ;0C hollec    Breadbug Nest
			.byte RANDO_LIMIT     ;0D pearl     Lone Pearl (invalid)
			.byte RANDO_LIMIT     ;0E rocpe     Lone Rocket Pearl (invalid)
			.byte RANDO_BASIC     ;0F tank      Fiery Blowhog
			.byte RANDO_BASIC     ;10 mar       Puffy Blowhog
			.byte RANDO_HARD      ;11 beatle    Armored Cannon Beetle
			.byte RANDO_LIMIT     ;12 kabekuiA  Female Sheargrub
			.byte RANDO_LIMIT     ;13 kabekuiB  Male Sheargrub
			.byte RANDO_LIMIT     ;14 kabekuiC  Shearwig
			.byte RANDO_BASIC     ;15 tamago    Giant Egg
			.byte RANDO_HARD      ;16 dororo    Smoky Progg
			.byte RANDO_LIMIT     ;17 hibaA     Fire Geyser
			.byte RANDO_HARD      ;18 miurin    Mamuta
			.byte RANDO_LIMIT     ;19 otama     Wogpole
			.byte 0               ;1A usuba     Usuba (invalid)
			.byte 0               ;1B yamash3   (invalid)
			.byte 0               ;1C yamash4   (invalid)
			.byte 0               ;1D yamash5   (invalid)
			.byte RANDO_LIMIT     ;1E namazu    Water Dumple
			.byte RANDO_LIMIT     ;1F chappb    Dwarf Bulbear
			.byte RANDO_BASIC     ;20 swallob   Spotty Bulbear
			.byte RANDO_BASIC     ;21 frow      White Wollywog
			.byte 0               ;22 nakata1   (invalid)
			.balign 4
		SKIP_teki_id_table:
		mflr	teki_id_table
		lwz	old_teki_id, 0x001C (old_GenObject)
		lbzx	rando_id, teki_id_table, old_teki_id
		
		lwz	curr_itempellet_id, 0x0018 (old_GenObject)   ;TekiPersonality*
		lwz	curr_itempellet_id, 0x0028 (curr_itempellet_id)
		lwz	r3, pelletMgr (r13)
		mr	r4, curr_itempellet_id
		lis	r12,      getConfigIndex__9PelletMgrFUl@h
		ori	r12, r12, getConfigIndex__9PelletMgrFUl@l
		mtctr	r12
		bctrl	;-->[getConfigIndex__9PelletMgrFUl]
;		mr	curr_itempellet_id, r3
;		mr	r3, curr_itempellet_id
		bl	FindNewUfoPart
		mr	curr_itempellet_id, r3
		b	RANDO_DISAMBIGUATION
	
	IS_BOSS:
		boss_id_table      = tempVar0
		old_boss_id        = tempVar1
		
		bl	SKIP_boss_id_table
			.byte RANDO_HARD      ;00 kumo
			.byte RANDO_HARD      ;01 snake (sphere)
			.byte RANDO_HARD      ;02 slime
			.byte RANDO_HARD      ;03 king
			.byte RANDO_LIMIT     ;04 kogane
			.byte RANDO_BASIC     ;05 pom
			.byte 0               ;06 kingback
			.byte RANDO_HARD      ;07 snake (prism)
			.byte RANDO_GEYSER    ;08 mizu (off)
			.byte RANDO_GEYSER    ;09 mizu (on)
			.balign 4
		SKIP_boss_id_table:
		mflr	boss_id_table
		lwz	old_boss_id, 0x0018 (old_GenObject)
		lbzx	rando_id, boss_id_table, old_boss_id
		lwz	r3, 0x0028 (old_GenObject)
		bl	FindNewUfoPart
		mr	curr_itempellet_id, r3
		b	RANDO_DISAMBIGUATION
	
	IS_PELLET:
		pellet_id_table = tempVar0
		old_pellet_id   = tempVar1
		
		bl	SKIP_pellet_id_table
			.byte	RANDO_S_PELLET   ;Blue 1 Pellet
			.byte	RANDO_S_PELLET   ;Blue 5 Pellet
			.byte	RANDO_L_PELLET   ;Blue 10 Pellet
			.byte	RANDO_L_PELLET   ;Blue 20 Pellet
			.byte	RANDO_S_PELLET   ;Red 1 Pellet
			.byte	RANDO_S_PELLET   ;Red 5 Pellet
			.byte	RANDO_L_PELLET   ;Red 10 Pellet
			.byte	RANDO_L_PELLET   ;Red 20 Pellet
			.byte	RANDO_S_PELLET   ;Yellow 1 Pellet
			.byte	RANDO_S_PELLET   ;Yellow 5 Pellet
			.byte	RANDO_L_PELLET   ;Yellow 10 Pellet
			.byte	RANDO_L_PELLET   ;Yellow 20 Pellet
			.byte	RANDO_L_PELLET   ;Spotty Bulborb
			.byte	RANDO_S_PELLET   ;Dwarf Bulborb
			.byte	RANDO_S_PELLET   ;Yellow Wollywog
			.byte	RANDO_L_PELLET   ;Puffstool
			.byte	RANDO_S_PELLET   ;Breadbug
			.byte	RANDO_S_PELLET   ;Fiery Blowhog
			.byte	RANDO_S_PELLET   ;Female Sheargrub
			.byte	RANDO_UFOPART   ;Bowspirit
			.byte	RANDO_UFOPART   ;Gluon Drive
			.byte	RANDO_UFOPART   ;Anti-Dioxin Filter
			.byte	RANDO_UFOPART   ;Eternal Fuel Dynamo
			.byte	RANDO_UFOPART   ;Main Engine
			.byte	RANDO_UFOPART   ;Whimsical Radar
			.byte	RANDO_UFOPART   ;Interstellar Radio
			.byte	RANDO_UFOPART   ;Guard Satellite
			.byte	RANDO_UFOPART   ;Chronos Reactor
			.byte	RANDO_UFOPART   ;Radiation Canopy
			.byte	RANDO_UFOPART   ;Geiger Counter
			.byte	RANDO_UFOPART   ;Sagittarius
			.byte	RANDO_UFOPART   ;Libra
			.byte	RANDO_UFOPART   ;Omega Stabilizer
			.byte	RANDO_UFOPART   ;Ionium Jet #1
			.byte	RANDO_S_PELLET   ;Swooping Snitchbug
			.byte	RANDO_S_PELLET   ;Male Sheargrub
			.byte	RANDO_S_PELLET   ;Shearwig
			.byte	RANDO_UFOPART   ;Ionium Jet #2
			.byte	RANDO_UFOPART   ;Shock Absorber
			.byte	RANDO_UFOPART   ;Gravity Jumper
			.byte	RANDO_UFOPART   ;Pilot's Seat
			.byte	RANDO_UFOPART   ;Nova Blaster
			.byte	RANDO_UFOPART   ;Automatic Gear
			.byte	RANDO_UFOPART   ;Zirconium Rotor
			.byte	RANDO_UFOPART   ;Extraordinary Bolt
			.byte	RANDO_UFOPART   ;Repair-Type Bolt
			.byte	RANDO_UFOPART   ;Space Float
			.byte	RANDO_UFOPART   ;Massage Machine
			.byte	RANDO_UFOPART   ;Secret Safe
			.byte	RANDO_UFOPART   ;Positron Generator
			.byte	RANDO_UFOPART   ;Analog Computer
			.byte	RANDO_UFOPART   ;UV Lamp
			.byte	RANDO_S_PELLET   ;Water Dumple
			.byte	RANDO_S_PELLET   ;White Wollywog
			.byte	RANDO_L_PELLET   ;Spotty Bulbear
			.byte	RANDO_S_PELLET   ;White Pearl
			.byte	RANDO_S_PELLET   ;Resting Olimar
			.byte	RANDO_L_PELLET   ;Mamuta
			.byte	RANDO_S_PELLET   ;Dwarf Bulbear
			.byte	RANDO_S_PELLET   ;Gold Pearl
			.byte	RANDO_L_PELLET   ;Armored Cannon Beetle
			.byte	RANDO_S_PELLET   ;Wogpole
			.balign 4
		SKIP_pellet_id_table:
		mflr	pellet_id_table
		lwz	old_pellet_id, 0x0018 (old_GenObject)
		lbzx	rando_id, pellet_id_table, old_pellet_id
		lwz	r3, 0x0018 (old_GenObject)
		bl	FindNewUfoPart
		mr	curr_itempellet_id, r3
		b	RANDO_DISAMBIGUATION
		
	RANDO_DISAMBIGUATION:
		curr_table      = tempVar0
		curr_table_size = tempVar1
		
		DISAMBIGUATION_RANDO_LIMIT:
		cmpwi	rando_id, RANDO_LIMIT
		bne-	DISAMBIGUATION_RANDO_BASIC
			bl	SKIP_limit_table
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_BOSS
				.byte 0x03   ;chappy
				.byte 0x05   ;mizigen
				.byte 0x07   ;palm
				.byte 0x12   ;kabekuiA
				.byte 0x13   ;kabekuiB
				.byte 0x14   ;kabekuiC
				.byte 0x17   ;hibaA
				.byte 0x19   ;otama
				.byte 0x1E   ;namazu
				.byte 0x1F   ;chappb
				.byte 0x04   ;kogane
				.balign 4
			SKIP_limit_table:
			mflr	curr_table
			li	curr_table_size, 11
			b	MAKE
		DISAMBIGUATION_RANDO_BASIC:
		cmpwi	rando_id, RANDO_BASIC
		bne-	DISAMBIGUATION_RANDO_HARD
			bl	SKIP_basic_table
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_BOSS
				.byte GENOBJECT_BOSS
				.byte 0x00   ;frog
				.byte 0x04   ;swallow
				.byte 0x08   ;collec
				.byte 0x09   ;kinoko
				.byte 0x0B   ;napkid
				.byte 0x0F   ;tank
				.byte 0x10   ;mar
				.byte 0x11   ;beatle
				.byte 0x15   ;tamago
				.byte 0x18   ;miurin
				.byte 0x20   ;swallob
				.byte 0x21   ;frow
				.byte 0x05   ;pom
				.byte 0x01   ;snake (sphere)
				.balign 4
			SKIP_basic_table:
			mflr	curr_table
			li	curr_table_size, 14
			b	MAKE
		DISAMBIGUATION_RANDO_HARD:
		cmpwi	rando_id, RANDO_HARD
		bne-	DISAMBIGUATION_RANDO_GEYSER
			bl	SKIP_hard_table
				.byte GENOBJECT_BOSS
				.byte GENOBJECT_BOSS
				.byte GENOBJECT_BOSS
				.byte GENOBJECT_BOSS
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte GENOBJECT_TEKI
				.byte 0x00   ; kumo
				.byte 0x01   ; snake (sphere)
				.byte 0x02   ; slime
				.byte 0x03   ; king
				.byte 0x09   ; kinoko
				.byte 0x16   ; dororo
				.byte 0x18   ; miurin
				.balign 4
			SKIP_hard_table:
			mflr	curr_table
			li	curr_table_size, 7
			b	MAKE
		DISAMBIGUATION_RANDO_GEYSER:
		cmpwi	rando_id, RANDO_GEYSER
		bne-	DISAMBIGUATION_RANDO_DECOR
			bl	SKIP_geyser_table
				.byte 1   ;boss
				.byte 1   ;boss
				.byte 0x08   ;mizu (off)
				.byte 0x09   ;mizu (on)
			SKIP_geyser_table:
			mflr	curr_table
			li	curr_table_size, 2
			b	MAKE
		DISAMBIGUATION_RANDO_DECOR:
		cmpwi	rando_id, RANDO_DECOR
		bne-	DISAMBIGUATION_RANDO_DELETE
			bl	SKIP_decor_id_table
				.byte GENOBJECT_PLANT
				.byte GENOBJECT_PLANT
				.byte GENOBJECT_PLANT
				.byte GENOBJECT_PLANT
				.byte GENOBJECT_PLANT
				.byte GENOBJECT_PLANT
				.byte GENOBJECT_PLANT
				.byte GENOBJECT_PLANT
				.byte GENOBJECT_PLANT
				.byte GENOBJECT_PLANT
				.byte GENOBJECT_PLANT
				.byte GENOBJECT_TEKI
				.byte 0x00   ;clover
				.byte 0x01   ;chidome
				.byte 0x02   ;hutaba
				.byte 0x03   ;ine
				.byte 0x04   ;tanpopo
				.byte 0x05   ;ooinu_l
				.byte 0x06   ;ooinu_s
				.byte 0x07   ;mizikusa
				.byte 0x08   ;wakame_l
				.byte 0x09   ;wakame_s
				.byte 0x0A   ;kinokolt
				.byte 0x07   ;palm
				.balign 4
			SKIP_decor_id_table:
			mflr	curr_table
			li	curr_table_size, 12
			b	MAKE
		DISAMBIGUATION_RANDO_DELETE:
		cmpwi	rando_id, RANDO_DELETE
		bne-	DISAMBIGUATION_RANDO_S_PELLET
			li	new_GenObject, 0
			b	UPDATE
		DISAMBIGUATION_RANDO_S_PELLET:
		cmpwi	rando_id, RANDO_S_PELLET
		bne-	DISAMBIGUATION_RANDO_L_PELLET
			bl	SKIP_rando_s_pellet_id_table
				.byte GENOBJECT_PELLET
				.byte GENOBJECT_PELLET
				.byte GENOBJECT_PELLET
				.byte GENOBJECT_PELLET
				.byte GENOBJECT_PELLET
				.byte GENOBJECT_PELLET
				.byte 0x00   ;Blue 1 Pellet
				.byte 0x01   ;Blue 5 Pellet
				.byte 0x04   ;Red 1 Pellet
				.byte 0x05   ;Red 5 Pellet
				.byte 0x08   ;Yellow 1 Pellet
				.byte 0x09   ;Yellow 5 Pellet
				.balign 4
			SKIP_rando_s_pellet_id_table:
			mflr	curr_table
			li	curr_table_size, 6
			b	MAKE
		DISAMBIGUATION_RANDO_L_PELLET:
		cmpwi	rando_id, RANDO_L_PELLET
		bne-	DISAMBIGUATION_RANDO_UFOPART
			bl	SKIP_rando_l_pellet_id_table
				.byte GENOBJECT_PELLET
				.byte GENOBJECT_PELLET
				.byte GENOBJECT_PELLET
				.byte GENOBJECT_PELLET
				.byte GENOBJECT_PELLET
				.byte GENOBJECT_PELLET
				.byte 0x02   ;Blue 10 Pellet
				.byte 0x03   ;Blue 20 Pellet
				.byte 0x06   ;Red 10 Pellet
				.byte 0x07   ;Red 20 Pellet
				.byte 0x0A   ;Yellow 10 Pellet
				.byte 0x0B   ;Yellow 20 Pellet
				.balign 4
			SKIP_rando_l_pellet_id_table:
			mflr	curr_table
			li	curr_table_size, 6
			b	MAKE
		DISAMBIGUATION_RANDO_UFOPART:
		cmpwi	rando_id, RANDO_UFOPART
		bne-	DISAMBIGUATION_9
			b	MAKE_INTO_UFOPART
		DISAMBIGUATION_9:
		b	UPDATE
	

	MAKE:
		new_type = tempVar2
		new_id   = tempVar3
		curr_can_carry_table = tempVar0
		can_carry            = tempVar1
		
		subi	r3, curr_table_size, 1
		lis	r12,      randomInt__7NSystemFi@h
		ori	r12, r12, randomInt__7NSystemFi@l
		mtctr	r12
		bctrl	;-->[randomInt__7NSystemFi]
		lbzx	new_type, curr_table, r3
		add	curr_table, curr_table, curr_table_size
		lbzx	new_id, curr_table, r3
		
		cmpwi	new_type, GENOBJECT_TEKI
		beq-	MAKE_INTO_TEKI
		cmpwi	new_type, GENOBJECT_BOSS
		beq-	MAKE_INTO_BOSS
		cmpwi	new_type, GENOBJECT_PLANT
		beq-	MAKE_INTO_PLANT
		cmpwi	new_type, GENOBJECT_PELLET
		beq-	MAKE_INTO_PELLET
		b	UPDATE
		

	MAKE_INTO_TEKI:
		bl	SKIP_teki_can_carry_table
			.byte 1   ;00 frog      Yellow Wollywog
			.byte 0   ;01 iwagen    Iwagen
			.byte 0   ;02 iwagon    Rolling Boulder
			.byte 1   ;03 chappy    Dwarf Bulborb
			.byte 1   ;04 swallow   Spotty Bulborb
			.byte 0   ;05 mizigen   Honeywisps Generator
			.byte 0   ;06 qurione   Lone Honeywisp (invalid)
			.byte 1   ;07 palm      Pellet Posy
			.byte 1   ;08 collec    Breadbug
			.byte 1   ;09 kinoko    Puffstool
			.byte 1   ;0A shell     Pearly Clamclamp
			.byte 1   ;0B napkid    Snitchbug
			.byte 0   ;0C hollec    Breadbug Nest
			.byte 1   ;0D pearl     Lone Pearl (invalid)
			.byte 1   ;0E rocpe     Lone Rocket Pearl (invalid)
			.byte 1   ;0F tank      Fiery Blowhog
			.byte 1   ;10 mar       Puffy Blowhog
			.byte 1   ;11 beatle    Armored Cannon Beetle
			.byte 1   ;12 kabekuiA  Female Sheargrub
			.byte 1   ;13 kabekuiB  Male Sheargrub
			.byte 1   ;14 kabekuiC  Shearwig
			.byte 0   ;15 tamago    Giant Egg
			.byte 1   ;16 dororo    Smoky Progg
			.byte 0   ;17 hibaA     Fire Geyser
			.byte 1   ;18 miurin    Mamuta
			.byte 1   ;19 otama     Wogpole
			.byte 0   ;1A usuba     Usuba (invalid)
			.byte 0   ;1B yamash3   (invalid)
			.byte 0   ;1C yamash4   (invalid)
			.byte 0   ;1D yamash5   (invalid)
			.byte 1   ;1E namazu    Water Dumple
			.byte 1   ;1F chappb    Dwarf Bulbear
			.byte 1   ;20 swallob   Spotty Bulbear
			.byte 1   ;21 frow      White Wollywog
			.byte 0   ;22 nakata1   (invalid)
			.balign 4
		SKIP_teki_can_carry_table:
		mflr	curr_can_carry_table
		lbzx	can_carry, curr_can_carry_table, new_id
		cmpwi	curr_itempellet_id, -1
		beq-	0x000C
		cmpwi	can_carry, 0
		beq-	RANDO_DISAMBIGUATION
		
		Iparameters = tempVar0
		Fparameters = tempVar1
		personality = tempVar2
		lis	r12,      makeObjectTeki__Fv@h
		ori	r12, r12, makeObjectTeki__Fv@l
		mtctr	r12
		bctrl	;-->[makeObjectTeki__Fv]
		mr	new_GenObject, r3
		
		lwz	personality, 0x0018 (new_GenObject)
		lwz	Fparameters, 0x0034 (personality)
		lwz	Iparameters, 0x0000 (Fparameters)
		lwz	Iparameters, 0x0000 (Iparameters)
		lwz	Fparameters, 0x0004 (Fparameters)
		lwz	Fparameters, 0x0000 (Fparameters)
		
		lwz	r3, pelletMgr (r13)
		mr	r4, curr_itempellet_id
		lis	r12,      getConfigFromIdx__9PelletMgrFi@h
		ori	r12, r12, getConfigFromIdx__9PelletMgrFi@l
		mtctr	r12
		bctrl	;-->[getConfigFromIdx__9PelletMgrFi]
		cmpwi	r3, 0   ;function returns nullptr for index -1
		lis	r4,     none@h
		ori	r4, r4, none@l
		beq	0x0008   ;Don't try dereferencing a nullptr
		lwz	r4, 0x0030 (r3)
		
		stw	new_id, 0x001C (new_GenObject)   ;Write Teki ID
		stw	r4, 0x0028 (personality)         ;Write item pellet
		stw	r4, 0x002C (personality)         ;Write item pellet
		b	UPDATE
	MAKE_INTO_BOSS:
		bl	SKIP_boss_can_carry_table
			.byte 1   ;00 kumo
			.byte 1   ;01 snake (sphere)
			.byte 1   ;02 slime
			.byte 1   ;03 king
			.byte 0   ;04 kogane
			.byte 0   ;05 pom
			.byte 0   ;06 kingback
			.byte 1   ;07 snake (prism)
			.byte 0   ;08 mizu (off)
			.byte 0   ;09 mizu (on)
			.balign 4
		SKIP_boss_can_carry_table:
		mflr	curr_can_carry_table
		lbzx	can_carry, curr_can_carry_table, new_id
		cmpwi	curr_itempellet_id, -1
		beq-	0x000C
		cmpwi	can_carry, 0
		beq-	RANDO_DISAMBIGUATION
		
		bl	SKIP_constructBoss_table
			.byte 0    ;(0) Spider
			.byte 1    ;(1) Snake
			.byte 2    ;(2) Slime
			.byte 3    ;(3) King
			.byte 4    ;(4) Kogane
			.byte 5    ;(5) Pom
			.byte 6    ;(6) Kingback
			.byte 9    ;(7) TwSnake
			.byte 10   ;(8) Mizu
			.byte 11   ;(9) Mizu
			.balign 4
		SKIP_constructBoss_table:
		mflr	r4
		lwz	r3, bossMgr (r13)   ;load static bossMgr*
		lbzx	r4, r4, new_id      ;Translate GenObjectBoss ID into constructBoss ID
		li	r5, 1               ;Construct exactly one
		lis	r12,      init__7BossMgrFii@h
		ori	r12, r12, init__7BossMgrFii@l
		mtctr	r12
		bctrl	;-->[init__7BossMgrFii]
		
		lis	r12,      makeObjectBoss__Fv@h
		ori	r12, r12, makeObjectBoss__Fv@l
		mtctr	r12
		bctrl	;-->[makeObjectBoss__Fv]
		mr	new_GenObject, r3
		
		stw	new_id, 0x0018 (new_GenObject)
		stw	curr_itempellet_id, 0x0028 (new_GenObject)
		b	UPDATE
	MAKE_INTO_PLANT:
		cmpwi	curr_itempellet_id, -1
		bne-	RANDO_DISAMBIGUATION
		lis	r12,      makeObjectPlant__Fv@h
		ori	r12, r12, makeObjectPlant__Fv@l
		mtctr	r12
		bctrl	;-->[makeObjectPlant__Fv]
		mr	new_GenObject, r3
		
		stw	new_id, 0x0018 (new_GenObject)
		b	UPDATE
	MAKE_INTO_PELLET:
		lis	r12,      makeObjectPellet__Fv@h
		ori	r12, r12, makeObjectPellet__Fv@l
		mtctr	r12
		bctrl	;-->[makeObjectPellet__Fv]
		mr	new_GenObject, r3
		
		lwz	r3, pelletMgr (r13)
		mr	r4, new_id
		lis	r12,      getConfigFromIdx__9PelletMgrFi@h
		ori	r12, r12, getConfigFromIdx__9PelletMgrFi@l
		mtctr	r12
		bctrl	;-->[getConfigFromIdx__9PelletMgrFi]
		lwz	r3, 0x0030 (r3)
		
		stw	new_id, 0x0018 (new_GenObject)
		stw	r3, 0x001C (new_GenObject)
		stw	r3, 0x0020 (new_GenObject)
		b	UPDATE
	MAKE_INTO_UFOPART:
		lis	r12,      makeObjectPellet__Fv@h
		ori	r12, r12, makeObjectPellet__Fv@l
		mtctr	r12
		bctrl	;-->[makeObjectPellet__Fv]
		mr	new_GenObject, r3
		
		lwz	r3, pelletMgr (r13)
		mr	r4, curr_itempellet_id
		lis	r12,      getConfigFromIdx__9PelletMgrFi@h
		ori	r12, r12, getConfigFromIdx__9PelletMgrFi@l
		mtctr	r12
		bctrl	;-->[getConfigFromIdx__9PelletMgrFi]
		lwz	r3, 0x0030 (r3)
		
		stw	curr_itempellet_id, 0x0018 (new_GenObject)
		stw	r3, 0x001C (new_GenObject)
		stw	r3, 0x0020 (new_GenObject)
		b	UPDATE
		
	UPDATE:
		stw	new_GenObject, 0x0030 (current_generator)

EPILOGUE:
	lmw	gpr_save, 0x0008 (sp)
	lwz	sp, 0x0000 (sp)
	lwz	r0, 0x0004 (sp)
	mtlr	r0
	blr


FOOTER:;=======================================================
mflr	r3
stw	r3, 0x0050 (r31)
mtlr	r0
blr
;==============================================================


;--------------------------------------------------------------
FindNewUfoPart:
;	SUB0_PROLOGUE:
;		mflr	r0
;		stw	r0, 0x0004 (sp)
;		stwu	sp, -0x0008 (sp)
	
	SUB0_BODY:
		cmpwi	r3, -1     ;Is there no pellet at all?
		ble-	SUB0_FUCK_OFF
		cmpwi	r3, 0x12   ;Is this a number pellet or some stupid corpse?
		ble-	SUB0_FUCK_OFF
		cmpwi	r3, 0x34   ;Is this some other stupid corpse?
		bge-	SUB0_FUCK_OFF
		cmpwi	r3, 0x22   ;There's a special place in hell for you three
		beq-	SUB0_FUCK_OFF
		cmpwi	r3, 0x23   ;There's a special place in hell for you three
		beq-	SUB0_FUCK_OFF
		cmpwi	r3, 0x24   ;There's a special place in hell for you three
		beq-	SUB0_FUCK_OFF
		
		blt-	0x0008   ;While we still have the comparison against 0x24
		subi	r3, r3, 0x03   ; Cut out those three in the middle
		subi	r3, r3, 0x13   ; Convert Pellet ID to "UFO Part ID"
		
		lwz	r4, playerState (r13)
		lwz	r4, 0x01CC (r4)
		lbzx	r3, r4, r3
		
		addi	r3, r3, 0x13   ;Add 19 to reach the start of ufoparts in pelMgr
		cmpwi	r3, 0x21       ;After index 0x21 of pelMgr, 3 unrelated corpses appear
		ble-	0x0008         ;Need to skip those if the current index is > 33
		addi	r3, r3, 0x03   ;Add 3 to skip some corpses in the middle of the list
		
		SUB0_FUCK_OFF:

;	SUB_EPILOGUE:
;		lwz	sp, 0x0000 (sp)
;		lwz	r0, 0x0004 (sp)
;		mtlr	r0
		blr
;--------------------------------------------------------------





