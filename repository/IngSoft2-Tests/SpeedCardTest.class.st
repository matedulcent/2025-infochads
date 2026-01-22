Class {
	#name : 'SpeedCardTest',
	#superclass : 'TestCase',
	#instVars : [
		'board'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
SpeedCardTest >> boardWithSize: aSize andDeck: aCardDeck [

	^ Board
		  withSize: aSize
		  composedOf: (WormHole startingAt: 1 endingAt: 1)
		  playedWith: aCardDeck
		  andACellConfiguration: {  }
]

{ #category : 'as yet unclassified' }
SpeedCardTest >> gameWithDice: dice players: amount [

	^ Game
		  playedIn: board
		  by: amount
		  throwing: dice
		  wonAfter: 1
]

{ #category : 'as yet unclassified' }
SpeedCardTest >> readme [
	"The cards are withdrawn from the last included in the deck"

	
]

{ #category : 'running' }
SpeedCardTest >> setUp [

	super setUp.

	board := self boardWithSize: 10 andDeck: (CardDeck withCards: {  })
]

{ #category : 'asserting' }
SpeedCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
	
]

{ #category : 'tests' }
SpeedCardTest >> testWhenACardIsNotInDeckThenUsageFails [
    | aGame |

    aGame := self
        gameWithDice: (RiggedDice new initializeWith: { 5. 6 })
        players: 2.

    self
        should: [ aGame use: SpeedCard new on: 1 ]
        raise: Error
        withMessageText: 'The card is not in the ships deck'

]

{ #category : 'tests' }
SpeedCardTest >> testWhenACardIsNotInTheShipDeckThenUsageFails [

	| aGame |
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5. 6 })
		         players: 2.
	self
		should: [ aGame use: SpeedCard new on: 1 ]
		raise: Error
		withMessageText: 'The card is not in the ships deck'
]

{ #category : 'tests' }
SpeedCardTest >> testWhenAShipToss5AndLater6ThenTheShipMovesToPosition14 [

	| aGame |
	board := self boardWithSize: 50 andDeck: (CardDeck withCards: {
				          SpeedCard new.
				          WhiteCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5. 6 })
		         players: 1.

	aGame use: SpeedCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 14
]

{ #category : 'tests' }
SpeedCardTest >> testWhenAShipWithSpeedCardMovesPlusOneToAHyperJumpWith50ParsecDivisionAnd10JumpsThenItMoves10JumpsOverThePlusOne [

	| aGame aConfigureDiceSet |
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 0. 0. 0. 50. 0. 1. 10. 6 }.

	board := Board
		         withSize: 50
		         composedOf: (WormHole startingAt: 1 endingAt: 1)
		         playedWith: (CardDeck withCards: {
					          SpeedCard new.
					          WhiteCard new })
		         andACellConfiguration: aConfigureDiceSet.

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 10 })
		         players: 1.

	aGame use: SpeedCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 22
]

{ #category : 'tests' }
SpeedCardTest >> testWhenASpaceShipUsesASpeedCardThenItsTossIncrementsInOne [

	| aGame |
	board := self
		         boardWithSize: 10
		         andDeck: (CardDeck withCards: { SpeedCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5 })
		         players: 1.

	aGame use: SpeedCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 7
]

{ #category : 'tests' }
SpeedCardTest >> testWhenASpaceShipUsesASpeedCardTwiceThenItsTossIncrementsInTwo [

	| aGame |
	board := self boardWithSize: 10 andDeck: (CardDeck withCards: {
				          SpeedCard new.
				          SpeedCard new.
				          SpeedCard new.
				          SpeedCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5 })
		         players: 1.

	aGame use: SpeedCard new on: 1.
	aGame use: SpeedCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 8
]
