Class {
	#name : 'AccelerationCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
AccelerationCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
	
]

{ #category : 'tests' }
AccelerationCardTest >> testWhenASpaceShipUsesAccelerationCardThenAllSpaceShipsTossIncrementsInOne [

	| aGame aBoard spaceShipID |
	spaceShipID := 1.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: { AccelerationCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.

	aGame use: (AccelerationCard new) on: spaceShipID.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 7
]

{ #category : 'tests' }
AccelerationCardTest >> testWhenASpaceShipUsesAccelerationCardThenItsTossIncrementsInOne [

	| aGame aBoard spaceShipID |
	spaceShipID := 1.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: { AccelerationCard new})
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: (RiggedDice new initializeWith: { 5. 6 })
		         wonAfter: 1.

	aGame use: (AccelerationCard new) on: spaceShipID.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 7.
	self assert: (aGame positionOf: 2) equals: 8
]
