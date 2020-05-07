#To be inserted at 800b0854
;╔════════════════════════════════════════════════════════════╗
;║ Fix No Onion Routing Crash                      Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In fuction [doLift__12ActTransportFv]
; NO STACK FRAME!!!
; r3 is pointer to route node

NULLPTR_CHECK:
	cmpwi	r3, 0
	bne-	ORIGINAL_CODE

FUCKFUCKFUCK:
	li	r3, -1
	b	END

ORIGINAL_CODE:
	lwz	r12, 0 (r3)
	lwz	r12, 0x0170 (r12)
	mtlr	r12
	blrl	

END: