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

    board := Board
        withSize: 10
        composedOf: (WormHole startingAt: 1 endingAt: 1)
        playedWith: (CardDeck withCards: { })
        andACellConfiguration: { }.
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

	| aGame aBoard |
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {  })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: (RiggedDice new initializeWith: { 5. 6 })
		         wonAfter: 1.
	self
		should: [ aGame use: SpeedCard new on: 1 ]
		raise: Error
		withMessageText: 'The card is not in the ships deck'
]

{ #category : 'tests' }
SpeedCardTest >> testWhenACardIsNotInTheShipDeckThenUsageFails [

	| aGame aBoard |
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {  })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: (RiggedDice new initializeWith: { 5. 6 })
		         wonAfter: 1.
	self
		should: [ aGame use: SpeedCard new on: 1 ]
		raise: Error
		withMessageText: 'The card is not in the ships deck'
]

{ #category : 'tests' }
SpeedCardTest >> testWhenAShipToss5AndLater6ThenTheShipMovesToPosition14 [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 5. 6 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: { SpeedCard new. WhiteCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 2.
	aGame use: (SpeedCard new) on: 1.
	aGame start.
	self assert: (aGame positionOf: 1) equals: 14
]

{ #category : 'tests' }
SpeedCardTest >> testWhenAShipWithSpeedCardMovesPlusOneToAHyperJumpWith50ParsecDivisionAnd10JumpsThenItMoves10JumpsOverThePlusOne [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 10 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 0. 0. 0. 50. 0. 1. 10. 6 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           SpeedCard new.
					           WhiteCard new })
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 2.
	aGame use: SpeedCard new on: 1.
	aGame start.
	self assert: (aGame positionOf: 1) equals: 22
]

{ #category : 'tests' }
SpeedCardTest >> testWhenASpaceShipUsesASpeedCardThenItsTossIncrementsInOne [

	| aGame aBoard spaceShipID |
	spaceShipID := 1.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: { SpeedCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.

	aGame use: (SpeedCard new) on: spaceShipID.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 7
]

{ #category : 'tests' }
SpeedCardTest >> testWhenASpaceShipUsesASpeedCardTwiceThenItsTossIncrementsInTwo [

	| aGame aBoard spaceShipID |
	spaceShipID := 1.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           SpeedCard new.
					           SpeedCard new.
					           SpeedCard new.
					           SpeedCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.

	aGame use: (SpeedCard new) on: spaceShipID.
	aGame use: (SpeedCard new) on: spaceShipID.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 8
]
