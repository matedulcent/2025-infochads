Class {
	#name : 'CancelationCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CancelationCardTest >> testWhenAMercenaryIsAssignedAndTheCardIsCanceledThenTheMercenaryIsUnRelatedToCardOwner [

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          MercenaryCard new.
				          CancelationCard new }).

	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 5. 5. 1. 2. 10 })
		         players: 3.

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

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          MercenaryCard new.
				          CancelationCard new }).

	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 5. 5. 1. 2. 10 })
		         players: 3.

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

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          WhiteCard new.
				          WhiteCard new.
				          WhiteCard new.
				          CancelationCard new.
				          SpeedCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5 })
		         players: 3.

	aGame use: SpeedCard new on: 1.
	aGame
		use: (CancelationCard withObjective: SpeedCard new toShip: 1)
		on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 6
]

{ #category : 'tests' }
CancelationCardTest >> testWhenSpaceShip1PlaysASpeedCardAndSpaceShip2PlaysCancelationBeforeTheGameStartsThenSpeedCardIsEnabled [

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          WhiteCard new.
				          WhiteCard new.
				          SpeedCard new.
				          CancelationCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5 })
		         players: 3.

	aGame use: SpeedCard new on: 1.
	aGame
		use: (CancelationCard withObjective: SpeedCard new toShip: 1)
		on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 6
]

{ #category : 'tests' }
CancelationCardTest >> testWhenSpaceShipCancelationCardWithNoActivePermanentCardsThenTheCardCantBePlayed [

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          CancelationCard new.
				          SpeedCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5 })
		         players: 3.

	self
		should: [
			aGame
				use: (CancelationCard withObjective: SpeedCard new toShip: 1)
				on: 1 ]
		raise: Error
		withMessageText:
		'This card cant be played if the card to be canceled is not active.'
]

{ #category : 'tests' }
CancelationCardTest >> testWhenSpaceShipCancelsAInmediateCardThenCreationFails [

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          CancelationCard new.
				          ReverseCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5 })
		         players: 1.

	aGame use: ReverseCard new on: 1.

	self
		should: [
			aGame
				use: (CancelationCard withObjective: ReverseCard new toShip: 1)
				on: 1 ]
		raise: Error
		withMessageText:
		'This card cant be played if the card to be canceled is not active.'
]

{ #category : 'tests' }
CancelationCardTest >> testWhenSpaceShipCancelsHisOwnPermanentCard [

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          CancelationCard new.
				          SpeedCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5 })
		         players: 3.

	aGame use: SpeedCard new on: 1.
	aGame
		use: (CancelationCard withObjective: SpeedCard new toShip: 1)
		on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 6
]

{ #category : 'tests' }
CancelationCardTest >> testWhenSpaceShipDoesntHaveTheCancelationCardInHisHandThenTheCadCantBePlayed [

	| aGame |
	board := self boardWithSize: 100 andDeck: (CardDeck withCards: {
				          CancelationCard new.
				          WhiteCard new.
				          SpeedCard new }).
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 5 })
		         players: 3.

	aGame use: SpeedCard new on: 1.

	self
		should: [
			aGame
				use: (CancelationCard withObjective: SpeedCard new toShip: 1)
				on: 1 ]
		raise: Error
		withMessageText: 'The card is not in the ships deck'
]
