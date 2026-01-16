Class {
	#name : 'RepeatCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RepeatCardTest >> testWhenNoOneHasPlayedYetThenTeRepeatCardHasNoEffect [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 20 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 100. 0. 0. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30.
		                     20. 10. 6. 4. 2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: { RepeatCard new })
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame use: (RepeatCard withObjective: 2) on: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 17
]

{ #category : 'tests' }
RepeatCardTest >> testWhenTheLastPowerUpWasABlackHoleAndTheRepeteCardWasPlayedOnItSelfThenTheShipMoves8PositionsBack [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 19 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 100. 0. 0. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: { RepeatCard new })
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	aGame use: (RepeatCard withObjective: 1) on: 1.

	self assert: (aGame positionOf: 1) equals: 12
]

{ #category : 'tests' }
RepeatCardTest >> testWhenTheLastPowerUpWasABlackHoleTriggerdByAnotherPlayerThenTheEffectIsAppliedOnTheRepeatCardShip [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 14. 19 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 100. 0. 0. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           RepeatCard new.
					           WhiteCard new.
					           RepeatCard new })
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	aGame use: (RepeatCard withObjective: 2) on: 2.

	self assert: (aGame positionOf: 1) equals: 11.
	self assert: (aGame positionOf: 2) equals: 12
]

{ #category : 'tests' }
RepeatCardTest >> testWhenTheLastPowerUpWasAnAtomicBombThenAllShieldsAreDeductedOnceMore [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 14 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 100. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           RepeatCard new.
					           WhiteCard new.
					           RepeatCard new })
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	aGame use: (RepeatCard withObjective: 2) on: 2.

	self assert: (aGame shieldOf: 1) equals: 1.
	self assert: (aGame shieldOf: 2) equals: 1
]
