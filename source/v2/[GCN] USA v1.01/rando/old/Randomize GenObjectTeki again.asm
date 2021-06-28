#To be inserted at 8011b690
;╔════════════════════════════════════════════════════════════╗
;║ Randomize GenObjectTeki again                   Minty Meeo ║
;║ (for GenType "at once" and "init random")                  ║
;╚════════════════════════════════════════════════════════════╝
;In function [birth__13GenObjectTekiFR9BirthInfo 	plugPikiNakata.a genteki.cpp]
;---Compiler Constants-----------------------------------------
permVar0 = 31
permVar1 = 30
permVar2 = 29

tempVar0 = 30
;---Local Vars-------------------------------------------------
curr_Teki          = permVar0   ;Teki*
curr_BirthInfo     = permVar1   ;BirthInfo*
curr_GenObjectTeki = permVar2   ;GenObjectTeki*
;---Function Pointers------------------------------------------
randomInt__7NSystemFi    = 0x8011e8a4
rand                     = 0x80218070
;---Constants--------------------------------------------------
RANDO_LIMIT   = 0
RANDO_BASIC   = 1
RANDO_HARD    = 2
RANDO_GEYSER  = 3
RANDO_DECO    = 4
RANDO_DELETE  = 5

PLNT = 0x706C6E74
TEKI = 0x74656B69
BOSS = 0x626F7373
PELT = 0x70656C74
PIKI = 0x70696B69
ITEM = 0x6974656D
WORK = 0x776F726B
DEBG = 0x64656267
MPAR = 0x6D706172
MOBJ = 0x6D6F626A
NAVI = 0x6E617669
ACTR = 0x61637472
;--------------------------------------------------------------


EXPOSITION:
	;

PROLOGUE:
	;

BODY:
	curr_table      = tempVar0
	curr_table_size = tempVar1
	bl	SKIP_limit_table
	curr_table_size = 10
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
		.byte 0
		.byte 0
	SKIP_limit_table:
	mflr	curr_table
	
	lis	r12,      randomInt__7NSystemFi@h
	ori	r12, r12, randomInt__7NSystemFi@l
	mtctr	r12
	li	r3, curr_table_size - 1
	bctrl	;-->[randomInt__7NSystemFi]
	
	lbzx	r3, curr_table, r3
	stw	r3, 0x001C (curr_GenObjectTeki)

EPILOGUE:
	;

HIJACKED:
	mr	r3, curr_Teki
	lwz	r0, 0x004C (sp)





