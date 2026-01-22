Class {
	#name : 'PowerCardCellTest',
	#superclass : 'PowerCellInteractionTest',
	#instVars : [
		'game'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PowerCardCellTest >> boardWithSize: aSize with: aCardDeck [

	^ Board
		  withSize: aSize
		  composedOf: (WormHole startingAt: 1 endingAt: 1)
		  playedWith: aCardDeck
		  andACellConfiguration: (RiggedDice new initializeWith:
				          { 0. 0. 0. 0. 0. 0. 100. 0. 0. 10. 0. 1. 1 })
]

{ #category : 'as yet unclassified' }
PowerCardCellTest >> gameAndBoardWithCards: aCardConfig [

	board := self boardWithSize: 100 with: (aCardConfig).
	game := self
		         gameWithDice: (RiggedDice new initializeWith: { 2 })
		         players: 1
		         laps: 4.
]

{ #category : 'tests' }
PowerCardCellTest >> testWhenTheCardCellGrabsTheFirstCardFromTheDeckThenTheSecondAndThirdAreAssignedToTheShip [

	self gameAndBoardWithCards: (CardDeck withCards: {
				 SpeedCard new.
				 SpeedCard new.
				 SpeedCard new }).
				
	game use: SpeedCard new on: 1.
	game use: SpeedCard new on: 1.
	game start.
	game use: SpeedCard new on: 1.

	self assert: (game positionOf: 1) equals: 5
]

{ #category : 'tests' }
PowerCardCellTest >> testWhenTheShipWithWhiteCardsLandsOnTheCellThatDistributesCardsAndObtainsASpeedCardThenItUsesIt [

	self gameAndBoardWithCards: (CardDeck withCards: {
				 AccelerationCard new.
				 CancelationCard new.
				 MercenaryCard new.
				 RedoCard new.
				 RepeatCard new.
				 SpeedCard new }).

	game start.
	game use: SpeedCard new on: 1.

	self assert: (game positionOf: 1) equals: 3
]

{ #category : 'tests' }
PowerCardCellTest >> testWhenTheShipWithWhiteCardsLandsOnTheCellThatHasRepeteCardAndASpeedCardThenItGainsTwoCardsAfterPlayingTheRepete [

	self gameAndBoardWithCards: (CardDeck withCards: {
				 SpeedCard new.
				 RepeatCard new.
				 WhiteCard new.
				 WhiteCard new }).

	game use: WhiteCard new on: 1.
	game use: WhiteCard new on: 1.
	game start.
	game use: (RepeatCard withObjective: 1) on: 1.
	game use: SpeedCard new on: 1.
	self assert: (game positionOf: 1) equals: 3
]

{ #category : 'tests' }
PowerCardCellTest >> testWhenTheShipWithWhiteCardsLandsOnTheCellThatOnlyHasAWhiteCardsThenNothingHappens [

	self gameAndBoardWithCards: (CardDeck withCards: { WhiteCard new }).

	game start.

	self assert: (game positionOf: 1) equals: 3
]
