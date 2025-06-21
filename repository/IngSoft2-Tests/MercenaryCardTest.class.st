Class {
	#name : 'MercenaryCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
MercenaryCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

    self
        should: anErrorBlock
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: (error messageText) equals:
                errorMessage ]
]

{ #category : 'tests' }
MercenaryCardTest >> testWhenSpaceShip1CombatsWithSpaceShip2AndHasMercenaryWith3And4ThenTheyAllAttack2AndLoseThenAllLoseAShieldAndReturnToPosition0 [

	| aGame aBoard spaceShipID |
	spaceShipID := 1.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (MercenaryCard withHelpOf: 3).
					           (MercenaryCard withHelpOf: 4) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 4
		         throwing:
		         (RiggedDice new initializeWith: { 5. 5. 1. 1. 1. 10 })
		         wonAfter: 1.

	aGame use: (MercenaryCard withHelpOf: 3) on: spaceShipID.
	aGame use: (MercenaryCard withHelpOf: 4) on: spaceShipID.
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
		          (OrderedCollection with: (MercenaryCard withHelpOf: 3))
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing:
		         (RiggedDice new initializeWith: { 5. 5. 1. 2. 10 })
		         wonAfter: 1.

	aGame use: (MercenaryCard withHelpOf: 3) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame positionOf: 2) equals: 6.
	self assert: (aGame shieldOf: 2) equals: 3.
	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame shieldOf: 3) equals: 2.
]

{ #category : 'tests' }
MercenaryCardTest >> testWhenSpaceShip1CombatsWithSpaceShip2AndUsesMercenaryOn3Then1And3Attack2AndWinAnd2ReturnsToPosition1 [

	| aGame aBoard spaceShipID |
	spaceShipID := 1.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection with: (MercenaryCard withHelpOf: 3))
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5. 5. 10. 2. 1 })
		         wonAfter: 1.

	aGame use: (MercenaryCard withHelpOf: 2) on: spaceShipID.
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
		          (OrderedCollection with: (MercenaryCard withHelpOf: 3))
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5. 1. 5 })
		         wonAfter: 1.

	aGame use: (MercenaryCard withHelpOf: 3) on: spaceShipID.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 3) equals: 6
]

{ #category : 'tests' }
MercenaryCardTest >> testWhenSpaceShip1PlaysMercenaryOn3Then2CantPlayMercenaryOn3 [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (MercenaryCard withHelpOf: 3).
					           (MercenaryCard withHelpOf: 3).
					           (MercenaryCard withHelpOf: 3).
					           (MercenaryCard withHelpOf: 3) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5. 5 })
		         wonAfter: 1.

	aGame use: (MercenaryCard withHelpOf: 3) on: 1.
	aGame use: (MercenaryCard withHelpOf: 3) on: 2.

	self 
	should: [ aGame start ]
	raise: Error
	withMessageText: 'A mercenary cant help multiple ships.'
]

{ #category : 'tests' }
MercenaryCardTest >> testWhenSpaceShip2CombatsSpaceShip1And3DueToMercenaryAndWinThenSpaceShip2ReturnsToPosition1With2Shield [

	| aGame aBoard spaceShipID |
	spaceShipID := 1.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith:
		          (OrderedCollection with: (MercenaryCard withHelpOf: 3))
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing:
		         (RiggedDice new initializeWith: { 5. 5. 10. 1. 1. 5 })
		         wonAfter: 1.

	aGame use: (MercenaryCard withHelpOf: 3) on: spaceShipID.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 3) equals: 6
]

{ #category : 'tests' }
MercenaryCardTest >> testWhenSpaceShip2UsesACardWhenItsNotItsTurnThenTheCardIsAccumulatedAndPlayedOnTheRightTurn [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (SpeedCard with: 1).
					           WhiteCard new.
					           (SpeedCard with: 1) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: (RiggedDice new initializeWith: { 5. 6 })
		         wonAfter: 1.

	aGame use: (SpeedCard with: 1) on: 1.
	aGame use: (SpeedCard with: 1) on: 2.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 7.
	self assert: (aGame positionOf: 2) equals: 8
]

{ #category : 'tests' }
MercenaryCardTest >> testWhenSpaceShipThatDoesntExistTryesToUseACardThenProcedureFails [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (SpeedCard with: 1).
					           WhiteCard new.
					           (SpeedCard with: 1) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: (RiggedDice new initializeWith: { 5. 6 })
		         wonAfter: 1.

	self
		should: [ aGame use: (SpeedCard with: 1) on: 10 ]
		raise: Error
		withMessageText: 'The ship doesnt exist'
]
