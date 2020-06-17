#To be inserted at 80075138
;╔════════════════════════════════════════════════════════════╗
;║ Change Memory Card Filename                     Minty Meeo ║
;║ (makeDefaultFile)                                          ║
;╚════════════════════════════════════════════════════════════╝
; In function [makeDefaultFile__10MemoryCardFv]
; NO STACK FRAME!!!
; r4 is pointer to string

bl SKIP
	.asciz	"Pikmin Randomizer 2.0 dataFile"
	.balign 4
SKIP:
mflr	r4




