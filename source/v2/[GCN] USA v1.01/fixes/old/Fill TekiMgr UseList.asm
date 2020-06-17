#To be inserted at 8014a7fc
;╔════════════════════════════════════════════════════════════╗
;║ Fill TekiMgr UseList                            Minty Meeo ║
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

;--------------------------------------------------------------

EXPOSITION:
	li	r4, 1

PROLOGUE:
	;

BODY:
	lis	r12,      setUsingTypeTable__7TekiMgrFb@h
	ori	r12, r12, setUsingTypeTable__7TekiMgrFb@l
	mtlr	r12
	blrl	;-->[setUsingTypeTable__7TekiMgrFb]
	
	li	r4, 0
	stb	r4, 0x017E (r3)
	stb	r4, 0x017F (r3)
	stb	r4, 0x0180 (r3)
	stb	r4, 0x0181 (r3)
	stb	r4, 0x0186 (r3)

EPILOGUE:
	;

HIJACKED:
	;
