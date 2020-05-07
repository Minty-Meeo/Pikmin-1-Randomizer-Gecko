#To be inserted at 80053640
;╔════════════════════════════════════════════════════════════╗
;║ Reset static int upgrade_counter                Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [init__16OnePlayerSectionFv]
; NO STACK FRAME!!!
; SPENT: {r0}

MAIN:
	li	r0, 0
	stw	r0, 0x7B24 (r13)

HIJACKED:
	mflr	r0