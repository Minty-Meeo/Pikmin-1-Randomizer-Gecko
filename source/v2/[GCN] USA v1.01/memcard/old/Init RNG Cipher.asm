#To be inserted at 8007f758
;╔════════════════════════════════════════════════════════════╗
;║ Init RNG Cipher                                 Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [initGame__11PlayerStateFv]
; NO STACK FRAME!!!
; r31 is pointer to PlayerState

;--------------------------------------------------------------------------------
rand = 0x80218070
;--------------------------------------------------------------------------------

BODY:
	lis	r12,      rand@h
	ori	r12, r12, rand@l
	mtctr	r12
	bctrl	;--> [rand]
	sth	r3, 0x0012 (r31)

HIJACKED:
	lwz	r0, 0x002C (sp)