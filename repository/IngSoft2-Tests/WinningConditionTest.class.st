Class {
	#name : 'WinningConditionTest',
	#superclass : 'TestCase',
	#instVars : [
		'aBoard',
		'board'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
WinningConditionTest >> gameWithDice: dice players: amount [

	^ Game
		  playedIn: board
		  by: amount
		  throwing: dice
		  wonAfter: 1
]

{ #category : 'running' }
WinningConditionTest >> setUp [

	super setUp.
	board := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {  })
		          andACellConfiguration: {  }
]

{ #category : 'tests' }
WinningConditionTest >> testWhenARoundHasPassedAndSpaceShip1WinsTheGameIsOver [

	| aGame |
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 1. 2. 3. 9 })
		         players: 3.

	aGame start.

	self assert: aGame isOver
]

{ #category : 'tests' }
WinningConditionTest >> testWhenAfterARoundSpaceShip1WinsGameIsOverThenInformsSpaceShip2And3Position [

	| aGame |
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 8. 3. 7. 1 })
		         players: 3.

	aGame start.

	self assert: aGame isOver.
	self assert: (aGame positionOf: 2) equals: 4.
	self assert: (aGame positionOf: 3) equals: 8
]

{ #category : 'tests' }
WinningConditionTest >> testWhenDiceRollIsHigherThanBoardSizeThenSpaceShipMovesToTheFinishLineTheGameIsOver [

	| aGame |
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 12 })
		         players: 3.

	aGame start.

	self assert: aGame isOver
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1HasMovedToTheEndOfThenGameIsOver [

	| aGame |
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 10 })
		         players: 3.

	aGame start.
	self assert: aGame isOver.
	self assert: (aGame positionOf: 1) equals: 10
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1PlaysAndGameIsntOverThenGameContinues [

	| aGame |
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5 })
		         players: 1.

	aGame start.

	self deny: aGame isOver
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1PlaysAndSpaceShip2WinsGameThenInformsSpaceShip1Position [

	| aGame |
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 3. 10 })
		         players: 2.

	aGame start.

	self assert: aGame isOver.
	self assert: (aGame positionOf: 1) equals: 4
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1PlaysAndSpaceShip2WinsThenGameIsOver [

	| aGame |
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 3. 10 })
		         players: 2.

	aGame start.

	self assert: aGame isOver
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1WinsAndInformsSpaceShip1_2And3Positions [

	| aGame |
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 10 })
		         players: 3.

	aGame start.

	self assert: aGame isOver.
	self assert: (aGame positionOf: 1) equals: 10.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 3) equals: 1
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip3WinsGameIsOverThenInformsSpaceShip1And2Positions [

	| aGame |
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 1. 2. 10 })
		         players: 3.

	aGame start.

	self assert: aGame isOver.

	self assert: aGame isOver.
	self assert: (aGame positionOf: 1) equals: 2.
	self assert: (aGame positionOf: 2) equals: 3
]
