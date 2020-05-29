#To be inserted at 801b98a8
;╔════════════════════════════════════════════════════════════╗
;║ Randomize Spawn Number Pellet (1/2)             Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [spawnPellets__5BTekiFiii]
; NO STACK FRAME!!!
; SPENT: {r4,r5,r25}
; r3          needs repair
; r5 is the Pellet Kind
; r4 is the Pellet Color


PELLET_KIND:
	lis	r3, 0x8002		;[rand]@h
	ori	r3, r3, 0xc7ec		;[rand]@l
	mtlr	r3
	blrl ;-->[rand]
	cmpwi	r3, 0x1000
	li	r5, 0           ; 7/8 times it will be a 1 pellet
	bgt-	0x0008
	li	r5, 1           ; 1/8 times it will be a 5 pellet

PELLET_COLOR:
	lis	r3, 0x8002		;[rand]@h
	ori	r3, r3, 0xc7ec		;[rand]@l
	mtlr	r3
	blrl ;-->[rand]
	li	r0, 0x0003		; Limit returned value from 0x00 - 0x02
	divw	r4, r3, r0		; Modulo 0x03 (1/3)
	mullw	r4, r4, r0		; Modulo 0x03 (2/3)
	sub	r4, r3, r4		; Modulo 0x03 (3/3) (note I'm storing it in r4)



REPAIR:
	lwz	r3, -0x0510 (r13)

HIJACKED:
	;don't fix