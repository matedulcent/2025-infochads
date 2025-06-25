Class {
	#name : 'CancelationCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CancelationCardTest >> testWhenAMercenaryIsAssignedAndTheCardIsCanceledThenTheMercenaryIsUnRelatedToCardOwner [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           MercenaryCard new.
					           CancelationCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing:
		         (RiggedDice new initializeWith: { 5. 5. 1. 2. 10 })
		         wonAfter: 1.

	aGame use: (MercenaryCard withHelpOf: 3) on: 1.
	aGame
		use: (CancelationCard
				 withObjective: (MercenaryCard withHelpOf: 3)
				 toShip: 1)
		on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame positionOf: 2) equals: 6.
	self assert: (aGame shieldOf: 3) equals: 3
]

{ #category : 'tests' }
CancelationCardTest >> testWhenAMercenaryIsAssignedThenWithCancelationIsDesasigned [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: { MercenaryCard new. CancelationCard new})
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing:
		         (RiggedDice new initializeWith: { 5. 5. 1. 2. 10 })
		         wonAfter: 1.

	aGame use: (MercenaryCard withHelpOf: 3) on: 1.
	aGame
		use: (CancelationCard
				 withObjective: (MercenaryCard withHelpOf: 3)
				 toShip: 1)
		on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame positionOf: 2) equals: 6.
	self assert: (aGame shieldOf: 3) equals: 3
]

{ #category : 'tests' }
CancelationCardTest >> testWhenItsNotTheShipsTurnToPlayButTheCancelationCardIsValidThenItCanBePlayed [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           WhiteCard new.
					           WhiteCard new.
					           WhiteCard new.
					           CancelationCard new.
					           SpeedCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.

	aGame use: (SpeedCard with: 1) on: 1.
	aGame
		use: (CancelationCard withObjective: (SpeedCard with: 1) toShip: 1)
		on: 1.
	aGame start.
	self assert: (aGame positionOf: 1) equals: 6
]

{ #category : 'tests' }
CancelationCardTest >> testWhenSpaceShip1PlaysASpeedCardAndSpaceShip2PlaysCancelationBeforeTheGameStartsThenSpeedCardIsEnabled [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           WhiteCard new.
					           WhiteCard new.
					           SpeedCard new.
					           CancelationCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.

	aGame use: (SpeedCard with: 1) on: 1.
	aGame
		use: (CancelationCard withObjective: (SpeedCard with: 1) toShip: 1)
		on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 6
]

{ #category : 'tests' }
CancelationCardTest >> testWhenSpaceShipCancelationCardWithNoActivePermanentCardsThenTheCardCantBePlayed [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           CancelationCard new.
					           SpeedCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.

	self
		should: [
			aGame
				use:
				(CancelationCard withObjective: (SpeedCard with: 1) toShip: 1)
				on: 1 ]
		raise: Error
		withMessageText:
		'This card cant be played if the card to be canceled is not active.'
]

{ #category : 'tests' }
CancelationCardTest >> testWhenSpaceShipCancelsHisOwnPermanentCard [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           CancelationCard new.
					           SpeedCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.

	aGame use: (SpeedCard with: 1) on: 1.
	aGame
		use: (CancelationCard withObjective: (SpeedCard with: 1) toShip: 1)
		on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 6
]

{ #category : 'tests' }
CancelationCardTest >> testWhenSpaceShipDoesntHaveTheCancelationCardInHisHandThenTheCadCantBePlayed [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           CancelationCard new.
					           WhiteCard new.
					           SpeedCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.

	aGame use: (SpeedCard with: 1) on: 1.

	self
		should: [
			aGame
				use:
				(CancelationCard withObjective: (SpeedCard with: 1) toShip: 1)
				on: 1 ]
		raise: Error
		withMessageText: 'The card is not in the ships deck'
]
