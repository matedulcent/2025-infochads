Class {
	#name : 'SkipCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SkipCardTest >> testWhenThereAre3SpaceShipsAndOneSkipAndOneRedoArePlayedThenTheNextTwoPlayersLoseItsTurns [

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          SkipCard new.
				          RedoCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 1 })
		         players: 3.

	aGame use: SkipCard new on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame positionOf: 2) equals: 2.
	self assert: (aGame positionOf: 1) equals: 1
]

{ #category : 'tests' }
SkipCardTest >> testWhenThereAre3SpaceShipsAndSkipCardIsPlayedThenTheNextSpaceShipToPlayIsSkipped [

	| aGame |
	board := self
		         boardWithSize: 100
		         andDeck: (CardDeck withCards: { SkipCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 1. 2 })
		         players: 3.

	aGame use: SkipCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 3.
	self assert: (aGame positionOf: 2) equals: 2.
	self assert: (aGame positionOf: 1) equals: 1
]

{ #category : 'tests' }
SkipCardTest >> testWhenThereAre3SpaceShipsAndTwoSkipCardsArePlayedThenTheNext2SpaceShipToPlayIsSkipped [

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          SkipCard new.
				          SkipCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 1 })
		         players: 3.

	aGame use: SkipCard new on: 1.
	aGame use: SkipCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame positionOf: 2) equals: 2.
	self assert: (aGame positionOf: 1) equals: 1
]
