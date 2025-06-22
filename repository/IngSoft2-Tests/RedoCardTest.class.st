Class {
	#name : 'RedoCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysMercenaryOn3AndRedoOn4AndShip2PlaysRedoOn5AndShip1LosesThenShip1And3And4LoseShield [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1. 1. 1. 1. 1. 1. 10 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           WhiteCard new.
					           (RedoCard withFillOut: 5).
					           WhiteCard new.
					           (RedoCard withFillOut: 4).
					           (MercenaryCard withHelpOf: 3) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 5
		         throwing: aDiceSet
		         wonAfter: 1.

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

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1. 1. 1. 1. 1. 1. 10 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           WhiteCard new.
					           (RedoCard withFillOut: 3).
					           WhiteCard new.
					           (MercenaryCard withHelpOf: 3) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame use: (MercenaryCard withHelpOf: 3) on: 1.
	aGame use: (RedoCard withFillOut: 3) on: 2.


	self
		should: [ aGame start ]
		raise: Error
		withMessageText: 'A mercenary cant help multiple ships.'
]

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysMercenaryOn3AndShip2PlaysRedoOn4AndShip1LosesThenShip1And3LoseShield [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1. 1. 1. 1. 1. 10 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (RedoCard withFillOut: 4).
					           WhiteCard new.
					           WhiteCard new.
					           (MercenaryCard withHelpOf: 3) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 4
		         throwing: aDiceSet
		         wonAfter: 1.

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

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 7. 10 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (CancelationCard
						            withObjective: (SpeedCard with: 1)
						            toShip: 1).
					           (RedoCard withFillOut: 1).
					           (SpeedCard with: 1).
					           (AccelerationCard with: 1) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.
	aGame use: (SpeedCard with: 1) on: 1.
	aGame use: (AccelerationCard with: 1) on: 1.
	aGame
		use: (CancelationCard withObjective: (SpeedCard with: 1) toShip: 1)
		on: 2.

	self
		should: [ aGame use: (RedoCard withFillOut: 1) on: 2 ]
		raise: Error
		withMessageText:
		'This card cant be played if the card to be canceled is not active.'
]

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysSpeedAndShip2PlaysSpeedThenShip3CancelsAndRedoThenBothCardsAreOut [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 7. 10 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (CancelationCard
						            withObjective: (SpeedCard with: 1)
						            toShip: 1).
					           (RedoCard withFillOut: 1).
					           WhiteCard new.
					           (SpeedCard with: 1).
					           WhiteCard new.
					           (SpeedCard with: 1) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame use: (SpeedCard with: 1) on: 1.
	aGame use: (SpeedCard with: 1) on: 2.
		aGame
		use: (CancelationCard withObjective: (SpeedCard with: 1) toShip: 1)
		on: 3.
	aGame start.
	aGame use: (RedoCard withFillOut: 2) on: 3.


	self assert: (aGame positionOf: 1) equals: 8.
	self assert: (aGame positionOf: 2) equals: 12
]

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysSpeedAndaShip2RedoThenTheShip2AlsoHasASpeed [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 7. 2 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (RedoCard withFillOut: 1).
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
	aGame use: (RedoCard withFillOut: 1) on: 2.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 9.
	self assert: (aGame positionOf: 2) equals: 4
]

{ #category : 'tests' }
RedoCardTest >> testWhenShip1PlaysSpeedTwiceThenShip2CancelsAndRedoThenBothSpeedsAreOut [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 7. 10 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (CancelationCard
						            withObjective: (SpeedCard with: 1)
						            toShip: 1).
					           (RedoCard withFillOut: 1).
					           (SpeedCard with: 1).
					           (SpeedCard with: 1) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.
	aGame use: (SpeedCard with: 1) on: 1.
	aGame use: (SpeedCard with: 1) on: 1.
	aGame
		use: (CancelationCard withObjective: (SpeedCard with: 1) toShip: 1)
		on: 2.
	aGame use: (RedoCard withFillOut: 1) on: 2.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 8.
	self assert: (aGame positionOf: 2) equals: 11.

]

{ #category : 'tests' }
RedoCardTest >> testWhenShipPlaysAccelerationAndARedoThenAllShipsHave2Acceleration [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 7. 8. 9 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (AccelerationCard with: 1).
					           (RedoCard withFillOut: 1) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.
	aGame use: (AccelerationCard with: 1) on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 10.
	self assert: (aGame positionOf: 2) equals: 11.
	self assert: (aGame positionOf: 3) equals: 12
]

{ #category : 'tests' }
RedoCardTest >> testWhenShipPlaysMercenaryAndRedoOnAnotherShipThenTheyLooseAndLoseShieldAndGoBackToStart [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1. 1. 1. 1. 1. 10 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (RedoCard withFillOut: 4).
					           (MercenaryCard withHelpOf: 3) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 4
		         throwing: aDiceSet
		         wonAfter: 1.

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

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 7 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (SpeedCard with: 1).
					           (RedoCard withFillOut: 1) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.
	aGame use: (SpeedCard with: 1) on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 10
]

{ #category : 'tests' }
RedoCardTest >> testWhenSpaceShip1PlaysRepeatCardAndRedoCardOnSpaceShip2ThenBothHaveThePowerUpAgain [

	| aGame aDiceSet aBoard aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 19. 34 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 100. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (RepeatCard withObjective: 1).
					           (RedoCard withFillOut: 2) })
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.
	aGame start.
	aGame use: (RepeatCard withObjective: 1) on: 1.
	aGame use: (RedoCard withFillOut: 2) on: 1.

	self assert: (aGame positionOf: 1) equals: 12.
	self assert: (aGame positionOf: 2) equals: 27
]

{ #category : 'tests' }
RedoCardTest >> testWhenSpaceShip2PlaysSpeedCardAndSpaceShip1PlaysRedoCardThenRedoIsUselessDueToSpeedCardCantBePlayedInOthersTurn [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 19. 30 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (SpeedCard with: 1).
					           WhiteCard new.
					           (RedoCard withFillOut: 2).
					           WhiteCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame use: (SpeedCard with: 1) on: 2.
	aGame use: (RedoCard withFillOut: 2) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 20.
	self assert: (aGame positionOf: 2) equals: 32
]

{ #category : 'tests' }
RedoCardTest >> testWhenSpaceShipPlaysRepeatCardAndRedoCardThenItAppliesTheEffectTwice [

	| aGame aDiceSet aBoard aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 19 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 100. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (RepeatCard withObjective: 1).
					           (RedoCard withFillOut: 1) })
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.
	aGame start.
	aGame use: (RepeatCard withObjective: 1) on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.

	self assert: (aGame positionOf: 1) equals: 8
]

{ #category : 'tests' }
RedoCardTest >> testWhenSpaceShipPlaysTwoRedoCardTogetherWithNoOtherCardToRedoThenNothingHappens [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 19 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           (RedoCard withFillOut: 1).
					           (RedoCard withFillOut: 1) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 20.
]

{ #category : 'tests' }
RedoCardTest >> testWhenTheOnlyCardPlayedIsRedoThenTheCardHasNoEffect [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 7 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith:
		          (OrderedCollection withAll: { (RedoCard withFillOut: 1) })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 8
]
