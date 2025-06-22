Class {
	#name : 'RedoCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysSpeedAndaShip2RedoThenTheShip2AlsoHasASpeed [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 7. 2 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (RedoCard withTarget: 1).
					           WhiteCard new.
					           (SpeedCard with: 1).
					           WhiteCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.
	aGame use: (SpeedCard with: 1) on: 1.
	aGame use: (RedoCard withTarget: 1) on: 2.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 9.
	self assert: (aGame positionOf: 2) equals: 4
]

{ #category : 'tests' }
RedoCardTest >> testWhenShipPlaysSpeedAndARedoThenThePlayerHasTwoSpeed [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 7 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (SpeedCard with: 1).
					           (RedoCard withTarget: 1) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.
	aGame use: (SpeedCard with: 1) on: 1.
	aGame use: (RedoCard withTarget: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 10
]

{ #category : 'tests' }
RedoCardTest >> testWhenTheOnlyCardPlayedEsRedoThenTheCardHasNoEffect [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 7 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith:
		          (OrderedCollection withAll: { (RedoCard withTarget: 1) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.
	aGame use: (RedoCard withTarget: 1) on: 1.
	aGame start.
	self assert: (aGame positionOf: 1) equals: 8
	"self
		should: [ aGame use: (RedoCard withTarget: 1) on: 1 ]
		raise: Error
		withMessageText: 'Redo card cant be used first.'"
]
