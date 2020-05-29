#To be inserted at 8011b49c
;╔════════════════════════════════════════════════════════════╗
;║ Randomize Tekis                                 Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [doRead__13GenObjectTekiFR18RandomAccessStream]
; NO STACK FRAME!!!
; r30 is pointer to the GEN Object
; SPENT: {r3,r4}



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
	
	b BASIC      ;00 frog      Yellow Wollywog
	b BASIC      ;01 iwagen    Iwagen
	b LIMIT      ;02 iwagon    Rolling Boulder
	b LIMIT      ;03 chappy    Dwarf Bulborb
	b BASIC      ;04 swallow   Spotty Bulborb
	b LIMIT      ;05 mizigen   Honeywisps Generator
	b LIMIT      ;06 qurione   Lone Honeywisp (invalid)
	b LIMIT      ;07 palm      Pellet Posy
	b BASIC      ;08 collec    Breadbug
	b SUBBOSS    ;09 kinoko    Puffstool
	b SUBBOSS    ;0A shell     Pearly Clamclamp
	b BASIC      ;0B napkid    Snitchbug
	b BASIC      ;0C hollec    Breadbug Nest
	b SUBBOSS    ;0D pearl     Lone Pearl (invalid)
	b SUBBOSS    ;0E rocpe     Lone Rocket Pearl (invalid)
	b BASIC      ;0F tank      Fiery Blowhog
	b BASIC      ;10 mar       Puffy Blowhog
	b SUBBOSS    ;11 beatle    Armored Cannon Beetle
	b LIMIT      ;12 kabekuiA  Female Sheargrub
	b LIMIT      ;13 kabekuiB  Male Sheargrub
	b LIMIT      ;14 kabekuiC  Shearwig
	b SUBBOSS    ;15 tamago    Giant Egg
	b SUBBOSS    ;16 dororo    Smoky Progg
	b LIMIT      ;17 hibaA     Fire Geyser
	b SUBBOSS    ;18 miurin    Mamuta
	b LIMIT      ;19 otama     Wogpole
	b UNUSUAL    ;1A usuba     Usuba (invalid)
	b UNUSUAL    ;1B yamash3   (invalid)
	b UNUSUAL    ;1C yamash4   (invalid)
	b UNUSUAL    ;1D yamash5   (invalid)
	b LIMIT      ;1E namazu    Water Dumple
	b LIMIT      ;1F chappb    Dwarf Bulbear
	b BASIC      ;20 swallob   Spotty Bulbear
	b BASIC      ;21 frow      White Wollywog
	b UNUSUAL    ;22 nakata1   (invalid)


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
		
		b BASIC_OK      ;00 frog
		b BASIC         ;01 iwagen
		b BASIC         ;02 iwagon
		b BASIC         ;03 chappy
		b BASIC_OK      ;04 swallow
		b BASIC         ;05 mizigen
		b BASIC         ;06 qurione
		b BASIC         ;07 palm
		b BASIC_UPGRADE ;08 collec
		b BASIC_UPGRADE ;09 kinoko
		b BASIC         ;0A shell
		b BASIC_UPGRADE ;0B napkid
		b BASIC         ;0C hollec
		b BASIC         ;0D pearl
		b BASIC         ;0E rocpe
		b BASIC_OK      ;0F tank
		b BASIC_UPGRADE ;10 mar
		b BASIC_UPGRADE ;11 beatle
		b BASIC         ;12 kabekuiA
		b BASIC         ;13 kabekuiB
		b BASIC         ;14 kabekuiC
		b BASIC_UPGRADE ;15 tamago
		b BASIC         ;16 dororo
		b BASIC         ;17 hibaA
		b BASIC_UPGRADE ;18 miurin
		b BASIC         ;19 otama
		b BASIC         ;1A usuba
		b BASIC         ;1B yamash3
		b BASIC         ;1C yamash4
		b BASIC         ;1D yamash5
		b BASIC         ;1E namazu
		b BASIC         ;1F chappb
		b BASIC_OK      ;20 swallob
		b BASIC_OK      ;21 frow
		b BASIC         ;22 nakata1
	BASIC_UPGRADE:
		lwz	r4, 0x7B24 (r13)   ; static int upgrade_counter
		cmpwi	r4, 1              ; if (upgrade_counter > 2)
		bgt-	BASIC                 ; Try again
		addi	r4, r4, 1          ; upgrade_counter++
		stw	r4, 0x7B24 (r13)   ; store upgrade_counter
		
		lwz	r4, 0x0018 (r30)      ; Dereference to parameters (1/2)
		lwz	r4, 0x0034 (r4)       ; Dereference to parameters (2/2)
		lwz	r4, 0x0000 (r4)       ; Dereference to ints (1/2)
                lwz     r4, 0x0000 (r4)       ; Dereference to ints (2/2)
		li	r31, 2                ; We want 2 fallwaters for most tekis
		cmpwi	r3, 0x0015            ; But if the upgrade teki is tamago
		bne-	0x0008                ; (skip otherwise)
		li	r31, 8                ; We want 8 fallwaters for tamago
		stw	r31, 0x0008 (r4)      ; Write to GEN Obejct (1/2)
		stw	r31, 0x000C (r4)      ; Write to GEN Object (2/2)
		
		lwz	r4, 0x0018 (r30)      ; Dereference to parameters (1/2)
		lwz	r4, 0x0034 (r4)       ; Dereference to parameters (2/2)
		lwz	r4, 0x0004 (r4)       ; Dereference to floats (1/2)
                lwz     r4, 0x0000 (r4)       ; Dereference to floats (2/2)
		stw	r31, 0x0010 (r4)      ; Write to GEN Object
	BASIC_OK:
	b WRITE_TO_GEN_OBJECT
SUBBOSS:
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
		
		b SUBBOSS      ;00 frog
		b SUBBOSS      ;01 iwagen
		b SUBBOSS      ;02 iwagon
		b SUBBOSS      ;03 chappy
		b SUBBOSS      ;04 swallow
		b SUBBOSS      ;05 mizigen
		b SUBBOSS      ;06 qurione
		b SUBBOSS      ;07 palm
		b SUBBOSS      ;08 collec
		b SUBBOSS_OK   ;09 kinoko
		b SUBBOSS      ;0A shell
		b SUBBOSS      ;0B napkid
		b SUBBOSS      ;0C hollec
		b SUBBOSS      ;0D pearl
		b SUBBOSS      ;0E rocpe
		b SUBBOSS      ;0F tank
		b SUBBOSS_OK   ;10 mar
		b SUBBOSS_OK   ;11 beatle
		b SUBBOSS      ;12 kabekuiA
		b SUBBOSS      ;13 kabekuiB
		b SUBBOSS      ;14 kabekuiC
		b SUBBOSS      ;15 tamago
		b SUBBOSS_OK   ;16 dororo
		b SUBBOSS      ;17 hibaA
		b SUBBOSS_OK   ;18 miurin
		b SUBBOSS      ;19 otama
		b SUBBOSS      ;1A usuba
		b SUBBOSS      ;1B yamash3
		b SUBBOSS      ;1C yamash4
		b SUBBOSS      ;1D yamash5
		b SUBBOSS      ;1E namazu
		b SUBBOSS      ;1F chappb
		b SUBBOSS      ;20 swallob
		b SUBBOSS      ;21 frow
		b SUBBOSS      ;22 nakata1
	SUBBOSS_OK:
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
		
		b LIMIT      ;00 frog
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
		b LIMIT      ;0F tank
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
		b LIMIT      ;21 frow
		b LIMIT      ;22 nakata1
	LIMIT_OK:
	cmpwi	r3, 0x0005            ; Mizigen needs some special values to work proprerly.
	bne-	WRITE_TO_GEN_OBJECT   ; But if this isn't Mizigen, skip this stuff.
	
	lwz	r4, 0x0018 (r30)      ; Dereference to parameters (1/2)
	lwz	r4, 0x0034 (r4)       ; Dereference to parameters (2/2)
	lwz	r4, 0x0000 (r4)       ; Dereference to ints (1/2)
        lwz     r4, 0x0000 (r4)       ; Dereference to ints (2/2)
	li	r31, -2               ; PARAMETER_0 is always -2
	stw	r31, 0x0010 (r4)      ; Write to GEN Object
	
	lwz	r4, 0x0018 (r30)      ; Dereference to parameters (1/2)
	lwz	r4, 0x0034 (r4)       ; Dereference to parameters (2/2)
	lwz	r4, 0x0004 (r4)       ; Dereference to floats (1/2)
	lwz     r4, 0x0000 (r4)       ; Dereference to floats (2/2)
	lis	r31, 0x43FA           ; TERRITORY_RANGE is always 500.0f
	stw	r31, 0x0008 (r4)      ; Write to GEN Object
	b WRITE_TO_GEN_OBJECT


WRITE_TO_GEN_OBJECT:
	stw r3, 0x001C (r30)

HIJACKED:
	lwz	r0, 0x001C (sp)











