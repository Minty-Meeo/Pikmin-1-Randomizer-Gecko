#To be inserted at 8011b49c

BODY:
	li	r0, 0x00   ;frog
	stw	r0, 0x001C (r30)

HIJACKED:
	lwz	r0, 0x001C (sp)