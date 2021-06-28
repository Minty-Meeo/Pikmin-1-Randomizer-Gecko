#To be inserted at 80265764
;╔════════════════════════════════════════════════════════════╗
;║ Fix Smoky Progg Crash                           Minty Meeo ║
;║ Smoky Progg sometimes gets a nullptr when checking if      ║
;║ nearby route nodes are active.                             ║
;╚════════════════════════════════════════════════════════════╝
; In function [act__14TAIAgoGoalPathFR4Teki]
; r3 is pointer to route node (or nullptr)
; SPENT: {r0,r4}

BODY:
	mr.	r0, r3           ; Power move.  I'm both setting the default value of r0, and checking if it's a nullptr
	beq-	AVOID_CRASH      ; DO NOT DEREFERENCE IF IT IS A NULLPTR
	lbz	r0, 0x0038 (r3)     ; Otherwise dereference away lol
	AVOID_CRASH:

HIJACKED:
	;already taken care of
