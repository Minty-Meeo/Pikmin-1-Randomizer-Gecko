#To be inserted at 8014d4b8
;╔════════════════════════════════════════════════════════════╗
;║ Boss to RandoBoss                               Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [doRead__13GenObjectBossFR18RandomAccessStream]
; NO STACK FRAME!!!
; r30 is GenObjectBoss*

;--------------------------------------------------------------------------------
BASIC = 0
WEIRD = 1
GEYSER = 2
;--------------------------------------------------------------------------------

bl	SKIP
RANDOBOSS_TABLE:
	.byte BASIC     ;00 kumo
	.byte BASIC     ;01 snake (sphere)
	.byte BASIC     ;02 slime
	.byte BASIC     ;03 king
	.byte WEIRD     ;04 kogane
	.byte WEIRD     ;05 pom
	.byte WEIRD     ;06 kingback
	.byte BASIC     ;07 snake (prism)
	.byte GEYSER    ;08 mizu (off)
	.byte GEYSER    ;09 mizu (on)
	.byte 0 ;padding
	.byte 0 ;padding

SKIP:
	lwz	r3, 0x0018 (r30)
	mflr	r12
	lbzx	r3, r12, r3
	stw	r3, 0x0018 (r30)

HIJACKED:
	lwz	r0, 0x002C (sp)



