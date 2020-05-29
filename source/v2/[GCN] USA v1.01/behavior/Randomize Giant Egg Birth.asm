#To be inserted at 801d0ca4
;╔════════════════════════════════════════════════════════════╗
;║ Randomize Giant Egg birth                       Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [loadCard__11PlayerStateFR18RandomAccessStream]
;---Compiler Constants-----------------------------------------

;---Local Vars-------------------------------------------------

;---Symbols----------------------------------------------------
randomInt__7NSystemFi = 0x8011e8a4
rand                  = 0x80218070
spawnTeki__5BTekiFi   = 0x80146740
;---Constants--------------------------------------------------
acceptable_tekis_table_size = 21
;--------------------------------------------------------------

EXPOSITION:
	;

PROLOGUE:
	;

BODY:
	lis	r12,      randomInt__7NSystemFi@h
	ori	r12, r12, randomInt__7NSystemFi@l
	mtctr	r12
	li	r3, acceptable_tekis_table_size - 1
	bctrl	;-->[randomInt__7NSystemFi]
	bl	SKIP_acceptable_tekis_table
		.byte 0x00   ;frog
		.byte 0x03   ;chappy
		.byte 0x04   ;swallow
		.byte 0x07   ;palm
		.byte 0x08   ;collec
		.byte 0x09   ;kinoko
		.byte 0x0B   ;napkid
		.byte 0x0F   ;tank
		.byte 0x10   ;mar
		.byte 0x11   ;beatle
		.byte 0x12   ;kabekuiA
		.byte 0x13   ;kabekuiB
		.byte 0x14   ;kabekuiC
		.byte 0x15   ;tamago
		.byte 0x16   ;dororo
		.byte 0x18   ;miurin
		.byte 0x19   ;otama
		.byte 0x1E   ;namazu
		.byte 0x1F   ;chappb
		.byte 0x20   ;swallob
		.byte 0x21   ;frow
		.byte 0 ;padding
		.byte 0 ;padding
		.byte 0 ;padding
	SKIP_acceptable_tekis_table:
	mflr	r12
	lbzx	r3, r12, r3

EPILOGUE:
	;

HIJACKED:
	;