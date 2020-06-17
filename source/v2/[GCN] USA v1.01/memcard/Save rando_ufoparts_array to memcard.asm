#To be inserted at 80080094
;╔════════════════════════════════════════════════════════════╗
;║ Save rando_ufoparts_array to memcard            Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [saveCard__11PlayerStateFR18RandomAccessStream]
;---Compiler Constants-----------------------------------------
iVar0 = 31
iVar1 = 30
iVar2 = 29
iVar3 = 28
iVar4 = 27
iVar5 = 26
;---Symbols----------------------------------------------------
__vt__18RandomAccessStream = 0x802274c8
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
	RandomAccessStream   = iVar0
	PlayerState          = iVar1

PROLOGUE:	
	;

BODY:
	rando_ufoparts_array = iVar2
	
	lwz	rando_ufoparts_array, 0x01CC (PlayerState)
	
	array_index = iVar3
	li	array_index, 0
	
	LOOP_array_index:
		lbzx	r4, rando_ufoparts_array, array_index
		mr	r3, RandomAccessStream
		lwz	r12, 0x0004 (RandomAccessStream)   ;[__vt__18RandomAccessStream]
		lwz	r12, 0x0028 (r12)                  ;[writeShort__6StreamFs]
		mtlr	r12
		blrl	;--> [writeShort__6StreamFs]
		
		addi	array_index, array_index, 1
		cmpwi	array_index, ufopart_count
		blt-	LOOP_array_index
	LOOP_DONE_array_index:

EPILOGUE:
	;

HIJACKED:
	lmw	r26, 0x0020 (sp)









