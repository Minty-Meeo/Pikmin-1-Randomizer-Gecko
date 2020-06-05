#To be inserted at 8007f758
;╔════════════════════════════════════════════════════════════╗
;║ Init rando_ufoparts_array                       Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [initGame__11PlayerStateFv 	plugPikiKando.a playerState.cpp]
;---Tails------------------------------------------------------
;04054e34 386001d0   ; Resize PlayerState class (0x01CC)
;---Compiler Constants-----------------------------------------
gpr_save = 26

permVar0 = 31
permVar1 = 30

tempVar0 = 29
tempVar1 = 28
tempVar2 = 27
tempVar3 = 26
;---Local Vars-------------------------------------------------
PlayerState          = permVar0
rando_ufoparts_array = permVar1
;---Function Pointers------------------------------------------
alloc__6SystemFUl              = 0x80047004
getConfigFromIdx__9PelletMgrFi = 0x80098c88
getConfigIndex__9PelletMgrFUl  = 0x80098c48
isUfoPartsID__6PelletFUl       = 0x800953ac
memset                         = 0x80003320
randomInt__7NSystemFi          = 0x8011e8a4
rand                           = 0x80218070
;---Constants--------------------------------------------------
ufopart_count = 30
;--------------------------------------------------------------




EXPOSITION:
	mr	r3, r31

PROLOGUE:
	mflr	r0
	stw	r0, 0x0004 (sp)
	stwu	sp, -( 0x0008 + ( ( 32 - gpr_save ) * 4 ) ) (sp)
	stmw	gpr_save, 0x0008 (sp)
	;Formal Variables -> Local Variables
	mr	PlayerState, r3

BODY:
	lwz	rando_ufoparts_array, 0x01CC (PlayerState)
	
	success_counter   = tempVar0
	array_index       = tempVar1
	id_from_array     = tempVar2
	curr_possible_id  = tempVar3
	
	li	success_counter, 0
	
	LOOP_generate_30_unique_indexes:
		li	r3, ufopart_count - 1
		lis	r12,      randomInt__7NSystemFi@h
		ori	r12, r12, randomInt__7NSystemFi@l
		mtctr	r12
		bctrl	;-->[randomInt__7NSystemFi]
		mr	curr_possible_id, r3
		
		li	array_index, 0
		LOOP_array_index:                                                  ;while (1) {
			cmpw	array_index, success_counter                       ;   if (array_index == success_counter ) {
			beq-	LOOP_DONE_array_index                              ;      break; }
			lbzx	id_from_array, rando_ufoparts_array, array_index   ;   id_from_array = rando_ufoparts_array[array_index];
			cmpw	id_from_array, curr_possible_id                    ;   if (id_from_array == curr_possible_id) {
			beq-	LOOP_generate_30_unique_indexes                    ;      goto LOOP_generate_30_unique_indexes; }
			addi	array_index, array_index, 1                        ;   array_index++]
			b	LOOP_array_index                                   ;}
		LOOP_DONE_array_index:
		
		addi	success_counter, success_counter, 1
		stbx	curr_possible_id, rando_ufoparts_array, array_index
		cmpwi	success_counter, ufopart_count
		blt-	LOOP_generate_30_unique_indexes
	LOOP_DONE_generate_30_unique_indexes:

EPILOGUE:
	lmw	gpr_save, 0x0008 (sp)
	lwz	sp, 0x0000 (sp)
	lwz	r0, 0x0004 (sp)
	mtlr	r0

HIJACKED:
	lwz	r0, 0x002C (sp)














