#To be inserted at 80080094
;╔════════════════════════════════════════════════════════════╗
;║ Save rando_ufoparts_array to memcard            Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [saveCard__11PlayerStateFR18RandomAccessStream]
;---Compiler Constants-----------------------------------------
permVar0 = 31
permVar1 = 30
permVar2 = 29

tempVar0 = 28
tempVar1 = 27
tempVar2 = 26
;---Local Vars-------------------------------------------------
RandomAccessStream   = permVar0
PlayerState          = permVar1
rando_ufoparts_array = permVar2
;---Symbols----------------------------------------------------
__vt__18RandomAccessStream = 0x802274c8
;---Constants--------------------------------------------------
ufopart_count = 30
;--------------------------------------------------------------


EXPOSITION:
	;

PROLOGUE:	
	;

BODY:
	lwz	rando_ufoparts_array, 0x01CC (PlayerState)
	
	array_index = tempVar0
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