#To be inserted at 80080460
;╔════════════════════════════════════════════════════════════╗
;║ Load rando_ufoparts_array from memcard          Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [loadCard__11PlayerStateFR18RandomAccessStream]
;---Compiler Constants-----------------------------------------
permVar0 = 31
permVar1 = 30
permVar2 = 29

tempVar0 = 28
tempVar1 = 27
tempVar2 = 26
;---Local Vars-------------------------------------------------
RandomAccessStream   = permVar1
PlayerState          = permVar2
rando_ufoparts_array = permVar0
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
		mr	r3, RandomAccessStream
		lwz	r12, 0x0004 (RandomAccessStream)   ;[__vt__18RandomAccessStream]
		lwz	r12, 0x000C (r12)                  ;[readByte__6StreamFs]
		mtlr	r12
		blrl	;--> [readByte__6StreamFs]
		stbx	r3, rando_ufoparts_array, array_index
		
		addi	array_index, array_index, 1
		cmpwi	array_index, ufopart_count
		blt-	LOOP_array_index
	LOOP_DONE_array_index:

EPILOGUE:
	;

HIJACKED:
	lmw	r26, 0x0028 (sp)
