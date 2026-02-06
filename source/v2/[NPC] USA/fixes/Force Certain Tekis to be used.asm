#To be inserted at 8014a804
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

HIJACKED:
	li	r4, 1   ;do not clobber this!

BODY:
	stb	r4, 0x0164 + 0x00 (r3)   ; frog
	stb	r4, 0x0164 + 0x03 (r3)   ; chappy
	stb	r4, 0x0164 + 0x04 (r3)   ; swallow
	stb	r4, 0x0164 + 0x07 (r3)   ; palm
	stb	r4, 0x0164 + 0x08 (r3)   ; collec
	stb	r4, 0x0164 + 0x09 (r3)   ; kinoko
	stb	r4, 0x0164 + 0x0B (r3)   ; napkid
	stb	r4, 0x0164 + 0x0F (r3)   ; tank
	stb	r4, 0x0164 + 0x10 (r3)   ; mar
	stb	r4, 0x0164 + 0x11 (r3)   ; beatle
	stb	r4, 0x0164 + 0x12 (r3)   ; kabekuiA
	stb	r4, 0x0164 + 0x13 (r3)   ; kabekuiB
	stb	r4, 0x0164 + 0x14 (r3)   ; kabekuiC
	stb	r4, 0x0164 + 0x15 (r3)   ; tamago
	stb	r4, 0x0164 + 0x18 (r3)   ; miurin
	stb	r4, 0x0164 + 0x19 (r3)   ; otama
	stb	r4, 0x0164 + 0x1E (r3)   ; namazu
	stb	r4, 0x0164 + 0x1F (r3)   ; chappb
	stb	r4, 0x0164 + 0x20 (r3)   ; swallob
	stb	r4, 0x0164 + 0x21 (r3)   ; frow
	;This won't be needed once I edit collec's birth ID to be hollec
	stb	r4, 0x0164 + 0x0C (r3)   ; hollec
	;This is a hotfix for a crash if beatle spawns from tamago
	stb	r4, 0x0164 + 0x02 (r3)   ; iwagon

EPILOGUE:
	;













