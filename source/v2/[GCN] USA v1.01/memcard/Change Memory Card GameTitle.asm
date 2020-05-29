#To be inserted at 80074b40
;╔════════════════════════════════════════════════════════════╗
;║ Change Memory Card GameTitle                    Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [initBannerArea__10MemoryCardFR8CARDStatPc]
; NO STACK FRAME!!!
; r4 is pointer to string

bl SKIP
.long 0x50696B6D
.long 0x696E2052
.long 0x616E646F
.long 0x6D697A65
.long 0x72000000
SKIP:
mflr	r4



