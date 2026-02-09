#To be inserted at 8030fb23
; WARNING: This must not be longer than 11 characters long in order to fit within the original string.
; Real hardware and the Wii System Menu only recognize title data with names 12 characters or shorter.
; Copy this assembled string and create an 06 codetype at the insertion address.
.asciz	"RandoV2.dat"
.balign 4
