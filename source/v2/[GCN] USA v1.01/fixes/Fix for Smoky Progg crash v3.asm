#To be inserted at 801a91e8
  lwz       r0, 0x034C (r29)   # Path waypoint count
  lwz       r3, 0x0348 (r29)   # Buffer size
  cmpw      r0, r3
  blt+      END                # if (r0 < r3)
  mr        r0, r3             #   r0 = r3

END:

