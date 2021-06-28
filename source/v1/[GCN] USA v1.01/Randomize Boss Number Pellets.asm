#To be inserted at 8014e268
;╔════════════════════════════════════════════════════════════╗
;║ Randomize Boss Pellet Spawns                    Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [createPellet__4BossFR8Vector3ffb]
; r5 is pellet kind
; r4 is pellet color
; r3 is some static pointer idk

PELLET_KIND:
	lis	r3, 0x8021		;[rand]@h
	ori	r3, r3, 0x8070		;[rand]@l
	mtlr	r3
	blrl ;-->[rand]
	
	li	r5, 0           ; 4/8 times it will be a 1 pellet
	cmpwi	r3, 0x4000
	bgt-	END
	li	r5, 1           ; 3/8 times it will be a 5 pellet
	cmpwi	r3, 0x1000
	bgt-	END
	li	r5, 2           ; 1/8 times it will be a 10 pellet
	END:

PELLET_COLOR:
	lis	r3, 0x8021		;[rand]@h
	ori	r3, r3, 0x8070		;[rand]@l
	mtlr	r3
	blrl ;-->[rand]
	li	r0, 0x0003		; Limit returned value from 0x00 - 0x02
	divw	r4, r3, r0		; Modulo 0x03 (1/3)
	mullw	r4, r4, r0		; Modulo 0x03 (2/3)
	sub	r4, r3, r4		; Modulo 0x03 (3/3) (note I'm storing it in r4)

REPAIR:
	lwz	r3, 0x301C (r13)

HIJACKED:
	; don't