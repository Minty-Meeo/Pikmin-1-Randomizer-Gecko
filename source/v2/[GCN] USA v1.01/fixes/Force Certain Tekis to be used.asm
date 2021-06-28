#To be inserted at 8014a800
;╔════════════════════════════════════════════════════════════╗
;║ Force Certain Tekis to be used                  Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [__ct__7TekiMgrFv 	plugPikiNakata.a tekimgr.cpp]
;---Compiler Constants-----------------------------------------

;---Local Vars-------------------------------------------------

;---Symbols----------------------------------------------------
randomInt__7NSystemFi = 0x8011e8a4
rand                  = 0x80218070
spawnTeki__5BTekiFi   = 0x80146740
setUsingTypeTable__7TekiMgrFb = 0x8014ae78
;---Constants--------------------------------------------------

;---Macros-----------------------------------------------------
.macro	call addr
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
	li	r4, 1
	
	stb	r4, 0x0164 (r3)   ;0x00 frog
	stb	r4, 0x0167 (r3)   ;0x03 chappy
	stb	r4, 0x0168 (r3)   ;0x04 swallow
	stb	r4, 0x016B (r3)   ;0x07 palm
	stb	r4, 0x016C (r3)   ;0x08 collec
	stb	r4, 0x016D (r3)   ;0x09 kinoko
	stb	r4, 0x016F (r3)   ;0x0B napkid
	stb	r4, 0x0173 (r3)   ;0x0F tank
	stb	r4, 0x0174 (r3)   ;0x10 mar
	stb	r4, 0x0175 (r3)   ;0x11 beatle
	stb	r4, 0x0176 (r3)   ;0x12 kabekuiA
	stb	r4, 0x0177 (r3)   ;0x13 kabekuiB
	stb	r4, 0x0178 (r3)   ;0x14 kabekuiC
	stb	r4, 0x0179 (r3)   ;0x15 tamago
	stb	r4, 0x017C (r3)   ;0x18 miurin
	stb	r4, 0x017D (r3)   ;0x19 otama
	stb	r4, 0x0182 (r3)   ;0x1E namazu
	stb	r4, 0x0183 (r3)   ;0x1F chappb
	stb	r4, 0x0184 (r3)   ;0x20 swallob
	stb	r4, 0x0185 (r3)   ;0x21 frow
	;This won't be needed once I edit collec's birth ID to be hollec
	stb	r4, 0x0170 (r3)   ;0x0C hollec

EPILOGUE:
	;

HIJACKED:
	;lwz	r3, 0x0008 (sp)   ;not needed












