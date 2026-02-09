#To be inserted at 800faa48
__SDA_BASE__      = 0x8049f360
PTR_s_pikmin1_dat = 0x8049df98

; Copy this assembled instruction and create an 04 codetype at the insertion address.
lwz	r5, PTR_s_pikmin1_dat - __SDA_BASE__ (r13)
