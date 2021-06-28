#To be inserted at 8012c8b4
;╔════════════════════════════════════════════════════════════╗
;║ Breadbugs spawn with nest                       Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [start__17TaiCollecStrategyFR4Teki 	plugPikiNakata.a taicollec.cpp]
;---Compiler Constants-----------------------------------------
permVar0 = 31
;---Local Vars-------------------------------------------------
Teki = permVar0
;---Symbols----------------------------------------------------
randomInt__7NSystemFi = 0x8011e8a4
rand                  = 0x80218070
spawnTeki__5BTekiFi   = 0x80146740
;---Constants--------------------------------------------------

;--------------------------------------------------------------



EXPOSITION:
	;

PROLOGUE:
	;

BODY:
	mr	r3, Teki
	li	r4, 0x000C   ;hollec ID
	lis	r12,      spawnTeki__5BTekiFi@h
	ori	r12, r12, spawnTeki__5BTekiFi@l
	mtlr	r12
	blrl	;-->[spawnTeki__5BTekiFi]

EPILOGUE:
	;

HIJACKED:
	lwz	r0, 0x004C (sp)