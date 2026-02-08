#To be inserted at 8015c4f0
# r31 has GoalItem*

lwz	r3, 0x02EC (r31)  # r31->_2EC is `AState<AICreature>* mCurrentState`
lwz	r3, 0x0004 (r3)   # r31->_2EC->_04 is `AState<AICreature>::mStateId`
cmpwi	r3, 5             # `if (stateID < GoalAI::GOAL_BootInit)`

# Following this Gecko Code, a `bge-` instruction is found.
