Class {
	#name : 'RedoCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RedoCardTest >> testWhenShip1LandsOnABlackHoleAndUsesRepeatOn2Then2PlaysRedoTwiceOnItSelfThen2GoesBack12Spaces [

	| aGame aConfigureDiceSet |
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 100. 0. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }.
	board := Board
		         withSize: 50
		         composedOf: (WormHole startingAt: 1 endingAt: 1)
		         playedWith: (CardDeck withCards: {
					          RedoCard new.
					          RedoCard new.
					          RepeatCard new.
					          WhiteCard new })
		         andACellConfiguration: aConfigureDiceSet.
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 19. 39 })
		         players: 2.

	aGame start.
	aGame use: (RepeatCard withObjective: 2) on: 1.
	aGame use: (RedoCard withFillOut: 2) on: 2.
	aGame use: (RedoCard withFillOut: 2) on: 2.


	self assert: (aGame positionOf: 1) equals: 16.
	self assert: (aGame positionOf: 2) equals: 24
]

{ #category : 'tests' }
RedoCardTest >> testWhenShip1Plays2SpeedAndShip2PlaysCancelAndRedoThenThereAreNoMoreCardsInGame [

	| aGame |
	board := self boardWithSize: 50 andDeck: (CardDeck withCards: {
				          CancelationCard new.
				          RedoCard new.
				          SpeedCard new.
				          SpeedCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 7. 10 })
		         players: 32.

	aGame use: SpeedCard new on: 1.
	aGame use: SpeedCard new on: 1.
	aGame
		use: (CancelationCard withObjective: SpeedCard new toShip: 1)
		on: 2.
	aGame use: (RedoCard withFillOut: 1) on: 2.
	aGame start.


	self assert: (aGame positionOf: 1) equals: 8.
	self assert: (aGame positionOf: 2) equals: 11
]

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysMercenaryOn3AndRedoOn4AndShip2PlaysRedoOn5AndShip1LosesThenShip1And3And4LoseShield [

	| aGame |
	board := self boardWithSize: 50 andDeck: (CardDeck withCards: {
				          WhiteCard new.
				          RedoCard new.
				          WhiteCard new.
				          RedoCard new.
				          MercenaryCard new }).

	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 1. 1. 1. 1. 1. 1. 10 })
		         players: 5.

	aGame use: (MercenaryCard withHelpOf: 3) on: 1.
	aGame use: (RedoCard withFillOut: 4) on: 1.
	aGame use: (RedoCard withFillOut: 5) on: 2.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame positionOf: 2) equals: 2.
	self assert: (aGame shieldOf: 2) equals: 3.
	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame shieldOf: 3) equals: 2.
	self assert: (aGame positionOf: 4) equals: 1.
	self assert: (aGame shieldOf: 4) equals: 2.
	self assert: (aGame positionOf: 5) equals: 1.
	self assert: (aGame shieldOf: 5) equals: 3
]

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysMercenaryOn3AndShip2PlaysRedoOn3ThenTheRedoIsInvalid [

	| aGame |
	board := self boardWithSize: 50 andDeck: (CardDeck withCards: {
				          WhiteCard new.
				          RedoCard new.
				          WhiteCard new.
				          MercenaryCard new }).

	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 1. 1. 1. 1. 1. 1. 10 })
		         players: 3.

	aGame use: (MercenaryCard withHelpOf: 3) on: 1.

	self
		should: [ aGame use: (RedoCard withFillOut: 3) on: 2 ]
		raise: Error
		withMessageText: 'A mercenary cant help multiple ships.'
]

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysMercenaryOn3AndShip2PlaysRedoOn4AndShip1LosesThenShip1And3LoseShield [

	| aGame |
	board := self boardWithSize: 50 andDeck: (CardDeck withCards: {
				          RedoCard new.
				          WhiteCard new.
				          WhiteCard new.
				          MercenaryCard new }).

	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 1. 1. 1. 1. 1. 10 })
		         players: 4.

	aGame use: (MercenaryCard withHelpOf: 3) on: 1.
	aGame use: (RedoCard withFillOut: 4) on: 2.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame positionOf: 2) equals: 2.
	self assert: (aGame shieldOf: 2) equals: 3.
	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame shieldOf: 3) equals: 2.
	self assert: (aGame positionOf: 4) equals: 1.
	self assert: (aGame shieldOf: 4) equals: 3
]

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysSpeedAndAccelerationThenShip2CancelsAndRedoThenRedoIsInvalid [

	| aGame |
	board := self boardWithSize: 150 andDeck: (CardDeck withCards: {
				          CancelationCard new.
				          RedoCard new.
				          SpeedCard new.
				          AccelerationCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 7. 10 })
		         players: 2.
	aGame use: SpeedCard new on: 1.
	aGame use: AccelerationCard new on: 1.
	aGame
		use: (CancelationCard withObjective: SpeedCard new toShip: 1)
		on: 2.

	self
		should: [ aGame use: (RedoCard withFillOut: 1) on: 2 ]
		raise: Error
		withMessageText:
		'This card cant be played if the card to be canceled is not active.'
]

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysSpeedAndRedoAndShip2PlaysCancelTwiceAndShip3PlaysCancelationOnSpeedThenLastCancelationFails [

	| aGame |
	board := self boardWithSize: 50 andDeck: (CardDeck withCards: {
				          WhiteCard new.
				          CancelationCard new.
				          CancelationCard new.
				          CancelationCard new.
				          RedoCard new.
				          SpeedCard new }).
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 9 })
		         players: 3.

	aGame use: SpeedCard new on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.

	aGame
		use: (CancelationCard withObjective: SpeedCard new toShip: 1)
		on: 2.
	aGame
		use: (CancelationCard withObjective: SpeedCard new toShip: 1)
		on: 2.

	self
		should: [
			aGame
				use: (CancelationCard withObjective: SpeedCard new toShip: 1)
				on: 3 ]
		raise: Error
		withMessageText:
		'This card cant be played if the card to be canceled is not active.'
]

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysSpeedAndRedoAndShip2PlaysCancelTwiceOnSpeedThenShip1HasNoMoreSpeed [

	| aGame |
	board := self boardWithSize: 50 andDeck: (CardDeck withCards: {
				          CancelationCard new.
				          CancelationCard new.
				          RedoCard new.
				          SpeedCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 9 })
		         players: 2.

	aGame use: SpeedCard new on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.

	aGame use: (CancelationCard withObjective: SpeedCard new toShip: 1) on: 2.
	aGame use: (CancelationCard withObjective: SpeedCard new toShip: 1) on: 2.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 10
]

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysSpeedAndaShip2RedoThenTheShip2AlsoHasASpeed [

	| aGame |
	board := self boardWithSize: 50 andDeck: (CardDeck withCards: {
				          RedoCard new.
				          WhiteCard new.
				          SpeedCard new.
				          WhiteCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 7. 2 })
		         players: 2.

	aGame use: SpeedCard new on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 2.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 9.
	self assert: (aGame positionOf: 2) equals: 4
]

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysSpeedTwiceThenShip2CancelsAndRedoThenBothSpeedsAreOut [

	| aGame |
	board := self boardWithSize: 50 andDeck: (CardDeck withCards: {
				          CancelationCard new.
				          RedoCard new.
				          SpeedCard new.
				          SpeedCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 7. 10 })
		         players: 2.
	aGame use: SpeedCard new on: 1.
	aGame use: SpeedCard new on: 1.
	aGame
		use: (CancelationCard withObjective: SpeedCard new toShip: 1)
		on: 2.
	aGame use: (RedoCard withFillOut: 1) on: 2.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 8.
	self assert: (aGame positionOf: 2) equals: 11
]

{ #category : 'tests' }
RedoCardTest >> testWhenShipPlaysAccelerationAndARedoThenAllShipsHave2Acceleration [

	| aGame |
	board := self boardWithSize: 50 andDeck: (CardDeck withCards: {
				          AccelerationCard new.
				          RedoCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 7. 8. 9 })
		         players: 3.
	aGame use: AccelerationCard new on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 10.
	self assert: (aGame positionOf: 2) equals: 11.
	self assert: (aGame positionOf: 3) equals: 12
]

{ #category : 'tests' }
RedoCardTest >> testWhenShipPlaysMercenaryAndRedoOnAnotherShipThenTheyLooseAndLoseShieldAndGoBackToStart [

	| aGame |
	board := self boardWithSize: 50 andDeck: (CardDeck withCards: {
				          RedoCard new.
				          MercenaryCard new }).

	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 1. 1. 1. 1. 1. 10 })
		         players: 4.

	aGame use: (MercenaryCard withHelpOf: 3) on: 1.
	aGame use: (RedoCard withFillOut: 4) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame shieldOf: 3) equals: 2.
	self assert: (aGame positionOf: 4) equals: 1.
	self assert: (aGame shieldOf: 4) equals: 2
]

{ #category : 'tests' }
RedoCardTest >> testWhenShipPlaysSpeedAndARedoThenThePlayerHasTwoSpeed [

	| aGame |
	board := self boardWithSize: 50 andDeck: (CardDeck withCards: {
				          SpeedCard new.
				          RedoCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 7 })
		         players: 1.
	aGame use: SpeedCard new on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 10
]

{ #category : 'tests' }
RedoCardTest >> testWhenSpaceShip1PlaysRepeatCardAndRedoCardOnSpaceShip2ThenBothHaveThePowerUpAgain [

	| aGame aConfigureDiceSet |
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 100. 0. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }.
	board := Board
		         withSize: 50
		         composedOf: (WormHole startingAt: 1 endingAt: 1)
		         playedWith: (CardDeck withCards: {
					          RepeatCard new.
					          RedoCard new })
		         andACellConfiguration: aConfigureDiceSet.

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 19. 34 })
		         players: 2.
	aGame start.
	aGame use: (RepeatCard withObjective: 1) on: 1.
	aGame use: (RedoCard withFillOut: 2) on: 1.

	self assert: (aGame positionOf: 1) equals: 12.
	self assert: (aGame positionOf: 2) equals: 27
]

{ #category : 'tests' }
RedoCardTest >> testWhenSpaceShipPlaysRepeatCardAndRedoCardThenItAppliesTheEffectTwice [

	| aGame aConfigureDiceSet |
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 100. 0. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }.
	board := Board
		         withSize: 50
		         composedOf: (WormHole startingAt: 1 endingAt: 1)
		         playedWith: (CardDeck withCards: {
					          RepeatCard new.
					          RedoCard new })
		         andACellConfiguration: aConfigureDiceSet.
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 19 })
		         players: 1.
	aGame start.
	aGame use: (RepeatCard withObjective: 1) on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.

	self assert: (aGame positionOf: 1) equals: 8
]

{ #category : 'tests' }
RedoCardTest >> testWhenSpaceShipPlaysTwoRedoCardTogetherWithNoOtherCardToRedoThenNothingHappens [

	| aGame |
	board := self boardWithSize: 50 andDeck: (CardDeck withCards: {
				          RedoCard new.
				          RedoCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 19 })
		         players: 1.

	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 20
]

{ #category : 'tests' }
RedoCardTest >> testWhenTheOnlyCardPlayedIsRedoThenTheCardHasNoEffect [

	| aGame |
	board := self
		         boardWithSize: 50
		         andDeck: (CardDeck withCards: { RedoCard new }).

	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 7 })
		         players: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 8
]
