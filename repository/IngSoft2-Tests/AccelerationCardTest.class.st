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
    | aGame |

    board := self
        boardWithSize: 10
        andDeck: (CardDeck withCards: { AccelerationCard new }).

    aGame := self
        gameWithDice: (RiggedDice new initializeWith: { 5 })
        players: 1.

    aGame use: AccelerationCard new on: 1.
    aGame start.

    self assert: (aGame positionOf: 1) equals: 7

]

{ #category : 'tests' }
AccelerationCardTest >> testWhenASpaceShipUsesAccelerationCardThenItsTossIncrementsInOne [

	| aGame |
	board := self
		         boardWithSize: 10
		         andDeck: (CardDeck withCards: { AccelerationCard new }).

	aGame := Game
		         playedIn: board
		         by: 2
		         throwing: (RiggedDice new initializeWith: { 5. 6 })
		         wonAfter: 1.

	aGame use: AccelerationCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 7.
	self assert: (aGame positionOf: 2) equals: 8
]
