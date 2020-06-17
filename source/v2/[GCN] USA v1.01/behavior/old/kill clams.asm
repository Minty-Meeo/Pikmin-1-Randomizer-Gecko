#To be inserted at 8014367c







BODY:
	lwz	r31, 0x0418 (r4)
	li	r0, 0
	stw	r0, 0x0410 (r31)
	;li	r0, 1
	;stw	r0, 0x031C (r31)

EPILOGUE:
	;

HIJACKED:
	lwz	r0, 0x0418 (r4)