#To be inserted at 801d0ca4
;╔════════════════════════════════════════════════════════════╗
;║ Randomize Giant Egg birth                       Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [loadCard__11PlayerStateFR18RandomAccessStream]
;---Compiler Constants-----------------------------------------

;---Symbols----------------------------------------------------
randomInt__7NSystemFi = 0x8011e8a4
;---Constants--------------------------------------------------
acceptable_tekis_table_size = 20 
;---Macros-----------------------------------------------------
.macro	call	addr
lis	r12,      \addr@h
ori	r12, r12, \addr@l
mtlr	r12
blrl
.endm
;--------------------------------------------------------------

EXPOSITION:
	;

PROLOGUE:
	;

BODY:
	li	r3, acceptable_tekis_table_size - 1
	call	randomInt__7NSystemFi
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
		.byte 0x18   ;miurin
		.byte 0x19   ;otama
		.byte 0x1E   ;namazu
		.byte 0x1F   ;chappb
		.byte 0x20   ;swallob
		.byte 0x21   ;frow
		.balign 4
	SKIP_acceptable_tekis_table:
	mflr	r12
	lbzx	r3, r12, r3

EPILOGUE:
	;

HIJACKED:
	;bl	-->[get__17ParaParameters<i>Fi 	plugPikiYamashita.a TAItamago.cpp]   (don't)










