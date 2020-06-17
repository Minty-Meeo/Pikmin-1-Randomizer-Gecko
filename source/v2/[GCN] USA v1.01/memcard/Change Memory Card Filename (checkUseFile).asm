#To be inserted at 80073e20
;╔════════════════════════════════════════════════════════════╗
;║ Change Memory Card Filename                     Minty Meeo ║
;║ (checkUseFile)                                             ║
;╚════════════════════════════════════════════════════════════╝
; In function [checkUseFile__10MemoryCardFv]
; NO STACK FRAME!!!
; r31 is pointer to string

;---------------------------------------------------------------------------Tail-

;--------------------------------------------------------------------------------

bl SKIP
	.asciz	"Pikmin Randomizer 2.0 dataFile"
	.balign 4
SKIP:
mflr	r31



