#To be inserted at 800ebdd8
;╔════════════════════════════════════════════════════════════╗
;║ Approaching Onions Unlocks Everything           Minty Meeo ║
;║                                                            ║
;╚════════════════════════════════════════════════════════════╝
; In function [startBoot__8GoalItemFv]
; NO STACK FRAME!!!
; r3 is bit index
; r4 is the "stamp bit"
; r5 is the bitfield

;---------------------------------------------------------------------------Tail-
;In function [setDisplayPikiCount__11PlayerStateFi]
;Plucking first piki does not unlock Onions
;040805fc 980301ac   stb	r0, 0x01AC (r3)
;         60000000   nop
;In function [cleanup__15PikiNukareStateFP4Piki]
;Yellow Piki "SetDisplayPikiCount"
;040d73b8 98030184   stb	r0, 0x0184 (r3)
;         60000000   nop
;In function [cleanup__15PikiNukareStateFP4Piki]
;Blue Piki "SetDisplayPikiCount"
;040d7420 98030184   stb	r0, 0x0184 (r3)
;         60000000   nop
;--------------------------------------------------------------------------------

addi	r0, r3, 0          ; r0 = r3 (bit index) + 0
slw	r0, r4, r0         ; Shift stamp bit into place
or	r5, r5, r0         ; Write stamp bit to bitfield
stb	r5, 0x01AC (r6)    ; Store value in pikis bitfield as well


REPAIR:
	li	r4, 1      ; Reset stamp bit

HIJACKED:
	addi	r0, r3, 3  ; r0 = r3 (bit index) + 3