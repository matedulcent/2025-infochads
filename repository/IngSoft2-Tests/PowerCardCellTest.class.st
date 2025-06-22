Class {
	#name : 'PowerCardCellTest',
	#superclass : 'PowerCellInteractionTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PowerCardCellTest >> testWhenTheShipWithWhiteCardsLandsOnTheCellThatDistributesCardsAndObtainsASpeedCardThenItUsesIt [

	| aGame aDiceSet aConfigureDiceSet aBoard aDeckOfPosibleCards |
	aDiceSet := RiggedDice new initializeWith: { 2 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 100. 1. 10. 1. 1 }. "100. 3. 30. 20. 10"
	aDeckOfPosibleCards := OrderedCollection withAll: {
			                       (AccelerationCard with: 1).
			                       (CancelationCard
				                        withObjective: (SpeedCard with: 1)
				                        toShip: 1).
			                       (MercenaryCard withHelpOf: 1).
			                       (RedoCard withFillOut: 1).
			                       (RepeatCard withObjective: 1).
			                       (SpeedCard with: 1) }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: aDeckOfPosibleCards
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 4.

	aGame start.
	aGame use: (SpeedCard with: 1) on: 1.

	self assert: (aGame positionOf: 1) equals: 3.
]

{ #category : 'tests' }
PowerCardCellTest >> testWhenTheShipWithWhiteCardsLandsOnTheCellThatHasRepeteCardAndASpeedCardThenItGainsTwoCardsAfterPlayingTheRepete [

	| aGame aDiceSet aConfigureDiceSet aBoard aDeckOfPosibleCards |
	aDiceSet := RiggedDice new initializeWith: { 2 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 100. 2. 10. 1. 1 }. "100. 3. 30. 20. 10"
	aDeckOfPosibleCards := OrderedCollection withAll: {
			                       (SpeedCard with: 1).
			                       (RepeatCard withObjective: 1) }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: aDeckOfPosibleCards
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 4.
	aGame use: (WhiteCard new) on: 1.
	aGame use: (WhiteCard new) on: 1.
	aGame start.
	aGame use: (RepeatCard withObjective: 1) on: 1.
	aGame use: (SpeedCard with: 1) on: 1.
	self assert: (aGame positionOf: 1) equals: 3
]

{ #category : 'tests' }
PowerCardCellTest >> testWhenTheShipWithWhiteCardsLandsOnTheCellThatOnlyHasAWhiteCardsThenNothingHappens [

	| aGame aDiceSet aConfigureDiceSet aBoard aDeckOfPosibleCards |
	aDiceSet := RiggedDice new initializeWith: { 2 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 100. 1. 10. 1. 1 }. "100. 3. 30. 20. 10"
	aDeckOfPosibleCards := OrderedCollection withAll: { WhiteCard new }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: aDeckOfPosibleCards
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 4.

	aGame start.

	self assert: (aGame positionOf: 1) equals: 3
]
