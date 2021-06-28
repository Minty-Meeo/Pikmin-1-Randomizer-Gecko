#To be inserted at 80073e20
;╔════════════════════════════════════════════════════════════╗
;║ Change Memory Card Filename                     Minty Meeo ║
;║ (checkUseFile)                                             ║
;╚════════════════════════════════════════════════════════════╝
; In function [checkUseFile__10MemoryCardFv]
; NO STACK FRAME!!!
; r31 is pointer to string

;---------------------------------------------------------------------------Tail-
;NOTE: add this line to the Gecko Code for a more correct strncmp
;04073e70 38a0001a
;--------------------------------------------------------------------------------

bl SKIP
.long 0x50696B6D
.long 0x696E2052
.long 0x616E646F
.long 0x6D697A65
.long 0x72206461
.long 0x74614669
.long 0x6C650000
SKIP:
mflr	r31

\

