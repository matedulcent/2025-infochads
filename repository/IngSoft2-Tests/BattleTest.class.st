Class {
	#name : 'BattleTest',
	#superclass : 'TestCase',
	#instVars : [
		'board'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BattleTest >> boardWithSize: aSize andDeck: aCardDeck [

	^ Board
		  withSize: aSize
		  composedOf: (WormHole startingAt: 1 endingAt: 1)
		  playedWith: aCardDeck
		  andACellConfiguration: {  }
]

{ #category : 'tests' }
BattleTest >> gameWithDice: dice players: amount [

	^ Game
		  playedIn: board
		  by: amount
		  throwing: dice
		  wonAfter: 1
]

{ #category : 'tests' }
BattleTest >> setUp [

	super setUp.

	board := self boardWithSize: 10 andDeck: (CardDeck withCards: {  })
]

{ #category : 'asserting' }
BattleTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

    self
        should: anErrorBlock
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: (error messageText) equals:
                errorMessage ]
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2Enconter3TimesAndShip2WinsThenShip1NowLooses2Turns [

	| aGame |
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith:
				          { 5. 5. 1. 2. 6. 1. 1. 2. 7. 1. 1. 2. 1. 1. 1. 1 })
		         players: 2.

	aGame start.

	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame positionOf: 2) equals: 10
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2Enconter3TimesAndShip2WinsThenShip1NowLooses2TurnsAndThenItMoves1 [

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {  }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith:
				          { 5. 5. 1. 2. 6. 1. 1. 2. 7. 1. 1. 2. 1. 1. 1. 1 })
		         players: 2.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 2.
	self assert: (aGame positionOf: 2) equals: 10
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAfterOneRoundAndShip1WinsThenShip2ReturnsToStart [

	| aGame |
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 2. 5. 5. 2. 2. 1 })
		         players: 2.

	aGame start.

	self assert: (aGame positionOf: 1) equals: 8.
	self assert: (aGame positionOf: 2) equals: 1
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip1WinsAndShip2Loses1ShieldThenShip2Toss0ToRecoverTo3Shields [

	| aGame |
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 5. 5. 3. 2. 1. 0 })
		         players: 2.

	aGame start.

	self assert: (aGame shieldOf: 2) equals: 3
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip1WinsThenShip2NowHas2Shields [

	| aGame |
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 5. 5. 2. 1 })
		         players: 2.

	aGame start.

	self assert: (aGame shieldOf: 2) equals: 2.
	self assert: (aGame shieldOf: 1) equals: 3
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip1WinsThenShip2ReturnsToStart [

	| aGame |
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 5. 5. 2. 1 })
		         players: 2.

	aGame start.

	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 2) equals: 1
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip2WinsThenShip1ReturnsToStart [

	| aGame |
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 5. 5. 1. 2 })
		         players: 2.

	aGame start.

	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame positionOf: 2) equals: 6
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip2WinsThenShip2NowHas2Shields [

	| aGame |
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 5. 5. 1. 2 })
		         players: 2.

	aGame start.

	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame shieldOf: 2) equals: 3
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndTheyTossTheSameNumberThenTheDefendantShipWinAndTheLoserGoesBack [

	| aGame |
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 5. 5. 1. 1 })
		         players: 2.

	aGame start.

	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 2) equals: 1
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip3EnconterAndShip1WinsThenShip3ReturnsToStart [

	| aGame |
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 5. 1. 5. 2. 1 })
		         players: 3.

	aGame start.

	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 2) equals: 2.
	self assert: (aGame positionOf: 3) equals: 1
]

{ #category : 'tests' }
BattleTest >> testWhenShip1Has3ShieldsThenShip1CantSkipTurns [

	| aGame |
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 0 })
		         players: 3.

	self
		should: [ aGame start ]
		raise: Error
		withMessageText: 'The Shield is already full, it cant be recharged.'
]
