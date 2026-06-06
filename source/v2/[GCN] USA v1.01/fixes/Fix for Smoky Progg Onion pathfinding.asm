#To be inserted at 800f2b94
# r28 has GoalItem*
# The task is to change `if (dist < minDist)` to `if (dist < minDist && stateID < GoalAI::GOAL_BootInit)``

fcmpo	cr0, f1, f31      # Hijacked instruction, `if (dist < minDist)`
bge-	END               # Short-circuit evaluation since both conditions use `bge-`
lwz	r3, 0x02E4 (r28)  # r28->_2E4 is `AState<AICreature>* mCurrentState`
lwz	r3, 0x0004 (r3)   # r28->_2E4->_04 is `AState<AICreature>::mStateId`
cmpwi	cr0, r3, 5        # `if (stateID < GoalAI::GOAL_BootInit)`

END:
# Following this Gecko Code, a `bge-` instruction is found.
