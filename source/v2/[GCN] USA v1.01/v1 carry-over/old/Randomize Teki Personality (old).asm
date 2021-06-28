#To be inserted at 8014d0f4
;--------------------------------------------------
;Randomize Teki "Personality"            Minty Meeo
;--------------------------------------------------
; In function [read__15TekiPersonalityFR18RandomAccessStreami]
; NO STACK FRAME!!!
; r3 and r4 are spent
; r28 is the pointer to the teki "personality"


PELLET_KIND:
	lis	r4, 0x8021		;[rand]@h
	ori	r4, r4, 0x8070		;[rand]@l
	mtlr	r4
	blrl ;-->[rand]
	cmpwi	r3, 0x1000       
	li	r3, 0            ; 7/8 times it will be a 1 pellet
	bne-	0x0008
	li	r3, 1            ; 1/8 times it will be a 5 pellet
	stw r3, 0x0020 (r28)     ; Write to teki personality
PELLET_COLOR:
	li 	r3, 0x00FF       ; lol there's already a faculty for random color.
	stw r3, 0x0024 (r28)     ; Write to teki personality


HIJACKED:
	lwz	r0, 0x006C (sp)