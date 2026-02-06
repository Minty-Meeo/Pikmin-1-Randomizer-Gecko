#To be inserted at 8007fa90
;╔════════════════════════════════════════════════════════════╗
;║ Augment PlayerState class                       Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [__ct__11PlayerStateFv 	plugPikiKando.a playerState.cpp]
;---Compiler Constants-----------------------------------------
iVar0 = 31
;---Symbols----------------------------------------------------
alloc__6SystemFUl              = 0x80047004
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
	PlayerState = iVar0

PROLOGUE:
	;

BODY:
	li	r3, ( ufopart_count + 3 ) & 0xFFFFFFFC
	call	alloc__6SystemFUl
	stw	r3, 0x01CC (PlayerState)

	;li	r4, -1
	;li	r5, ( ufopart_count + 3 ) & 0xFFFFFFFC
	;call	memset

EPILOGUE:
	;

HIJACKED:
	mr	r3, PlayerState














