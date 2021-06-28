#To be inserted at 80145f50
;╔════════════════════════════════════════════════════════════╗
;║ Randomize Spawn Number Pellet (2/2)             Minty Meeo ║
;║ This one makes the pellet count random                     ║
;╚════════════════════════════════════════════════════════════╝
; In function [spawnItems__5BTekiFv]
; NO STACK FRAME!!!
; SPENT: {r3,r4,r5}
; r6 is pellet count
; r31 is pointer to Teki Class


PELLET_COUNT:
	lis	r3, 0x8021		;[rand]@h
	ori	r3, r3, 0x8070		;[rand]@l
	mtlr	r3
	blrl ;-->[rand]
	lwz	r4, 0x0320 (r31)   ; Load Teki ID from Teki Class
	cmpwi	r4, 7              ; Check if it is a Pellet Posy
	beq-	PELLET_POSY_EXCEPTION
	; 0x0000 - 0x0800   1/16 | three
	; 0x0801 - 0x1800   2/16 | two
	; 0x1801 - 0x4000   5/16 | one
	; 0x4001 - 0x8000   8/16 | zero
	li	r6, 0
	cmpwi	r3, 0x4000
	bgt-	END
	PELLET_POSY_EXCEPTION:
	li	r6, 1
	cmpwi	r3, 0x1800
	bgt-	END
	li	r6, 2
	cmpwi	r3, 0x0800
	bgt-	END
	li	r6, 3 
	END:


HIJACKED:
	; don't