#To be inserted at 800dce78
;╔════════════════════════════════════════════════════════════╗
;║ Make RNG Random Again                           Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [Initialise__6SystemFv 	sysDolphin.a system.cpp]
; NO STACK FRAME!!!

BODY:
	mftbl	r3                 ; [OSGetTick] inlined
	stw	r3, -0x7e90 (r13)  ; [next]

HIJACKED:
	lwz	r0, 0x0894 (sp)
