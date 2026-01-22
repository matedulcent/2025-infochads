Class {
	#name : 'DoubleTurnCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DoubleTurnCardTest >> testWhenThereAre3SpaceShipsAndOneDoubleTurnCardIsPlayedThenTheNextSpaceShipToMovePlaysTwice [

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          DoubleCard new.
				          WhiteCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 1. 2 })
		         players: 3.

	aGame use: DoubleCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 1) equals: 4
]

{ #category : 'tests' }
DoubleTurnCardTest >> testWhenThereAre3SpaceShipsAndOneDoubleTurnCardIsPlayedThenTheNextSpaceShipToMovePlaysTwiceAndTheRestPlayAfter [

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          DoubleCard new.
				          WhiteCard new }).

	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 1. 2. 10. 11 })
		         players: 3.

	aGame use: DoubleCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 12.
	self assert: (aGame positionOf: 2) equals: 11.
	self assert: (aGame positionOf: 1) equals: 4
]
