Class {
	#name : 'CancelationTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CancelationTest >> testWhenItsNotTheShipsTurnToPlayButTheCancelationCardIsValidThenItCanBePlayed [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (CancelationCard
						            withObjective: (SpeedCard with: 1)
						            ofSpaceShip: 1).
					           WhiteCard new.
					           WhiteCard new.
					           WhiteCard new.
					           WhiteCard new.
					           (SpeedCard with: 1) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.

	aGame use: (SpeedCard with: 1) on: 1.
	aGame
		use:
		(CancelationCard withObjective: (SpeedCard with: 1) ofSpaceShip: 1)
		on: 3.
	aGame start.
	self assert: (aGame positionOf: 1) equals: 6
]

{ #category : 'tests' }
CancelationTest >> testWhenSpaceShip1PlaysASpeedCardAndSpaceShip2PlaysCancelationBeforeTheGameStartsThenSpeedCardIsEnabled [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (CancelationCard
						            withObjective: (SpeedCard with: 1)
						            ofSpaceShip: 1).
					           WhiteCard new.
					           (SpeedCard with: 1) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.

	aGame use: (SpeedCard with: 1) on: 1.
	aGame
		use:
		(CancelationCard withObjective: (SpeedCard with: 1) ofSpaceShip: 1)
		on: 2.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 6.
]
