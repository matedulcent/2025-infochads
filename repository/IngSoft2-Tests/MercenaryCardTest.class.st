Class {
	#name : 'MercenaryCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
MercenaryCardTest >> testWhenSpaceShip1CombatsWithSpaceShip2AndHasMercenaryWith3And4ThenTheyAllAttack2AndLoseThenAllLoseAShieldAndReturnToPosition0 [

	| aGame aBoard spaceShipID |
	spaceShipID := 1.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (Mercenary withHelpOf: 3).
					           (Mercenary withHelpOf: 4) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 4
		         throwing:
		         (RiggedDice new initializeWith: { 5. 5. 1. 1. 1. 10 })
		         wonAfter: 1.

	aGame use: (Mercenary withHelpOf: 3) on: spaceShipID.
	aGame use: (Mercenary withHelpOf: 4) on: spaceShipID.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame positionOf: 2) equals: 6.
	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame positionOf: 4) equals: 1
]

{ #category : 'tests' }
MercenaryCardTest >> testWhenSpaceShip1CombatsWithSpaceShip2AndUsesMercenaryOn3Then1And3Attack2AndLoseAShieldEach [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith:
		          (OrderedCollection with: (Mercenary withHelpOf: 3))
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing:
		         (RiggedDice new initializeWith: { 5. 5. 1. 2. 10 })
		         wonAfter: 1.

	aGame use: (Mercenary withHelpOf: 3) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame positionOf: 2) equals: 6.
	self assert: (aGame positionOf: 3) equals: 1
]

{ #category : 'tests' }
MercenaryCardTest >> testWhenSpaceShip1CombatsWithSpaceShip2AndUsesMercenaryOn3Then1And3Attack2AndWinAnd2ReturnsToPosition1 [

	| aGame aBoard spaceShipID |
	spaceShipID := 1.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection with: (Mercenary withHelpOf: 3))
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5. 5. 10. 2. 1 })
		         wonAfter: 1.

	aGame use: (Mercenary withHelpOf: 2) on: spaceShipID.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 3) equals: 1.
]

{ #category : 'tests' }
MercenaryCardTest >> testWhenSpaceShip1CombatsWithSpaceShip3AndUsesMercenaryOn3ThenTheyDontBattle [

	| aGame aBoard spaceShipID |
	spaceShipID := 1.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith:
		          (OrderedCollection with: (Mercenary withHelpOf: 3))
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5. 1. 5 })
		         wonAfter: 1.

	aGame use: (Mercenary withHelpOf: 3) on: spaceShipID.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 3) equals: 6
]
