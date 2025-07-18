Class {
	#name : 'PowerCardCellTest',
	#superclass : 'PowerCellInteractionTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PowerCardCellTest >> testWhenMultipleShipsLandOnMultipleCardCellsThenTheyAllAquireTheCardOnIt [

	| aGame aDiceSet aConfigureDiceSet aBoard aDeckOfPosibleCards |
	aDiceSet := RiggedDice new initializeWith: { 2. 10 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 100. 0. 0. 1. 10. 0. 1. 1 }.
	aDeckOfPosibleCards := CardDeck withCards: {
			                       WhiteCard new.
			                       WhiteCard new.
			                       WhiteCard new.
			                       SpeedCard new.
			                       SpeedCard new }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: aDeckOfPosibleCards
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 4.

	aGame start.
	aGame use: (SpeedCard with: 1) on: 1.
	aGame use: (SpeedCard with: 1) on: 2.

	self assert: (aGame positionOf: 1) equals: 3.
	self assert: (aGame positionOf: 2) equals: 11
]

{ #category : 'tests' }
PowerCardCellTest >> testWhenTheCardCellGrabsTheFirstCardFromTheDeckThenTheSecondAndThirdAreAssignedToTheShip [

	| aGame aDiceSet aConfigureDiceSet aBoard aDeckOfPosibleCards |
	aDiceSet := RiggedDice new initializeWith: { 2 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 100. 0. 0. 1. 10. 0. 1. 1 }.
	aDeckOfPosibleCards := CardDeck withCards: {
			                       SpeedCard new.
			                       SpeedCard new.
			                       SpeedCard new }.
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

	aGame use: (SpeedCard with: 1) on: 1.
	aGame use: (SpeedCard with: 1) on: 1.
	aGame start.
	aGame use: (SpeedCard with: 1) on: 1.

	self assert: (aGame positionOf: 1) equals: 5
]

{ #category : 'tests' }
PowerCardCellTest >> testWhenTheShipWithWhiteCardsLandsOnTheCellThatDistributesCardsAndObtainsASpeedCardThenItUsesIt [

	| aGame aDiceSet aConfigureDiceSet aBoard aDeckOfPosibleCards |
	aDiceSet := RiggedDice new initializeWith: { 2 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 100. 0. 0. 1. 10. 0. 1. 1 }.
	aDeckOfPosibleCards := CardDeck withCards: {
			                       AccelerationCard new.
			                       CancelationCard new.
			                       MercenaryCard new.
			                       RedoCard new.
			                       RepeatCard new.
			                       SpeedCard new }.
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

	self assert: (aGame positionOf: 1) equals: 3
]

{ #category : 'tests' }
PowerCardCellTest >> testWhenTheShipWithWhiteCardsLandsOnTheCellThatHasRepeteCardAndASpeedCardThenItGainsTwoCardsAfterPlayingTheRepete [

	| aGame aDiceSet aConfigureDiceSet aBoard aDeckOfPosibleCards |
	aDiceSet := RiggedDice new initializeWith: { 2 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 100. 0. 0. 2. 10. 0. 1. 1 }.
	aDeckOfPosibleCards := CardDeck withCards: {
			                       SpeedCard new. 
			                       RepeatCard new}.
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
	aGame use: WhiteCard new on: 1.
	aGame use: WhiteCard new on: 1.
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
		                     { 0. 0. 0. 0. 0. 0. 100. 0. 0. 1. 10. 0. 1. 1 }.
	aDeckOfPosibleCards := CardDeck withCards: { WhiteCard }.
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
