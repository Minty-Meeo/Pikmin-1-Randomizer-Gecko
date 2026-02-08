#To be inserted at 80226cc0
;╔════════════════════════════════════════════════════════════╗
;║ Randomize Giant Egg birth                       Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [act__9TAIAhatchFR4Teki]
;---Compiler Constants-----------------------------------------

;---Symbols----------------------------------------------------
randomInt__7NSystemFi = 0x801c3abc
;---Constants--------------------------------------------------
acceptable_tekis_table_size = 20 
;---Macros-----------------------------------------------------
.macro	call	addr
lis	r11,      \addr@h
ori	r11, r11, \addr@l
mtlr	r11
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
	mflr	r11
	lbzx	r4, r11, r3

EPILOGUE:
	; This spot in `TAIAhatch::act` is totally screwing me over in NPC!, because `ParaParameters<int>::get` got inlined and the
	; instruction scheduling put the lwz instruction to access the teki's child teki after LITERALLY EVERYTHING ELSE. r12 isn't
	; clobbered by `NSystem::randomInt`, so I can be lazy about EABI for that, but nothing can prevent r3 from being clobbered.
	;lwz	r12, 0x0000 (r30)  ; `this->__vt`
	;lwz	r12, 0x01A0 (r12)  ; `BTeki::spawnTeki` in VTable.  `mtctr` instruction follows this Gecko Code.
	mr	r3, r30            ; r3 for thiscall, r4 was set above.

HIJACKED:
	;lwz	r4, 0x0084 (r4)   (don't)










