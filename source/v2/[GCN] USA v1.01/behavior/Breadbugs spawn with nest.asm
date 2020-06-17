#To be inserted at 8012c8b4
;╔════════════════════════════════════════════════════════════╗
;║ Breadbugs spawn with nest                       Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [start__17TaiCollecStrategyFR4Teki 	plugPikiNakata.a taicollec.cpp]
;---Compiler Constants-----------------------------------------
iVar0 = 31
;---Symbols----------------------------------------------------
spawnTeki__5BTekiFi   = 0x80146740
;---Constants--------------------------------------------------

;---Macros-----------------------------------------------------
.macro	call	addr
lis	r12,      \addr@h
ori	r12, r12, \addr@l
mtlr	r12
blrl
.endm
;--------------------------------------------------------------



EXPOSITION:
	Teki = iVar0

PROLOGUE:
	;

BODY:
	mr	r3, Teki
	li	r4, 0x000C   ;hollec ID
	call	spawnTeki__5BTekiFi

EPILOGUE:
	;

HIJACKED:
	lwz	r0, 0x004C (sp)
