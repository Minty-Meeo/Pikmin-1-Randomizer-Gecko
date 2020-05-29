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

tempVar0 = 23
tempVar1 = 22
tempVar2 = 21
tempVar3 = 20
;---Local Vars-------------------------------------------------
current_generator  = permVar0   ;Generator* current_generator
old_GenObject      = permVar1   ;GenObject* old_GenObject
new_GenObject      = permVar2   ;GenObject* new_GenObject
rando_id           = permVar3   ;int rando_id
;---Function Pointers------------------------------------------
makeObjectPlant__Fv      = 0x8011accc
makeObjectTeki__Fv       = 0x8011b2cc
makeObjectBoss__Fv       = 0x8014d2d0
makeObjectPellet__Fv     = 0x80099d1c
makeObjectPiki__Fv       = 0x800dad34
makeObjectItem__Fv       = 0x800ee470
makeObjectWorkObject__Fv = 0x8009b7c4
randomInt__7NSystemFi    = 0x8011e8a4
rand                     = 0x80218070
bossMgr                  = 0X3168
init__7BossMgrFii        = 0x80150f24
current_stage            = 0x803dce04
;---Constants--------------------------------------------------
GENOBJECT_TEKI = 0
GENOBJECT_BOSS = 1
GENOBJECT_PLANT = 2

RANDO_LIMIT   = 0
RANDO_BASIC   = 1
RANDO_HARD    = 2
RANDO_GEYSER  = 3
RANDO_DECOR   = 4
RANDO_DELETE  = 5
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
	
	lwz	old_GenObject, 0x0034 (r31)
	
	mr.	new_GenObject, old_GenObject
	beq-	UPDATE   ;nullptr check because Distant Spring

	bl	SKIP_GenObject_id_table
		.ascii "teki"
		.ascii "boss"
		.ascii "plnt"
		.ascii "pelt"
		.ascii "piki"
		.ascii "item"
	;	.ascii "work"
	;	.ascii "debg"
	;	.ascii "navi"
	;	.ascii "mpar"
	;	.ascii "mobj"
	;	.ascii "actr"
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
			.byte RANDO_HARD      ;15 tamago    Giant Egg
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
		b	RANDO_DISAMBIGUATION
	
	IS_BOSS:
		boss_id_table      = tempVar0
		old_boss_id        = tempVar1
		
		bl	SKIP_boss_id_table
			.byte RANDO_HARD      ;00 kumo
			.byte RANDO_HARD      ;01 snake (sphere)
			.byte RANDO_HARD      ;02 slime
			.byte RANDO_HARD      ;03 king
			.byte RANDO_BASIC     ;04 kogane
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
		bne-	DISAMBIGUATION_6
			li	new_GenObject, 0
			b	UPDATE
		DISAMBIGUATION_6:
		b	UPDATE
	

	MAKE:
		new_type = tempVar2
		new_id   = tempVar3
		
		subi	r3, curr_table_size, 1
		lis	r12,      randomInt__7NSystemFi@h
		ori	r12, r12, randomInt__7NSystemFi@l
		mtctr	r12
		bctrl	;-->[randomInt__7NSystemFi]
		lbzx	new_type, curr_table, r3
		add	curr_table, curr_table, curr_table_size
		lbzx	new_id, curr_table, r3
		
		;li	new_type, 1   ;For debugging, force the output
		;li	new_id, 3     ;For debugging, force the output
		
		cmpwi	new_type, GENOBJECT_TEKI
		beq-	MAKE_INTO_TEKI
		cmpwi	new_type, GENOBJECT_BOSS
		beq-	MAKE_INTO_BOSS
		cmpwi	new_type, GENOBJECT_PLANT
		beq-	MAKE_INTO_PLANT
		b	UPDATE
		

	MAKE_INTO_TEKI:
		lis	r12,      makeObjectTeki__Fv@h
		ori	r12, r12, makeObjectTeki__Fv@l
		mtctr	r12
		bctrl	;-->[makeObjectTeki__Fv]
		mr	new_GenObject, r3
		stw	new_id, 0x001C (new_GenObject)
		b	UPDATE
	MAKE_INTO_BOSS:
		
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
		b	UPDATE
	MAKE_INTO_PLANT:
		lis	r12,      makeObjectPlant__Fv@h
		ori	r12, r12, makeObjectPlant__Fv@l
		mtctr	r12
		bctrl	;-->[makeObjectPlant__Fv]
		mr	new_GenObject, r3
		stw	new_id, 0x0018 (new_GenObject)
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




	





