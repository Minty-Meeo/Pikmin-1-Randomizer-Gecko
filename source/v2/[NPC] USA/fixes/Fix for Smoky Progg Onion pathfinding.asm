#To be inserted at 800f2b94
# r28 has GoalItem*

lwz	r3, 0x02E4 (r28)  # r28->_2E4 is `AState<AICreature>* mCurrentState`
lwz	r3, 0x0004 (r3)   # r28->_2E4->_04 is `AState<AICreature>::mStateId`
cmpwi	r3, 5             # `if (stateID < GoalAI::GOAL_BootInit)`

# Following this Gecko Code, a `bge-` instruction is found.
