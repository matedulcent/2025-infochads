Class {
	#name : 'ReverseCardTest',
	#superclass : 'SpeedCardTest',
	#instVars : [
		'game'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ReverseCardTest >> testWhenThereAre3SpaceShipsAndOneReverseAndOneRedoArePlayedThenTheyPlayInTheCorrectTurnOrder [

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          ReverseCard new.
				          RedoCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5 })
		         players: 3.

	aGame use: ReverseCard new on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 1) equals: 6
]

{ #category : 'tests' }
ReverseCardTest >> testWhenThereAre3SpaceShipsAndReverseCardIsPlayedThenTheyPlayInTheInverseTurnOrder [

	| aGame |
	board := self
		         boardWithSize: 100
		         andDeck: (CardDeck withCards: { ReverseCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5 })
		         players: 3.

	aGame use: ReverseCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 6.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 1) equals: 1
]

{ #category : 'tests' }
ReverseCardTest >> testWhenThereAre3SpaceShipsAndReverseCardIsPlayedThenTheyPlayInTheInverseTurnOrderIndefinitely [

	| aGame |
	board := self
		         boardWithSize: 100
		         andDeck: (CardDeck withCards: { ReverseCard new }).

	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 5. 6. 7. 8 })
		         players: 3.

	aGame use: ReverseCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 14.
	self assert: (aGame positionOf: 2) equals: 7.
	self assert: (aGame positionOf: 1) equals: 8
]

{ #category : 'tests' }
ReverseCardTest >> testWhenThereAre3SpaceShipsAndTwoReverseCardArePlayedThenTheyPlayInTheCorrectTurnOrder [

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          ReverseCard new.
				          ReverseCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5 })
		         players: 3.

	aGame use: ReverseCard new on: 1.
	aGame use: ReverseCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 1) equals: 6
]
