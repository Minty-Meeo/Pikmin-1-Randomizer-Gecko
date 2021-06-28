#To be inserted at 8007fa90
;╔════════════════════════════════════════════════════════════╗
;║ Augment PlayerState class                       Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [__ct__11PlayerStateFv 	plugPikiKando.a playerState.cpp]
;---Tails------------------------------------------------------
;04054e34 386001d0   ; Resize PlayerState class (0x01CC)
;---Compiler Constants-----------------------------------------
permVar0 = 31

tempVar0 = 30
tempVar1 = 29
tempVar2 = 28
tempVar3 = 27
tempVar4 = 26
;---Local Vars-------------------------------------------------
PlayerState = permVar0
;---Function Pointers------------------------------------------
alloc__6SystemFUl              = 0x80047004
memset                         = 0x80003320
randomInt__7NSystemFi          = 0x8011e8a4
rand                           = 0x80218070
;---Constants--------------------------------------------------
ufopart_count = 30
;--------------------------------------------------------------




EXPOSITION:
	;

PROLOGUE:
	;

BODY:
	lis	r12,      alloc__6SystemFUl@h
	ori	r12, r12, alloc__6SystemFUl@l
	mtctr	r12
	li	r3, ( ufopart_count + 3 ) & 0xFFFFFFFC
	bctrl	;-->[alloc__6SystemFUl]
	stw	r3, 0x01CC (PlayerState)
	
	;lis	r12,      memset@h
	;ori	r12, r12, memset@l
	;mtctr	r12
	;li	r4, -1
	;li	r5, ( ufopart_count + 3 ) & 0xFFFFFFFC
	;bctrl	;-->[memset]

EPILOGUE:
	;

HIJACKED:
	mr	r3, PlayerState














