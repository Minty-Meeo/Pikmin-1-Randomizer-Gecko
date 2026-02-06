#To be inserted at 800461a0
;╔════════════════════════════════════════════════════════════╗
;║ Make RNG Random Again                           Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [Initialise__6SystemFv 	sysDolphin.a system.cpp]
; NO STACK FRAME!!!

BODY:
	mftbl	r3                 ; [OSGetTick] inlined
	stw	r3, 0x2AD8 (r13)   ; [next]

HIJACKED:
	lmw	r27, 0x003C (sp)
