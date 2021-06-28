#To be inserted at 80080460
;╔════════════════════════════════════════════════════════════╗
;║ Load RNG Cipher                                 Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [loadCard__11PlayerStateFR18RandomAccessStream]

; r30 is pointer to RandomAccessStream
; r29 is pointer to PlayerState

BODY:
	mr	r3, r30
	lwz	r12, 0x0004 (r30)
	lwz	r12, 0x0010 (r12)
	mtlr	r12
	blrl	;--> [readShort__6StreamFs] Load from MemCard
	sth	r3, 0x0012 (r29)   ; Store to PlayerState

HIJACKED:
	lmw	r26, 0x0028 (sp)
