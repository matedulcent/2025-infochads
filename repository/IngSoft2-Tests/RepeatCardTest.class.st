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
		                     { 0. 100. 0. 0. 0. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection with: (RedoCard withObjective ))
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.
		
	aGame use: (RedoCard withObjective ) on: 1.
	aGame start.
	
	self assert: (aGame positionOf: 1) equals: 17
]

{ #category : 'tests' }
RepeatCardTest >> testWhenTheLastPowerUpWasABlackHoleAndTheRepeteCardWasPlayedOnItSelfThenTheShipMoves8PositionsBack [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 19 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 100. 0. 0. 0. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection with: (RedoCard withObjective ))
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.
		
	aGame start.
	aGame use: (RedoCard withObjective ) on: 1.
	
	self assert: (aGame positionOf: 1) equals: 12
]

{ #category : 'tests' }
RepeatCardTest >> testWhenTheLastPowerUpWasABlackHoleTriggerdByAnotherPlayerThenTheEffectIsAppliedOnTheRedoCardShip [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 14. 19 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 100. 0. 0. 0. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection withAll: {
					           RedoCard withObjective.
					           WhiteCard new.
					           RedoCard withObjective })
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	aGame use: RedoCard withObjective on: 2.

	self assert: (aGame positionOf: 1) equals: 11.
	self assert: (aGame positionOf: 2) equals: 12
]
