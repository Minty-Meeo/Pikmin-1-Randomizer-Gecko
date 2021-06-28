#To be inserted at 80075138
;╔════════════════════════════════════════════════════════════╗
;║ Change Memory Card Filename                     Minty Meeo ║
;║ (makeDefaultFile)                                          ║
;╚════════════════════════════════════════════════════════════╝
; In function [makeDefaultFile__10MemoryCardFv]
; NO STACK FRAME!!!
; r4 is pointer to string

bl SKIP
.long 0x50696B6D
.long 0x696E2052
.long 0x616E646F
.long 0x6D697A65
.long 0x72206461
.long 0x74614669
.long 0x6C650000
SKIP:
mflr	r4




