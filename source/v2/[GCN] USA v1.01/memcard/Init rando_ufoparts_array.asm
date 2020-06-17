#To be inserted at 8007f758
;╔════════════════════════════════════════════════════════════╗
;║ Init rando_ufoparts_array                       Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [initGame__11PlayerStateFv 	plugPikiKando.a playerState.cpp]
;---Compiler Constants-----------------------------------------
gpr_save = 26

iVar0 = 31
iVar1 = 30

iVar2 = 29
iVar3 = 28
iVar4 = 27
iVar5 = 26
;---Symbols----------------------------------------------------
alloc__6SystemFUl              = 0x80047004
getConfigFromIdx__9PelletMgrFi = 0x80098c88
getConfigIndex__9PelletMgrFUl  = 0x80098c48
isUfoPartsID__6PelletFUl       = 0x800953ac
memset                         = 0x80003320
randomInt__7NSystemFi          = 0x8011e8a4
rand                           = 0x80218070
;---Constants--------------------------------------------------
ufopart_count = 30
;---Macros-----------------------------------------------------
.macro	call	addr
lis	r12,      \addr@h
ori	r12, r12, \addr@l
mtlr	r12
blrl
.endm
;--------------------------------------------------------------




EXPOSITION:
	mr	r3, r31

PROLOGUE:
	mflr	r0
	stw	r0, 0x0004 (sp)
	stwu	sp, -( 0x0008 + ( ( 32 - gpr_save ) * 4 ) ) (sp)
	stmw	gpr_save, 0x0008 (sp)

BODY:
	PlayerState          = iVar0
	rando_ufoparts_array = iVar1
	
	mr	PlayerState, r3
	lwz	rando_ufoparts_array, 0x01CC (PlayerState)
	
	success_counter   = iVar2
	array_index       = iVar3
	id_from_array     = iVar4
	curr_possible_id  = iVar5
	
	li	success_counter, 0
	
	LOOP_generate_30_unique_indexes:
		li	r3, ufopart_count - 1
		call	randomInt__7NSystemFi
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
;	blr

HIJACKED:
	lwz	r0, 0x002C (sp)






























