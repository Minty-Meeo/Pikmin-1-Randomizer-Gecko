#To be inserted at 8026572c
# r0 contains Path waypoint count (`BTeki::mRouteWayPointCount`)
# r4 contains Path current index (`YTeki::mTableIndex`)
	lwz	r3, 0x0350 (r29)   # Buffer size (`BTeki::mRouteWayPointMax`)
	cmpw	cr1, r4, r3        # if (r4 < r3)
	cmpw	cr0, r4, r0        # if (r4 < r0) # HIJACKED
	crand	0, 0, 4            # OR the two conditions
# After this C2 code, a `blt-` instruction is executed.
