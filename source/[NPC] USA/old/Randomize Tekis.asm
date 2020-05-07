#To be inserted at 8011b49c
;--------------------------------------------------
;Randomize Tekis                         Minty Meeo
;--------------------------------------------------
; NO STACK FRAME!!!
; r3 and r4 are spent
; r30 is pointer to the GEN Object


READ_FROM_GEN_OBJECT:
     lwz r3, 0x001C (r30)


bl SWITCHCASE__old_id_value
SWITCHCASE__old_id_value:
	mfspr r4, lr
	addi r4, r4, 0x0018	
	mulli r0, r3, 4
	add r0, r0, r4
	mtctr r0
	bctr
	
	b BASIC      ;00 frog
	b BASIC      ;01 iwagen
	b UNUSUAL    ;02 iwagon
	b BASIC      ;03 chappy
	b BASIC      ;04 swallow
	b BASIC      ;05 mizigen
	b UNUSUAL    ;06 qurione
	b BASIC      ;07 palm
	b ROUTER     ;08 collec
	b BOSS       ;09 kinoko
	b BOSS       ;0A shell
	b ROUTER     ;0B napkid
	b BASIC      ;0C hollec
	b UNUSUAL    ;0D pearl
	b UNUSUAL    ;0E rocpe
	b BASIC      ;0F tank
	b BOSS       ;10 mar
	b BOSS       ;11 beatle
	b BASIC      ;12 kabekuiA
	b BASIC      ;13 kabekuiB
	b BASIC      ;14 kabekuiC
	b BOSS       ;15 tamago
	b BOSS       ;16 dororo
	b LIMIT      ;17 hibaA
	b BOSS       ;18 miurin
	b BASIC      ;19 otama
	b UNUSUAL    ;1A usuba
	b UNUSUAL    ;1B yamash3
	b UNUSUAL    ;1C yamash4
	b UNUSUAL    ;1D yamash5
	b BASIC      ;1E namazu
	b BASIC      ;1F chappb
	b BASIC      ;20 swallob
	b BASIC      ;21 frow
	b UNUSUAL    ;22 nakata1


UNUSUAL:
BASIC:
	lis	r3, 0x8021		;[rand]@h
	ori	r3, r3, 0x8070		;[rand]@l
	mtlr	r3
	blrl ;-->[rand]
	li	r0, 0x0023		; Limit returned value from 0x00 - 0x22
	divw	r4, r3, r0		; Modulo 0x23 (1/3)
	mullw	r4, r4, r0		; Modulo 0x23 (2/3)
	sub	r3, r3, r4		; Modulo 0x23 (3/3)
	bl SWITCHCASE__basic_rng_value
	SWITCHCASE__basic_rng_value:
		mfspr r4, lr
		addi r4, r4, 0x0018	
		mulli r0, r3, 4
		add r0, r0, r4
		mtctr r0
		bctr
		
		b BASIC_OK   ;00 frog
		b BASIC      ;01 iwagen
		b BASIC      ;02 iwagon
		b BASIC_OK   ;03 chappy
		b BASIC_OK   ;04 swallow
		b BASIC_OK   ;05 mizigen
		b BASIC      ;06 qurione
		b BASIC_OK   ;07 palm
		b BASIC      ;08 collec
		b BASIC      ;09 kinoko
		b BASIC      ;0A shell
		b BASIC      ;0B napkid
		b BASIC      ;0C hollec
		b BASIC      ;0D pearl
		b BASIC      ;0E rocpe
		b BASIC_OK   ;0F tank
		b BASIC      ;10 mar
		b BASIC      ;11 beatle
		b BASIC_OK   ;12 kabekuiA
		b BASIC_OK   ;13 kabekuiB
		b BASIC_OK   ;14 kabekuiC
		b BASIC      ;15 tamago
		b BASIC      ;16 dororo
		b BASIC_OK   ;17 hibaA
		b BASIC      ;18 miurin
		b BASIC_OK   ;19 otama
		b BASIC      ;1A usuba
		b BASIC      ;1B yamash3
		b BASIC      ;1C yamash4
		b BASIC      ;1D yamash5
		b BASIC_OK   ;1E namazu
		b BASIC_OK   ;1F chappb
		b BASIC_OK   ;20 swallob
		b BASIC_OK   ;21 frow
		b BASIC      ;22 nakata1
	BASIC_OK:
	b WRITE_TO_GEN_OBJECT
BOSS:
	lis	r3, 0x8021		;[rand]@h
	ori	r3, r3, 0x8070		;[rand]@l
	mtlr	r3
	blrl ;-->[rand]
	li	r0, 0x0023		; Limit returned value from 0x00 - 0x22
	divw	r4, r3, r0		; Modulo 0x23 (1/3)
	mullw	r4, r4, r0		; Modulo 0x23 (2/3)
	sub	r3, r3, r4		; Modulo 0x23 (3/3)
	bl SWITCHCASE__boss_rng_value
	SWITCHCASE__boss_rng_value:
		mfspr r4, lr
		addi r4, r4, 0x0018	
		mulli r0, r3, 4
		add r0, r0, r4
		mtctr r0
		bctr
		
		b BOSS      ;00 frog
		b BOSS      ;01 iwagen
		b BOSS      ;02 iwagon
		b BOSS      ;03 chappy
		b BOSS      ;04 swallow
		b BOSS      ;05 mizigen
		b BOSS      ;06 qurione
		b BOSS      ;07 palm
		b BOSS      ;08 collec
		b BOSS_OK   ;09 kinoko
		b BOSS_OK   ;0A shell
		b BOSS      ;0B napkid
		b BOSS      ;0C hollec
		b BOSS      ;0D pearl
		b BOSS      ;0E rocpe
		b BOSS      ;0F tank
		b BOSS_OK   ;10 mar
		b BOSS_OK   ;11 beatle
		b BOSS      ;12 kabekuiA
		b BOSS      ;13 kabekuiB
		b BOSS      ;14 kabekuiC
		b BOSS      ;15 tamago
		b BOSS_OK   ;16 dororo
		b BOSS      ;17 hibaA
		b BOSS_OK   ;18 miurin
		b BOSS      ;19 otama
		b BOSS      ;1A usuba
		b BOSS      ;1B yamash3
		b BOSS      ;1C yamash4
		b BOSS      ;1D yamash5
		b BOSS      ;1E namazu
		b BOSS      ;1F chappb
		b BOSS      ;20 swallob
		b BOSS      ;21 frow
		b BOSS      ;22 nakata1
	BOSS_OK:
	b WRITE_TO_GEN_OBJECT
LIMIT:
	lis	r3, 0x8021		;[rand]@h
	ori	r3, r3, 0x8070		;[rand]@l
	mtlr	r3
	blrl ;-->[rand]
	li	r0, 0x0023		; Limit returned value from 0x00 - 0x22
	divw	r4, r3, r0		; Modulo 0x23 (1/3)
	mullw	r4, r4, r0		; Modulo 0x23 (2/3)
	sub	r3, r3, r4		; Modulo 0x23 (3/3)
	bl SWITCHCASE__limit_rng_value
	SWITCHCASE__limit_rng_value:
		mfspr r4, lr
		addi r4, r4, 0x0018	
		mulli r0, r3, 4
		add r0, r0, r4
		mtctr r0
		bctr
		
		b LIMIT_OK   ;00 frog
		b LIMIT      ;01 iwagen
		b LIMIT      ;02 iwagon
		b LIMIT_OK   ;03 chappy
		b LIMIT      ;04 swallow
		b LIMIT_OK   ;05 mizigen
		b LIMIT      ;06 qurione
		b LIMIT_OK   ;07 palm
		b LIMIT      ;08 collec
		b LIMIT      ;09 kinoko
		b LIMIT      ;0A shell
		b LIMIT      ;0B napkid
		b LIMIT      ;0C hollec
		b LIMIT      ;0D pearl
		b LIMIT      ;0E rocpe
		b LIMIT_OK   ;0F tank
		b LIMIT      ;10 mar
		b LIMIT      ;11 beatle
		b LIMIT_OK   ;12 kabekuiA
		b LIMIT_OK   ;13 kabekuiB
		b LIMIT_OK   ;14 kabekuiC
		b LIMIT      ;15 tamago
		b LIMIT      ;16 dororo
		b LIMIT_OK   ;17 hibaA
		b LIMIT      ;18 miurin
		b LIMIT_OK   ;19 otama
		b LIMIT      ;1A usuba
		b LIMIT      ;1B yamash3
		b LIMIT      ;1C yamash4
		b LIMIT      ;1D yamash5
		b LIMIT_OK   ;1E namazu
		b LIMIT_OK   ;1F chappb
		b LIMIT      ;20 swallob
		b LIMIT_OK   ;21 frow
		b LIMIT      ;22 nakata1
	LIMIT_OK:
	b WRITE_TO_GEN_OBJECT
ROUTER:
	lis	r3, 0x8021		;[rand]@h
	ori	r3, r3, 0x8070		;[rand]@l
	mtlr	r3
	blrl ;-->[rand]
	li	r0, 0x0023		; Limit returned value from 0x00 - 0x22
	divw	r4, r3, r0		; Modulo 0x23 (1/3)
	mullw	r4, r4, r0		; Modulo 0x23 (2/3)
	sub	r3, r3, r4		; Modulo 0x23 (3/3)
		cmpwi r3, 0x08   ;collec
		beq- ROUTER_OK
		cmpwi r3, 0x0B   ;hollec
		beq- ROUTER_OK
		b ROUTER
	ROUTER_OK:
	b WRITE_TO_GEN_OBJECT


WRITE_TO_GEN_OBJECT:
	stw r3, 0x001C (r30)

HIJACKED:
	lwz	r0, 0x001C (sp)











