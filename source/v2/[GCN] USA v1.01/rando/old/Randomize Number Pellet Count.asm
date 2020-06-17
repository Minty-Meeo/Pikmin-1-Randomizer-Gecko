#To be inserted at 80145f4c
;╔════════════════════════════════════════════════════════════╗
;║ Randomize Number Pellet Count                   Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
;---STACK------------------------------------------------------
; In function [spawnPellets__5BTekiFiii]
;---Compiler Constants-----------------------------------------
Teki         = 31
pellet_count = 0
;---Function Pointers------------------------------------------
randomInt__7NSystemFi          = 0x8011e8a4
rand                           = 0x80218070
;---Constants--------------------------------------------------

;---Macros-----------------------------------------------------
.macro	call addr
lis	r12,      \addr@h
ori	r12, r12, \addr@l
mtlr	r12
blrl
.endm
;--------------------------------------------------------------

EXPOSITION:
	;

PROLOGUE:
	;

BODY:
	li	r3, 100
	call	randomInt__7NSystemFi
	lwz	r0, 0x0320 (Teki)   ; Load Teki ID from Teki Class
	cmpwi	r0, 7               ; Check if it is a Pellet Posy
	beq-	PELLET_POSY_EXCEPTION
	;40% | 0 pellets
	;30% | 1 pellets
	;20% | 2 pellets
	;10% | 3 pellets
	
	li	pellet_count, 0
	cmpwi	r3, 40
	blt-	EPILOGUE
	
	PELLET_POSY_EXCEPTION:
	li	pellet_count, 1
	cmpwi	r3, 70
	blt-	EPILOGUE
	
	li	pellet_count, 2
	cmpwi	r3, 90
	blt-	EPILOGUE
	
	li	pellet_count, 3 

EPILOGUE:
	;

HIJACKED:
	;add	r0, r30, r3







	;'t