#To be inserted at 800eb5bc
;╔════════════════════════════════════════════════════════════╗
;║ Reset static int upgrade_counter                Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [init__16OnePlayerSectionFv]
; NO STACK FRAME!!!
; SPENT: {r0}

MAIN:
	li	r0, 0
	stw	r0, 0x4EE4 (r13)

HIJACKED:
	mflr	r0