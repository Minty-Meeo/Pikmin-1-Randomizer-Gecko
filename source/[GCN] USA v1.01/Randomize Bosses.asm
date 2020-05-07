#To be inserted at 8014d4b8
;╔════════════════════════════════════════════════════════════╗
;║ Randomize Bosses                                Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [doRead__13GenObjectBossFR18RandomAccessStream]
; NO STACK FRAME!!!
; SPENT: {r3,r4}
; r30 is pointer to the GEN Object

READ_FROM_GEN_OBJECT:
     lwz r3, 0x0018 (r30)


bl SWITCHCASE__old_id_value
SWITCHCASE__old_id_value:
	mfspr r4, lr
	addi r4, r4, 0x0018	
	mulli r0, r3, 4
	add r0, r0, r4
	mtctr r0
	bctr
	
	b BASIC      ;00 kumo
	b BASIC      ;01 snake (sphere)
	b BASIC      ;02 slime
	b BASIC      ;03 king
	b WEIRD      ;04 kogane
	b WEIRD      ;05 pom
	b WEIRD      ;06 kingback
	b BASIC      ;07 snake (prism)
	b GEYSER     ;08 mizu (off)
	b GEYSER     ;09 mizu (on)


BASIC:
	lis	r3, 0x8021		;[rand]@h
	ori	r3, r3, 0x8070		;[rand]@l
	mtlr	r3
	blrl ;-->[rand]
	li	r0, 0x000A		; Limit returned value from 0x00 - 0x09
	divw	r4, r3, r0		; Modulo 0x0A (1/3)
	mullw	r4, r4, r0		; Modulo 0x0A (2/3)
	sub	r3, r3, r4		; Modulo 0x0A (3/3)
	bl SWITCHCASE__basic_rng_value
	SWITCHCASE__basic_rng_value:
		mfspr r4, lr
		addi r4, r4, 0x0018	
		mulli r0, r3, 4
		add r0, r0, r4
		mtctr r0
		bctr
		
		b BASIC_OK   ;00 kumo
		b BASIC_OK   ;01 snake (sphere)
		b BASIC_OK   ;02 slime
		b BASIC_OK   ;03 king
		b BASIC      ;04 kogane
		b BASIC      ;05 pom
		b BASIC      ;06 kingback
		b BASIC      ;07 snake (prism)
		b BASIC      ;08 mizu (off)
		b BASIC      ;09 mizu (on)
	BASIC_OK:
	lwz	r4, 0x0018 (r30)  ; I'm sick of the 1/4 chance a boss is unchanged
	cmpw	r3, r4            ; So we're gonna check if it is a new value.
	beq-	BASIC             ; If not, start your ass over.
	b WRITE_TO_GEN_OBJECT
GEYSER:
	lis	r3, 0x8021		;[rand]@h
	ori	r3, r3, 0x8070		;[rand]@l
	mtlr	r3
	blrl ;-->[rand]
	andi.	r3, r3, 0x0001     ; Thanks to the IDs of these two
	addi	r3, r3, 0x0008     ; I can optimize this greatly
	b WRITE_TO_GEN_OBJECT
WEIRD:
	lis	r3, 0x8021		;[rand]@h
	ori	r3, r3, 0x8070		;[rand]@l
	mtlr	r3
	blrl ;-->[rand]
	li	r0, 0x000A		; Limit returned value from 0x00 - 0x09
	divw	r4, r3, r0		; Modulo 0x0A (1/3)
	mullw	r4, r4, r0		; Modulo 0x0A (2/3)
	sub	r3, r3, r4		; Modulo 0x0A (3/3)
	bl SWITCHCASE__weird_rng_value
	SWITCHCASE__weird_rng_value:
		mfspr r4, lr
		addi r4, r4, 0x0018	
		mulli r0, r3, 4
		add r0, r0, r4
		mtctr r0
		bctr
		
		b WEIRD      ;00 kumo
		b WEIRD      ;01 snake (sphere)
		b WEIRD      ;02 slime
		b WEIRD      ;03 king
		b WEIRD_OK   ;04 kogane
		b WEIRD_OK   ;05 pom
		b WEIRD      ;06 kingback
		b WEIRD      ;07 snake (prism)
		b WEIRD      ;08 mizu (off)
		b WEIRD      ;09 mizu (on)
	WEIRD_OK:
	b WRITE_TO_GEN_OBJECT


WRITE_TO_GEN_OBJECT:
	stw r3, 0x0018 (r30)
	PELLET_COLOR:
		lis	r3, 0x8021		;[rand]@h
		ori	r3, r3, 0x8070		;[rand]@l
		mtlr	r3
		blrl ;-->[rand]
		li	r0, 0x0003		; Limit returned value from 0x00 - 0x02
		divw	r4, r3, r0		; Modulo 0x03 (1/3)
		mullw	r4, r4, r0		; Modulo 0x03 (2/3)
		sub	r3, r3, r4		; Modulo 0x03 (3/3)
		stw	r3, 0x0020 (r30)
	PELLET_KIND:
		lis	r3, 0x8021		;[rand]@h
		ori	r3, r3, 0x8070		;[rand]@l
		mtlr	r3
		blrl ;-->[rand]
		li	r0, 0x0002		; Limit returned value from 0x00 - 0x01
		divw	r4, r3, r0		; Modulo 0x02 (1/3)
		mullw	r4, r4, r0		; Modulo 0x02 (2/3)
		sub	r3, r3, r4		; Modulo 0x02A (3/3)
		stw	r3, 0x0024 (r30)
HIJACKED:
	lwz	r0, 0x002C (sp)









