#To be inserted at 800dcaf4
;╔════════════════════════════════════════════════════════════╗
;║ Randomizer Core                                 Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
;---STACK------------------------------------------------------

;---Compiler Constants-----------------------------------------
gpr_save = 20
iVar0 = 31
iVar1 = 30
iVar2 = 29
iVar3 = 28
iVar4 = 27
iVar5 = 26
iVar6 = 25
iVar7 = 24
iVar8 = 23
iVar9 = 22
iVar10 = 21
iVar11 = 20
;---Function Pointers------------------------------------------
makeObjectPlant__Fv            = 0x8011accc
makeObjectTeki__Fv             = 0x8011b2cc
makeObjectBoss__Fv             = 0x8014d2d0
makeObjectPellet__Fv           = 0x80099d1c
makeObjectPiki__Fv             = 0x800dad34
makeObjectItem__Fv             = 0x800ee470
makeObjectWorkObject__Fv       = 0x8009b7c4
create__19Factory9GenObjectFUl = 0x800dcbe8
randomInt__7NSystemFi          = 0x8011e8a4
rand                           = 0x80218070
init__7BossMgrFii              = 0x80150f24
getConfigFromIdx__9PelletMgrFi = 0x80098c88
getConfigIndex__9PelletMgrFUl  = 0x80098c48
isUfoPartsID__6PelletFUl       = 0x800953ac
alloc__6SystemFUl              = 0x80047004


r13 = 0x803e4d20
tekiMgr                     = 0x3160
bossMgr                     = 0x3168
pelletMgr                   = 0x301C
current_stage               = -0x7F1C
playerState                 = 0x2F6C
factory__16GenObjectFactory = 0x3074
;---Constants--------------------------------------------------
GENOBJECT_PIKI = 0x0000
GENOBJECT_DEBG = 0x0010
GENOBJECT_ITEM = 0x0020
GENOBJECT_PELT = 0x0030
GENOBJECT_WORK = 0x0040
GENOBJECT_PLNT = 0x0050
GENOBJECT_MPAR = 0x0060
GENOBJECT_TEKI = 0x0070
GENOBJECT_BOSS = 0x0080
GENOBJECT_MOBJ = 0x0090
GENOBJECT_NAVI = 0x00A0
GENOBJECT_ACTR = 0x00B0

RANDO_LIMIT   = 0
RANDO_BASIC   = 1
RANDO_HARD    = 2
RANDO_GEYSER  = 3
RANDO_DECOR   = 4
RANDO_DELETE  = 5
RANDO_S_PELLET = 6
RANDO_L_PELLET = 7
RANDO_UFOPART  = 8
RANDO_UNCHANGED = 9

none = 0x6E6F6E65
;---Macros-----------------------------------------------------
.macro	call	addr
lis	r12,      \addr@h
ori	r12, r12, \addr@l
mtlr	r12
blrl
.endm

.macro	lfsi	fprD, val
bl	0x0008
.float	\val
mflr	r12
lfs	\fprD, 0x0000 (r12)
.endm
;--------------------------------------------------------------



EXPOSITION:
	mr	r3, r30

PROLOGUE:
;	mflr	r0
;	stw	r0, 0x0004 (sp)
	stwu	sp, -( 0x0008 + ( ( 32 - gpr_save ) * 4 ) ) (sp)
	stmw	gpr_save, 0x0008 (sp)

BODY:
	curr_generator     = iVar0 ;perm
	rando_id           = iVar1 ;perm
	curr_itempellet_id = iVar2 ;perm
	old_GenObject      = iVar3
	old_GenObject_type = iVar4
	GenObject_id_table = iVar5
	type_from_table    = iVar6
	
	mr	curr_generator, r3
	lwz	old_GenObject, 0x0030 (curr_generator)
	li	rando_id, RANDO_UNCHANGED
	li	curr_itempellet_id, -1
	
	;Nullptr check because Distant Spring is weird
	cmpwi	old_GenObject, 0
	beq-	PREDETERMINE
	
	;0x0000 - piki
	;0x0010 - debg
	;0x0020 - item
	;0x0030 - pelt
	;0x0040 - work
	;0x0050 - plnt
	;0x0060 - mpar
	;0x0070 - teki
	;0x0080 - boss
	;0x0090 - mobj
	;0x00A0 - navi
	;0x00B0 - actr
	lwz	GenObject_id_table, factory__16GenObjectFactory (r13)
	lwz	GenObject_id_table, 0x0008 (GenObject_id_table)
	
	lwz	old_GenObject_type, 0x0008 (old_GenObject)
	
	lwz	type_from_table, GENOBJECT_PIKI (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_PIKI
	lwz	type_from_table, GENOBJECT_DEBG (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_DEBUG
	lwz	type_from_table, GENOBJECT_ITEM (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_ITEM
	lwz	type_from_table, GENOBJECT_PELT (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_PELLET
	lwz	type_from_table, GENOBJECT_WORK (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_WORK
	lwz	type_from_table, GENOBJECT_PLNT (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_PLANT
	lwz	type_from_table, GENOBJECT_MPAR (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_MAPPART
	lwz	type_from_table, GENOBJECT_TEKI (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_TEKI
	lwz	type_from_table, GENOBJECT_BOSS (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_BOSS
	lwz	type_from_table, GENOBJECT_MOBJ (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_MAPOBJ
	lwz	type_from_table, GENOBJECT_NAVI (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_NAVI
	lwz	type_from_table, GENOBJECT_ACTR (GenObject_id_table)
	cmpw	old_GenObject_type, type_from_table
	beq-	IS_ACTOR
	b	PREDETERMINE
	
	
	IS_PIKI:
		b	PREDETERMINE
	
	IS_DEBUG:
		b	PREDETERMINE
	
	IS_ITEM:
		b	PREDETERMINE
	
	IS_PELLET:
		pellet_id_table = iVar4
		old_pellet_id   = iVar5   ;unused
		
		bl	TABLE_pellet_id
			.byte	RANDO_S_PELLET    ;Blue 1 Pellet
			.byte	RANDO_S_PELLET    ;Blue 5 Pellet
			.byte	RANDO_L_PELLET    ;Blue 10 Pellet
			.byte	RANDO_L_PELLET    ;Blue 20 Pellet
			.byte	RANDO_S_PELLET    ;Red 1 Pellet
			.byte	RANDO_S_PELLET    ;Red 5 Pellet
			.byte	RANDO_L_PELLET    ;Red 10 Pellet
			.byte	RANDO_L_PELLET    ;Red 20 Pellet
			.byte	RANDO_S_PELLET    ;Yellow 1 Pellet
			.byte	RANDO_S_PELLET    ;Yellow 5 Pellet
			.byte	RANDO_L_PELLET    ;Yellow 10 Pellet
			.byte	RANDO_L_PELLET    ;Yellow 20 Pellet
			.byte	RANDO_UNCHANGED   ;Spotty Bulborb
			.byte	RANDO_UNCHANGED   ;Dwarf Bulborb
			.byte	RANDO_UNCHANGED   ;Yellow Wollywog
			.byte	RANDO_UNCHANGED   ;Puffstool
			.byte	RANDO_UNCHANGED   ;Breadbug
			.byte	RANDO_UNCHANGED   ;Fiery Blowhog
			.byte	RANDO_UNCHANGED   ;Female Sheargrub
			.byte	RANDO_UFOPART    ;Bowspirit
			.byte	RANDO_UFOPART    ;Gluon Drive
			.byte	RANDO_UFOPART    ;Anti-Dioxin Filter
			.byte	RANDO_UFOPART    ;Eternal Fuel Dynamo
			.byte	RANDO_UFOPART    ;Main Engine
			.byte	RANDO_UFOPART    ;Whimsical Radar
			.byte	RANDO_UFOPART    ;Interstellar Radio
			.byte	RANDO_UFOPART    ;Guard Satellite
			.byte	RANDO_UFOPART    ;Chronos Reactor
			.byte	RANDO_UFOPART    ;Radiation Canopy
			.byte	RANDO_UFOPART    ;Geiger Counter
			.byte	RANDO_UFOPART    ;Sagittarius
			.byte	RANDO_UFOPART    ;Libra
			.byte	RANDO_UFOPART    ;Omega Stabilizer
			.byte	RANDO_UFOPART    ;Ionium Jet #1
			.byte	RANDO_UNCHANGED   ;Swooping Snitchbug
			.byte	RANDO_UNCHANGED   ;Male Sheargrub
			.byte	RANDO_UNCHANGED   ;Shearwig
			.byte	RANDO_UFOPART    ;Ionium Jet #2
			.byte	RANDO_UFOPART    ;Shock Absorber
			.byte	RANDO_UFOPART    ;Gravity Jumper
			.byte	RANDO_UFOPART    ;Pilot's Seat
			.byte	RANDO_UFOPART    ;Nova Blaster
			.byte	RANDO_UFOPART    ;Automatic Gear
			.byte	RANDO_UFOPART    ;Zirconium Rotor
			.byte	RANDO_UFOPART    ;Extraordinary Bolt
			.byte	RANDO_UFOPART    ;Repair-Type Bolt
			.byte	RANDO_UFOPART    ;Space Float
			.byte	RANDO_UFOPART    ;Massage Machine
			.byte	RANDO_UFOPART    ;Secret Safe
			.byte	RANDO_UFOPART    ;Positron Generator
			.byte	RANDO_UFOPART    ;Analog Computer
			.byte	RANDO_UFOPART    ;UV Lamp
			.byte	RANDO_UNCHANGED   ;Water Dumple
			.byte	RANDO_UNCHANGED   ;White Wollywog
			.byte	RANDO_UNCHANGED   ;Spotty Bulbear
			.byte	RANDO_UNCHANGED   ;White Pearl
			.byte	RANDO_UNCHANGED   ;Resting Olimar
			.byte	RANDO_UNCHANGED   ;Mamuta
			.byte	RANDO_UNCHANGED   ;Dwarf Bulbear
			.byte	RANDO_UNCHANGED   ;Gold Pearl
			.byte	RANDO_UNCHANGED   ;Armored Cannon Beetle
			.byte	RANDO_UNCHANGED   ;Wogpole
			.balign 4
		TABLE_pellet_id:
		mflr	pellet_id_table
		lwz	curr_itempellet_id, 0x0018 (old_GenObject)
		lbzx	rando_id, pellet_id_table, curr_itempellet_id
		b	PREDETERMINE
	
	IS_WORK:
		b	PREDETERMINE
	
	IS_PLANT:
		plant_id_table = iVar4
		old_plant_id   = iVar5
		
		bl	TABLE_plant_id
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
		TABLE_plant_id:
		mflr	plant_id_table
		lwz	old_plant_id, 0x0018 (old_GenObject)
		lbzx	rando_id, plant_id_table, old_plant_id
		b	PREDETERMINE
	
	IS_MAPPART:
		b	PREDETERMINE
		
	IS_TEKI:
		teki_id_table = iVar4
		old_teki_id   = iVar5
		
		bl	TABLE_teki_id
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
		TABLE_teki_id:
		mflr	teki_id_table
		lwz	old_teki_id, 0x001C (old_GenObject)
		lbzx	rando_id, teki_id_table, old_teki_id
		
		lwz	curr_itempellet_id, 0x0018 (old_GenObject)   ;TekiPersonality*
		lwz	curr_itempellet_id, 0x0028 (curr_itempellet_id)
		lwz	r3, pelletMgr (r13)
		mr	r4, curr_itempellet_id
		call	getConfigIndex__9PelletMgrFUl
		mr	curr_itempellet_id, r3
		b	PREDETERMINE
		
	IS_BOSS:
		boss_id_table      = iVar4
		old_boss_id        = iVar5
		
		bl	TABLE_boss_id
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
		TABLE_boss_id:
		mflr	boss_id_table
		lwz	old_boss_id, 0x0018 (old_GenObject)
		lbzx	rando_id, boss_id_table, old_boss_id
		lwz	curr_itempellet_id, 0x0028 (old_GenObject)
		b	PREDETERMINE
		
	IS_MAPOBJ:
		b	PREDETERMINE
		
	IS_NAVI:
		b	PREDETERMINE
		
	IS_ACTOR:
		b	PREDETERMINE
	
	
	PREDETERMINE:
	max_count          = iVar3
	output_list        = iVar4
	
	lwz	r3, 0x0028 (curr_generator)   ;curr_GenType
	lwz	r12, 0x0004 (r3)              ;__vt__
	lwz	r12, 0x0034 (r12)             ;[getMaxCount] of curr_GenType
	mtlr	r12
	blrl	;-->[getMaxCount] of curr_GenType
	mr	max_count, r3
	
	mulli	r3, max_count, 4
	call	alloc__6SystemFUl
	mr	output_list, r3
	stw	output_list, 0x0034 (curr_generator)
	
	ufopart_id_table     = iVar5
	new_ufoparts_id      = iVar6
	rando_ufoparts_array = iVar7
	
	cmpwi	curr_itempellet_id, -1     ;Is there no pellet at all?
	ble-	FUCK_OFF
	bl	TABLE_ufopart_id
		.byte	-1    ;Blue 1 Pellet
		.byte	-1    ;Blue 5 Pellet
		.byte	-1    ;Blue 10 Pellet
		.byte	-1    ;Blue 20 Pellet
		.byte	-1    ;Red 1 Pellet
		.byte	-1    ;Red 5 Pellet
		.byte	-1    ;Red 10 Pellet
		.byte	-1    ;Red 20 Pellet
		.byte	-1    ;Yellow 1 Pellet
		.byte	-1    ;Yellow 5 Pellet
		.byte	-1    ;Yellow 10 Pellet
		.byte	-1    ;Yellow 20 Pellet
		.byte	-1   ;Spotty Bulborb
		.byte	-1   ;Dwarf Bulborb
		.byte	-1   ;Yellow Wollywog
		.byte	-1   ;Puffstool
		.byte	-1   ;Breadbug
		.byte	-1   ;Fiery Blowhog
		.byte	-1   ;Female Sheargrub
		.byte	0    ;Bowspirit
		.byte	1    ;Gluon Drive
		.byte	2    ;Anti-Dioxin Filter
		.byte	3    ;Eternal Fuel Dynamo
		.byte	4    ;Main Engine
		.byte	5    ;Whimsical Radar
		.byte	6    ;Interstellar Radio
		.byte	7    ;Guard Satellite
		.byte	8    ;Chronos Reactor
		.byte	9    ;Radiation Canopy
		.byte	10    ;Geiger Counter
		.byte	11    ;Sagittarius
		.byte	12    ;Libra
		.byte	13    ;Omega Stabilizer
		.byte	14    ;Ionium Jet #1
		.byte	-1   ;Swooping Snitchbug
		.byte	-1   ;Male Sheargrub
		.byte	-1   ;Shearwig
		.byte	15    ;Ionium Jet #2
		.byte	16    ;Shock Absorber
		.byte	17    ;Gravity Jumper
		.byte	18    ;Pilot's Seat
		.byte	19    ;Nova Blaster
		.byte	20    ;Automatic Gear
		.byte	21    ;Zirconium Rotor
		.byte	22    ;Extraordinary Bolt
		.byte	23    ;Repair-Type Bolt
		.byte	24    ;Space Float
		.byte	25    ;Massage Machine
		.byte	26    ;Secret Safe
		.byte	27    ;Positron Generator
		.byte	28    ;Analog Computer
		.byte	29    ;UV Lamp
		.byte	-1   ;Water Dumple
		.byte	-1   ;White Wollywog
		.byte	-1   ;Spotty Bulbear
		.byte	-1   ;White Pearl
		.byte	-1   ;Resting Olimar
		.byte	-1   ;Mamuta
		.byte	-1   ;Dwarf Bulbear
		.byte	-1   ;Gold Pearl
		.byte	-1   ;Armored Cannon Beetle
		.byte	-1   ;Wogpole
		.balign 4
	TABLE_ufopart_id:
	mflr	ufopart_id_table
	lbzx	new_ufoparts_id, ufopart_id_table, curr_itempellet_id
	cmpwi	new_ufoparts_id, -1   ;Is this not a ufopart?
	beq-	FUCK_OFF
	lwz	rando_ufoparts_array, playerState (r13)
	lwz	rando_ufoparts_array, 0x01CC (rando_ufoparts_array)
	lbzx	curr_itempellet_id, rando_ufoparts_array, new_ufoparts_id
	addi	curr_itempellet_id, curr_itempellet_id, 0x13   ;Add 19 to reach the start of ufoparts in pelMgr

	cmpwi	curr_itempellet_id, 0x21                       ;After index 0x21 of pelMgr, 3 unrelated corpses appear

	ble-	0x0008                                         ;Need to skip those if the current index is > 33

	addi	curr_itempellet_id, curr_itempellet_id, 0x03   ;Add 3 to skip some corpses in the middle of the list

	FUCK_OFF:
	
	loop_count      = iVar5
	curr_GenObject  = iVar6
	new_type        = iVar7
	new_id          = iVar8
	curr_table      = iVar9
	curr_table_size = iVar10
	li	loop_count, 0
	PREDETERMINE_LOOP:
		cmpw	loop_count, max_count
		bge-	PREDETERMINE_LOOP_DONE
		
		RANDO_DISAMBIGUATION:
		
		cmpwi	rando_id, RANDO_LIMIT
		beq-	DISAMBIGUATION_RANDO_LIMIT
		cmpwi	rando_id, RANDO_BASIC
		beq-	DISAMBIGUATION_RANDO_BASIC
		cmpwi	rando_id, RANDO_HARD
		beq-	DISAMBIGUATION_RANDO_HARD
		cmpwi	rando_id, RANDO_GEYSER
		beq-	DISAMBIGUATION_RANDO_GEYSER
		cmpwi	rando_id, RANDO_DECOR
		beq-	DISAMBIGUATION_RANDO_DECOR
		cmpwi	rando_id, RANDO_DELETE
		beq-	DISAMBIGUATION_RANDO_DELETE
		cmpwi	rando_id, RANDO_S_PELLET
		beq-	DISAMBIGUATION_RANDO_S_PELLET
		cmpwi	rando_id, RANDO_L_PELLET
		beq-	DISAMBIGUATION_RANDO_L_PELLET
		cmpwi	rando_id, RANDO_UFOPART
		beq-	DISAMBIGUATION_RANDO_UFOPART
		cmpwi	rando_id, RANDO_UNCHANGED
		beq-	DISAMBIGUATION_RANDO_UNCHANGED
		b	DISAMBIGUATION_10
		
		DISAMBIGUATION_RANDO_LIMIT:
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
			bl	SKIP_decor_id_table
				.byte GENOBJECT_PLNT
				.byte GENOBJECT_PLNT
				.byte GENOBJECT_PLNT
				.byte GENOBJECT_PLNT
				.byte GENOBJECT_PLNT
				.byte GENOBJECT_PLNT
				.byte GENOBJECT_PLNT
				.byte GENOBJECT_PLNT
				.byte GENOBJECT_PLNT
				.byte GENOBJECT_PLNT
				.byte GENOBJECT_PLNT
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
			li	curr_GenObject, 0
			b	DETERMINED
		DISAMBIGUATION_RANDO_S_PELLET:
			bl	SKIP_rando_s_pellet_id_table
				.byte GENOBJECT_PELT
				.byte GENOBJECT_PELT
				.byte GENOBJECT_PELT
				.byte GENOBJECT_PELT
				.byte GENOBJECT_PELT
				.byte GENOBJECT_PELT
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
			bl	SKIP_rando_l_pellet_id_table
				.byte GENOBJECT_PELT
				.byte GENOBJECT_PELT
				.byte GENOBJECT_PELT
				.byte GENOBJECT_PELT
				.byte GENOBJECT_PELT
				.byte GENOBJECT_PELT
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
			bl	TABLE_rando_ufopart_id
				.byte GENOBJECT_PELT
				.byte 0   ;This get's overwritten at runtime
				.balign 4
			TABLE_rando_ufopart_id:
			mflr	curr_table
			li	curr_table_size, 1
			stb	curr_itempellet_id, 0x0001 (curr_table)
			b	MAKE
		DISAMBIGUATION_RANDO_UNCHANGED:
			b	MAKE_UNCHANGED
		DISAMBIGUATION_10:
			b	0
		
		MAKE:
			subi	r3, curr_table_size, 1
			call	randomInt__7NSystemFi
			lbzx	new_type, curr_table, r3
			add	curr_table, curr_table, curr_table_size
			lbzx	new_id, curr_table, r3
			
			lwz	r3, factory__16GenObjectFactory (r13)
			lwz	r4, 0x0008 (r3)
			lwzx	r4, r4, new_type
			call	create__19Factory9GenObjectFUl
			mr	curr_GenObject, r3
			
			cmpwi	new_type, GENOBJECT_PIKI
			beq-	MAKE_INTO_PIKI
			cmpwi	new_type, GENOBJECT_DEBG
			beq-	MAKE_INTO_DEBUG
			cmpwi	new_type, GENOBJECT_ITEM
			beq-	MAKE_INTO_ITEM
			cmpwi	new_type, GENOBJECT_PELT
			beq-	MAKE_INTO_PELLET
			cmpwi	new_type, GENOBJECT_WORK
			beq-	MAKE_INTO_WORK
			cmpwi	new_type, GENOBJECT_PLNT
			beq-	MAKE_INTO_PLANT
			cmpwi	new_type, GENOBJECT_MPAR
			beq-	MAKE_INTO_MAPPART
			cmpwi	new_type, GENOBJECT_TEKI
			beq-	MAKE_INTO_TEKI
			cmpwi	new_type, GENOBJECT_BOSS
			beq-	MAKE_INTO_BOSS
			cmpwi	new_type, GENOBJECT_MOBJ
			beq-	MAKE_INTO_MAPOBJ
			cmpwi	new_type, GENOBJECT_NAVI
			beq-	MAKE_INTO_NAVI
			cmpwi	new_type, GENOBJECT_ACTR
			beq-	MAKE_INTO_ACTOR
			
			MAKE_UNCHANGED:
				lwz	r0, 0x0030 (curr_generator)
				mr	curr_GenObject, r0
				b	DETERMINED
			
			MAKE_INTO_PIKI:
				b	0
			
			MAKE_INTO_DEBUG:
				b	0
			
			MAKE_INTO_ITEM:
				b	0
			
			MAKE_INTO_PELLET:
				lwz	r3, pelletMgr (r13)
				mr	r4, new_id
				call	getConfigFromIdx__9PelletMgrFi
				lwz	r3, 0x0030 (r3)
				
				stw	new_id, 0x0018 (curr_GenObject)
				stw	r3, 0x001C (curr_GenObject)
				stw	r3, 0x0020 (curr_GenObject)
				b	DETERMINED
			
			MAKE_INTO_WORK:
				b	0
			
			MAKE_INTO_PLANT:
				cmpwi	curr_itempellet_id, -1
				bne-	RANDO_DISAMBIGUATION
				
				stw	new_id, 0x0018 (curr_GenObject)
				b	DETERMINED
			
			MAKE_INTO_MAPPART:
				b	0
			
			MAKE_INTO_TEKI:
				can_carry_teki_table = iVar9
				can_carry_teki       = iVar9
				cmpwi	curr_itempellet_id, -1
				beq-	TEKI_NOT_CARRYING
				bl	TABLE_can_carry_teki
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
				TABLE_can_carry_teki:
				mflr	can_carry_teki_table
				lbzx	can_carry_teki, can_carry_teki_table, new_id
				cmpwi	can_carry_teki, 0
				beq-	RANDO_DISAMBIGUATION
				TEKI_NOT_CARRYING:
				
				i_para = iVar9
				lwz	i_para, 0x0018 (curr_GenObject)
				lwz	i_para, 0x0034 (i_para)
				lwz	i_para, 0x0000 (i_para)
				lwz	i_para, 0x0000 (i_para)
				
				max_number_pellet_teki_table = iVar10
				max_number_pellet_teki       = iVar10
				bl	TABLE_max_number_pellet_count_teki
					.byte 2   ;00 frog      Yellow Wollywog
					.byte 0   ;01 iwagen    Iwagen
					.byte 0   ;02 iwagon    Rolling Boulder
					.byte 1   ;03 chappy    Dwarf Bulborb
					.byte 3   ;04 swallow   Spotty Bulborb
					.byte 0   ;05 mizigen   Honeywisps Generator
					.byte 0   ;06 qurione   Lone Honeywisp (invalid)
					.byte 1   ;07 palm      Pellet Posy
					.byte 2   ;08 collec    Breadbug
					.byte 3   ;09 kinoko    Puffstool
					.byte 0   ;0A shell     Pearly Clamclamp
					.byte 2   ;0B napkid    Snitchbug
					.byte 0   ;0C hollec    Breadbug Nest
					.byte 0   ;0D pearl     Lone Pearl (invalid)
					.byte 0   ;0E rocpe     Lone Rocket Pearl (invalid)
					.byte 3   ;0F tank      Fiery Blowhog
					.byte 3   ;10 mar       Puffy Blowhog
					.byte 3   ;11 beatle    Armored Cannon Beetle
					.byte 1   ;12 kabekuiA  Female Sheargrub
					.byte 1   ;13 kabekuiB  Male Sheargrub
					.byte 1   ;14 kabekuiC  Shearwig
					.byte 0   ;15 tamago    Giant Egg
					.byte 0   ;16 dororo    Smoky Progg
					.byte 0   ;17 hibaA     Fire Geyser
					.byte 2   ;18 miurin    Mamuta
					.byte 1   ;19 otama     Wogpole
					.byte 0   ;1A usuba     Usuba (invalid)
					.byte 0   ;1B yamash3   (invalid)
					.byte 0   ;1C yamash4   (invalid)
					.byte 0   ;1D yamash5   (invalid)
					.byte 1   ;1E namazu    Water Dumple
					.byte 1   ;1F chappb    Dwarf Bulbear
					.byte 3   ;20 swallob   Spotty Bulbear
					.byte 2   ;21 frow      White Wollywog
					.byte 0   ;22 nakata1   (invalid)
					.balign 4
				TABLE_max_number_pellet_count_teki:
				mflr	max_number_pellet_teki_table
				lbzx	max_number_pellet_teki, max_number_pellet_teki_table, new_id
				stw	max_number_pellet_teki, 0x0004 (i_para)
				cmpwi	new_id, 0x07
				bne-	PALM_I_PARA_EXCEPTION
				stw	max_number_pellet_teki, 0x0000 (i_para)
				PALM_I_PARA_EXCEPTION:
				
				max_water_teki_table = iVar10
				max_water_teki       = iVar10
				bl	TABLE_max_water_count_teki
					.byte 0   ;00 frog      Yellow Wollywog
					.byte 0   ;01 iwagen    Iwagen
					.byte 0   ;02 iwagon    Rolling Boulder
					.byte 0   ;03 chappy    Dwarf Bulborb
					.byte 0   ;04 swallow   Spotty Bulborb
					.byte 0   ;05 mizigen   Honeywisps Generator
					.byte 0   ;06 qurione   Lone Honeywisp (invalid)
					.byte 0   ;07 palm      Pellet Posy
					.byte 1   ;08 collec    Breadbug
					.byte 2   ;09 kinoko    Puffstool
					.byte 0   ;0A shell     Pearly Clamclamp
					.byte 1   ;0B napkid    Snitchbug
					.byte 0   ;0C hollec    Breadbug Nest
					.byte 0   ;0D pearl     Lone Pearl (invalid)
					.byte 0   ;0E rocpe     Lone Rocket Pearl (invalid)
					.byte 0   ;0F tank      Fiery Blowhog
					.byte 2   ;10 mar       Puffy Blowhog
					.byte 2   ;11 beatle    Armored Cannon Beetle
					.byte 0   ;12 kabekuiA  Female Sheargrub
					.byte 0   ;13 kabekuiB  Male Sheargrub
					.byte 0   ;14 kabekuiC  Shearwig
					.byte 8   ;15 tamago    Giant Egg
					.byte 4   ;16 dororo    Smoky Progg
					.byte 0   ;17 hibaA     Fire Geyser
					.byte 2   ;18 miurin    Mamuta
					.byte 0   ;19 otama     Wogpole
					.byte 0   ;1A usuba     Usuba (invalid)
					.byte 0   ;1B yamash3   (invalid)
					.byte 0   ;1C yamash4   (invalid)
					.byte 0   ;1D yamash5   (invalid)
					.byte 0   ;1E namazu    Water Dumple
					.byte 0   ;1F chappb    Dwarf Bulbear
					.byte 0   ;20 swallob   Spotty Bulbear
					.byte 0   ;21 frow      White Wollywog
					.byte 0   ;22 nakata1   (invalid)
					.balign 4
				TABLE_max_water_count_teki:
				mflr	max_water_teki_table
				lbzx	max_water_teki, max_water_teki_table, new_id
				stw	max_water_teki, 0x000C (i_para)
				
				cmpwi	new_id, 0x05
				bne-	MIZIGEN_I_PARA_EXCEPTION
				li	r0, -2
				stw	f0, 0x0010 (i_para)   ;PARAMETER_0
				MIZIGEN_I_PARA_EXCEPTION:
				
				f_para = iVar9
				lwz	f_para, 0x0018 (curr_GenObject)
				lwz	f_para, 0x0034 (f_para)
				lwz	f_para, 0x0004 (f_para)
				lwz	f_para, 0x0000 (f_para)
				
				cmpwi	new_id, 0x05   ;Mizigen exception
				bne-	MIZIGEN_F_PARA_EXCEPTION
				lfsi	f0, 500.0
				stfs	f0, 0x0008 (f_para)   ;TERRITORY_RANGE
				MIZIGEN_F_PARA_EXCEPTION:
				
				lfsi	f0, 1.0
				stfs	f0, 0x000C (f_para)   ;PELLET_APPEARANCE_PROBABILITY
				stfs	f0, 0x0010 (f_para)   ;WATER_APPEARANCE_PROBABILITY
				
				personality = iVar9
				lwz	personality, 0x0018 (curr_GenObject)
				
				pellet_kind_teki_table = iVar10
				pellet_kind_teki       = iVar10
				bl	TABLE_pellet_kind_teki
					.byte 1   ;00 frog      Yellow Wollywog
					.byte 0   ;01 iwagen    Iwagen
					.byte 0   ;02 iwagon    Rolling Boulder
					.byte 0   ;03 chappy    Dwarf Bulborb
					.byte 1   ;04 swallow   Spotty Bulborb
					.byte 0   ;05 mizigen   Honeywisps Generator
					.byte 0   ;06 qurione   Lone Honeywisp (invalid)
					.byte 0   ;07 palm      Pellet Posy
					.byte 0   ;08 collec    Breadbug
					.byte 1   ;09 kinoko    Puffstool
					.byte 0   ;0A shell     Pearly Clamclamp
					.byte 0   ;0B napkid    Snitchbug
					.byte 0   ;0C hollec    Breadbug Nest
					.byte 0   ;0D pearl     Lone Pearl (invalid)
					.byte 0   ;0E rocpe     Lone Rocket Pearl (invalid)
					.byte 0   ;0F tank      Fiery Blowhog
					.byte 1   ;10 mar       Puffy Blowhog
					.byte 0   ;11 beatle    Armored Cannon Beetle
					.byte 0   ;12 kabekuiA  Female Sheargrub
					.byte 0   ;13 kabekuiB  Male Sheargrub
					.byte 0   ;14 kabekuiC  Shearwig
					.byte 2   ;15 tamago    Giant Egg
					.byte 0   ;16 dororo    Smoky Progg
					.byte 0   ;17 hibaA     Fire Geyser
					.byte 0   ;18 miurin    Mamuta
					.byte 0   ;19 otama     Wogpole
					.byte 0   ;1A usuba     Usuba (invalid)
					.byte 0   ;1B yamash3   (invalid)
					.byte 0   ;1C yamash4   (invalid)
					.byte 0   ;1D yamash5   (invalid)
					.byte 0   ;1E namazu    Water Dumple
					.byte 0   ;1F chappb    Dwarf Bulbear
					.byte 1   ;20 swallob   Spotty Bulbear
					.byte 1   ;21 frow      White Wollywog
					.byte 0   ;22 nakata1   (invalid)
					.balign 4
				TABLE_pellet_kind_teki:
				mflr	pellet_kind_teki_table
				lbzx	pellet_kind_teki, pellet_kind_teki_table, new_id
				stw	pellet_kind_teki, 0x0020 (personality)
				
				pellet_color_teki = iVar10
				li	pellet_color_teki, -1                     ;-1 is random color
				stw	pellet_color_teki, 0x0024 (personality)   ;PELLET_COLOR
				
				item_teki = iVar10
				lwz	r3, pelletMgr (r13)
				mr	r4, curr_itempellet_id
				call	getConfigFromIdx__9PelletMgrFi
				lis	item_teki,            none@h
				ori	item_teki, item_teki, none@l
				cmpwi	r3, 0    ;function returns nullptr for index -1
				beq	0x0008   ;Don't try dereferencing a nullptr
				lwz	item_teki, 0x0030 (r3)
				stw	item_teki, 0x0028 (personality)         ;Write item pellet
				stw	item_teki, 0x002C (personality)         ;Write item pellet
				
				stw	new_id, 0x001C (curr_GenObject)  ;Write Teki ID
				b	DETERMINED
			
			MAKE_INTO_BOSS:
				can_carry_boss_table = iVar9
				can_carry_boss       = iVar9
				cmpwi	curr_itempellet_id, -1
				beq-	BOSS_NOT_CARRYING
				bl	TABLE_can_carry_boss
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
				TABLE_can_carry_boss:
				mflr	can_carry_boss_table
				lbzx	can_carry_boss, can_carry_boss_table, new_id
				cmpwi	can_carry_boss, 0
				beq-	RANDO_DISAMBIGUATION
				BOSS_NOT_CARRYING:
				
				pellet_kind_boss_table = iVar9
				pellet_kind_boss       = iVar9
				bl	TABLE_pellet_kind_boss
					.byte 0   ;00 kumo
					.byte 0   ;01 snake (sphere)
					.byte 1   ;02 slime
					.byte 1   ;03 king
					.byte 0   ;04 kogane
					.byte 3   ;05 pom
					.byte 0   ;06 kingback
					.byte 0   ;07 snake (prism)
					.byte 0   ;08 mizu (off)
					.byte 0   ;09 mizu (on)
					.balign 4
				TABLE_pellet_kind_boss:
				mflr	pellet_kind_boss_table
				lbzx	pellet_kind_boss, pellet_kind_boss_table, new_id
				stw	pellet_kind_boss, 0x001C (curr_GenObject)
				
				pellet_color_boss = iVar9
				li	pellet_color_boss, 3
				;While Candypop Buds randomize perfectly fine with the value for random color (3), the 20 Pellet that
				;drops after exhausting one will be randomized a second time with that value, leaving no guarantee
				;that it will match in color.  By randomizing Candypop Bud colors manually, we can remedy this.
				cmpwi	new_id, 0x05
				bne-	POM_COLOR_EXCEPTION
				li	r3, 2
				call	randomInt__7NSystemFi
				mr	pellet_color_boss, r3
				POM_COLOR_EXCEPTION:
				stw	pellet_color_boss, 0x0020 (curr_GenObject)
				
				pellet_count_boss_table = iVar9
				pellet_count_boss       = iVar9
				bl	TABLE_pellet_count_boss
					.byte 5   ;00 kumo
					.byte 0   ;01 snake (sphere)
					.byte 4   ;02 slime
					.byte 5   ;03 king
					.byte 0   ;04 kogane
					.byte 1   ;05 pom
					.byte 0   ;06 kingback
					.byte 0   ;07 snake (prism)
					.byte 0   ;08 mizu (off)
					.byte 0   ;09 mizu (on)
					.balign 4
				TABLE_pellet_count_boss:
				mflr	pellet_count_boss_table
				lbzx	pellet_count_boss, pellet_count_boss_table, new_id
				stw	pellet_count_boss, 0x0024 (curr_GenObject)
				
				stw	curr_itempellet_id, 0x0028 (curr_GenObject)
				
				stw	new_id, 0x0018 (curr_GenObject)   ;Write Boss ID
				b	DETERMINED
			
			MAKE_INTO_MAPOBJ:
				b	0
			
			MAKE_INTO_NAVI:
				b	0
			
			MAKE_INTO_ACTOR:
				b	0
			
			
			
			DETERMINED:
				mr.	r3, curr_GenObject
				beq-	NULLPTR_CHECK
				li	r5, 1
				lwz	r12, 0x0004 (curr_GenObject)
				lwz	r12, 0x0024 (r12)
				mtlr	r12
				blrl	;-->[updateUseList] of curr_GenObject
				NULLPTR_CHECK:
				place_to_put = iVar7
				mulli	place_to_put, loop_count, 4
				stwx	curr_GenObject, output_list, place_to_put
			
			
		
		addi	loop_count, loop_count, 1
		b	PREDETERMINE_LOOP
	PREDETERMINE_LOOP_DONE:
	
	

EPILOGUE:
	lmw	gpr_save, 0x0008 (sp)
	lwz	sp, 0x0000 (sp)
;	lwz	r0, 0x0004 (sp)
;	mtlr	r0
;	blr

HIJACKED:
	lwz	r0, 0x00EC (sp)


















