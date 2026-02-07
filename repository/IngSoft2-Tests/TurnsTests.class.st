Class {
	#name : 'TurnsTests',
	#superclass : 'BattleTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
TurnsTests >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip1IsTheOnlyPlayerThenCanPlayAlone [

	| aGame |
	aGame := self
		         gameWithDice: (DiceSet withDices: { (Dice withSides: 6) })
		         players: 1.
	aGame start.
	self assert: (aGame positionOf: 1) equals: 10
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip1IsToPlayAndSpaceShip1PlaysThenIsValid [

	| aGame |
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 2 })
		         players: 3.
	aGame start.
	self assert: (aGame positionOf: 1) equals: 3
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip2IsToPlayAndSpaceShip2PlaysThenIsValid [

	| aGame |
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 2. 3 })
		         players: 3.
	aGame start.
	self assert: (aGame positionOf: 1) equals: 3.
	self assert: (aGame positionOf: 2) equals: 4
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip3IsToPlayAndSpaceShip3PlaysThenIsValid [

	| aGame |
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 1. 2. 3 })
		         players: 3.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 2.
	self assert: (aGame positionOf: 2) equals: 3.
	self assert: (aGame positionOf: 3) equals: 4
]

{ #category : 'tests' }
TurnsTests >> testWhenTheFirstRoundIsPlayedThenSpaceShip1IsToPlayThenIsValid [

	| aGame |
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 2. 1. 3. 2 })
		         players: 3.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 5.
	self assert: (aGame positionOf: 2) equals: 2.
	self assert: (aGame positionOf: 3) equals: 4
]
