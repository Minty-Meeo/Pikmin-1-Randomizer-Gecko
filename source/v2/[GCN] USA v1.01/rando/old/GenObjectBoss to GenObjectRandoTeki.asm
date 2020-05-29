#To be inserted at 8014d3e4
;╔════════════════════════════════════════════════════════════╗
;║ GenObjectBoss to GenObjectRandoTeki             Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [doRead__13GenObjectBossFR18RandomAccessStream 	plugPikiNishimura.a genBoss.cpp]
;0x0000 Old SP
;0x0004 LR Reserved
;0x0008 save r30
;0x000C save r31

;--------------------------------------------------------------------------------
__vt__7GenObjectTeki = 0x802C411C
rand                 = 0x80218070
;--------------------------------------------------------------------------------
GenObjectType = 0x74656B69   ;teki in hexadecimal
genteki_1234 = 0x802C40A0
genteki_1235 = 0x802C40AC
LIMIT = 0
BASIC = 1
BOSS = 2
GEYSER = 3
;--------------------------------------------------------------------------------

PROLOGUE:
	mflr	r0
	stw	r0, 0x0004 (sp)
	stwu	sp, -0x0010 (sp)
	stmw	r30, 0x0008 (sp)
	mr	r31, r4
	mr	r30, r3

BODY:
	mr	r3, r31
	lwz	r12, 0x0004 (r31)
	lwz	r12, 0x0008 (r12)
	mtlr	r12
	blrl	;-->[readInt__6StreamFv]
	andi.	r3, r3, 0x000F
	bl	SKIP
	RANDOBOSS_TABLE:
		.byte BOSS      ;00 kumo
		.byte BOSS      ;01 snake (sphere)
		.byte BOSS      ;02 slime
		.byte BOSS      ;03 king
		.byte BASIC     ;04 kogane
		.byte BASIC     ;05 pom
		.byte BASIC     ;06 kingback
		.byte BOSS      ;07 snake (prism)
		.byte GEYSER    ;08 mizu (off)
		.byte GEYSER    ;09 mizu (on)
		.byte 0 ;padding
		.byte 0 ;padding
	SKIP:
	mflr	r11
	lbzx	r3, r11, r3
	stw	r3, 0x001C (r30)
	
	lwz	r12, 0x0000 (sp)   ;Locate caller stack frame
	;Convert GenObject vtable
	lis	r11,      __vt__7GenObjectTeki@h
	ori	r11, r11, __vt__7GenObjectTeki@l
	stw	r11, 0x0004 (r30)  ;Edit GenObject
	;Convert GenObject type
	lis	r11,      GenObjectType@h
	ori	r11, r11, GenObjectType@l
	stw	r11, 0x0008 (r30)  ;Edit GenObject
	stw	r11, 0x00A8 (r12)  ;Edit stack frame of caller
	;Convert GenObject version
	li	r11, 0x000A
	stw	r11, 0x000C (r30)  ;Edit GenObject
	stw	r11, 0x0078 (r12)  ;Edit stack frame of caller

EPILOGUE:
	lmw	r30, 0x0008 (sp)
	lwz	sp, 0x0000 (sp)
	lwz	r0, 0x0004 (sp)
	mtlr	r0
	blr
