#To be inserted at 80000010
;╔════════════════════════════════════════════════════════════╗
;║ Perfectly fine replacement for                  Minty Meeo ║
;║ birth__13GenObjectBossFR9BirthInfo                         ║
;╚════════════════════════════════════════════════════════════╝
;0x0000 Old SP
;0x0004 LR Reserved
;0x0008 save r30
;0x000C save r31
;0x0010 save RandoBoss ID




;r3 is pointer to GenObjectBoss class
;r4 is pointer to BirthInfo class

;if replacing original function, insert @ 0x801513e4
;if accessed using partner code, insert @ 0x80000010

;--------------------------------------------------------------------------------
BossMgr__create       = 0x801513e4
__ct__7GenBaseFUlPcPc = 0x800DACB4
__vt__9GenObject      = 0x802bab70
__vt__13GenObjectBoss = 0x802CE7A4
rand                  = 0x80218070
;--------------------------------------------------------------------------------
genBoss1040        = 0x802ce728
genBoss1039        = 0x802ce71c
GenObjectBoss_size = 0x2C
;--------------------------------------------------------------------------------

PROLOGUE:
	mflr	r0
	stw	r0, 0x0004 (sp)
	stwu	sp, -0x0014 (sp)
	stmw	r30, 0x0008 (sp)
	mr	r31, r3
	mr	r30, r4



BODY:
	lis	r12,      rand@h
	ori	r12, r12, rand@l
	mtctr	r12
	bctrl	;-->[rand]
	
	lwz	r11, 0x0018 (r31)
	stw	r11, 0x0010 (sp)
	cmpwi	r11, 1
	blt-	BASIC   ;0
	beq-	WEIRD   ;1
	bgt-	GEYSER  ;2
	
	BASIC:
	li	r0, 0x0004   ; Limit returned value from 0 - 3
	divw	r4, r3, r0   ; Modulo (1/3)
	mullw	r4, r4, r0   ; Modulo (2/3)
	sub	r3, r3, r4   ; Modulo (3/3)
	li	r3, 3
	;addi	r3, r3, 0    ; Limit returned value from 0 - 3
	b	READY
	
	WEIRD:
	li	r0, 0x0002   ; Limit returned value from 0 - 1
	divw	r4, r3, r0   ; Modulo (1/3)
	mullw	r4, r4, r0   ; Modulo (2/3)
	sub	r3, r3, r4   ; Modulo (3/3)
	addi	r3, r3, 4    ; Limit returned value from 4 - 5
	b	READY
	
	GEYSER:
	li	r0, 0x0002   ; Limit returned value from 0 - 1
	divw	r4, r3, r0   ; Modulo (1/3)
	mullw	r4, r4, r0   ; Modulo (2/3)
	sub	r3, r3, r4   ; Modulo (3/3)
	addi	r3, r3, 8    ; Limit returned value from 8 - 9
	b	READY
	
	
	READY:
	stw	r3, 0x0018 (r31)
	
	
	
	
	mr	r6, r31            ; GenObjectBoss
	mr	r5, r30            ; BirthInfo
	lwz	r4, 0x0018 (r31)   ; int
	lwz	r3, 0x3168 (r13)   ; static BossMgr* (this)

	lis	r12, BossMgr__create@h
	ori	r12, r12, BossMgr__create@l
	mtctr	r12
	bctrl	;-->[create__7BossMgrFiR9BirthInfoP13GenObjectBoss]
	
	RESTORE:
	;lwz	r11, 0x0010 (sp)
	;stw	r11, 0x0018 (r31)

EPILOGUE:
	lwz	sp, 0x0000 (sp)
	lwz	r0, 0x0004 (sp)
	mtlr	r0
	blr




