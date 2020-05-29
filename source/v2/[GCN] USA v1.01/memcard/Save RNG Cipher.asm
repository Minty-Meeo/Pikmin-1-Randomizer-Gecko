#To be inserted at 80080094
;╔════════════════════════════════════════════════════════════╗
;║ Save RNG Cipher                                 Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [saveCard__11PlayerStateFR18RandomAccessStream]

; r31 is pointer to RandomAccessStream
; r30 is pointer to PlayerState


BODY:
	mr	r3, r31
	lhz	r4, 0x0012 (r30)
	lwz	r12, 0x0004 (r31)
	lwz	r12, 0x0028 (r12)
	mtlr	r12
	blrl	;--> [writeShort__6StreamFs] Store to MemCard

HIJACKED:
	lmw	r26, 0x0020 (sp)