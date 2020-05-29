#To be inserted at 80199bf0
;╔════════════════════════════════════════════════════════════╗
;║ Randomize Plants                                Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [doRead__14GenObjectPlantFR18RandomAccessStream]
; NO STACK FRAME!!
; r31 is pointer to GEN Object in memory
; SPENT: {r3,r4}


GENERATE_NEW_ID_VALUE:
	lis	r4, 0x8002		;[rand]@h
	ori	r4, r4, 0xc7ec		;[rand]@l
	mtlr	r4
	blrl ;-->[rand]
	li	r0, 0x000C		; Limit returned value from 0 - B
	divw	r4, r3, r0		; Modulo (1/3)
	mullw	r4, r4, r0		; Modulo (2/3)
	sub	r3, r3, r4		; Modulo (3/3)

WRITE_TO_GEN_OBJECT:
	stw	r3, 0x0018 (r31)

HIJACKED:
	lwz	r31, 0x000C (sp)