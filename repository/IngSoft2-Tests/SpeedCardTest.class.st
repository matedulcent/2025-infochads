Class {
	#name : 'SpeedCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
SpeedCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
	
]

{ #category : 'tests' }
SpeedCardTest >> testWhenASpaceShipUsesASpeedCardThenItsTossIncrementsInOne [

	| aGame aBoard spaceShipID |
	spaceShipID := 1.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.
	
	aGame use: (SpeedCard with: 1) on: spaceShipID.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 7
]

{ #category : 'tests' }
SpeedCardTest >> testWhenTheIncrementInTheDiceTossIsNegativeThenCreationFails [

	self
		should: [ SpeedCard with: -1 ]
		raise: Error
		withMessageText: 'The increment in the dice toss must be one.'
]

{ #category : 'tests' }
SpeedCardTest >> testWhenTheIncrementInTheDiceTossIsNot1ThenCreationFails [

	self
		should: [ SpeedCard with: 10 ]
		raise: Error
		withMessageText: 'The increment in the dice toss must be one.'
]

{ #category : 'tests' }
SpeedCardTest >> testWhenTheIncrementInTheDiceTossIsNotAnIntThenCreationFails [

	self
		should: [ SpeedCard with: 'a' ]
		raise: Error
		withMessageText: 'The increment in the dice toss must be one.'
]
