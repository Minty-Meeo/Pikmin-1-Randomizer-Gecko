#To be inserted at 8019a73c
;╔════════════════════════════════════════════════════════════╗
;║ Augment PlayerState class                       Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [__ct__11PlayerStateFv 	plugPikiKando.a playerState.cpp]
;---Compiler Constants-----------------------------------------
iVar0 = 31
;---Symbols----------------------------------------------------
alloc__6SystemFUl              = 0x800dae28
memset                         = 0x800063f0
randomInt__7NSystemFi          = 0x801c3abc
rand                           = 0x8002c7ec
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














