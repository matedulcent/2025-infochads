Class {
	#name : 'PowerCellInteractionTest',
	#superclass : 'TestCase',
	#instVars : [
		'board'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PowerCellInteractionTest >> boardWithSize: aSize andConfig: aCellConfig [

	^ Board
		  withSize: aSize
		  composedOf: (WormHole startingAt: 1 endingAt: 1)
		  playedWith: (CardDeck withCards: {  })
		  andACellConfiguration: aCellConfig
]

{ #category : 'tests' }
PowerCellInteractionTest >> gameWithDice: dice players: amount laps: numberOfLaps [

	^ Game
		  playedIn: board
		  by: amount
		  throwing: dice
		  wonAfter: numberOfLaps
]

{ #category : 'tests' }
PowerCellInteractionTest >> setUp [

	super setUp.

	board := self
		         boardWithSize: 10
		         andConfig: (RiggedDice new initializeWith:
				          { 0. 0. 0. 100. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20. 10 })
]

{ #category : 'asserting' }
PowerCellInteractionTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

    self
        should: anErrorBlock
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: (error messageText) equals:
                errorMessage ]
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenAForthShipMovesToAHyperJumpWith100ParsecDivisionAnd30_20_10JumpsThenItMoves30JumpsAndCombatsWithFirstShip [

	| aGame |
	board := self
		         boardWithSize: 100
		         andConfig: (RiggedDice new initializeWith:
				          { 0. 0. 0. 100. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20. 10 }).
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 2. 2. 2. 2. 5 })
		         players: 4
		         laps: 4.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 33.
	self assert: (aGame positionOf: 2) equals: 23.
	self assert: (aGame positionOf: 3) equals: 13.
	self assert: (aGame positionOf: 4) equals: 1
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenARandomizedBoardThenTheFirstAndLastPositionsAreNormalCells [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 50. 49 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 24. 20. 20. 8. 2. 10. 10. 1. 5. 100. 0. 3. 30.
		                     20. 10. 6. 4. 2. 5. 7. 7. 7. 7. 7. 7. 10. 6. 4.
		                     2. 5. 7. 7. 7. 7. 7. 0. 3 }.
	aConfigureDiceSet setMaximumValueAs: 10.
	board := self boardWithSize: 50 andConfig: aConfigureDiceSet.
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 50. 49 })
		         players: 2
		         laps: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame positionOf: 2) equals: 50
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenAShipMovesLandsOnAPowerCellAndMovesDueToItThenTheNextPowerCellDoesNotAffect [

	| aGame |
	board := self
		         boardWithSize: 50
		         andConfig: (RiggedDice new initializeWith:
				          { 0. 0. 100. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20. 10. 6.
				          4. 2. 5. 7 }).
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 37 })
		         players: 1
		         laps: 2.


	aGame start.
	self assert: (aGame positionOf: 1) equals: 42
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenAShipMovesToAHyperJumpWith50ParsecDivisionAnd30_20_10JumpsThenItMoves30Jumps [

	| aGame |
	board := self
		         boardWithSize: 50
		         andConfig: (RiggedDice new initializeWith:
				          { 0. 0. 0. 100. 0. 0. 0. 0. 0. 50. 0. 3. 30. 20. 10. 6. 4.
				          2. 5. 7 }).
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 40 })
		         players: 4
		         laps: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 21
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenAThirdShipMovesToAHyperJumpWith100ParsecDivisionAnd30_20_10JumpsThenItMoves10Jumps [

	| aGame |
	board := self
		         boardWithSize: 50
		         andConfig: (RiggedDice new initializeWith:
				          { 0. 0. 0. 100. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20. 10. 6.
				          4. 2. 5. 7 }).
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 40. 40. 40 })
		         players: 3
		         laps: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 3) equals: 46
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenAnotherShipMovesToAHyperJumpWith100ParsecDivisionAnd30_20_10JumpsThenItMoves20Jumps [

	| aGame |
	board := self
		         boardWithSize: 50
		         andConfig: (RiggedDice new initializeWith:
				          { 0. 0. 0. 100. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20. 10. 6.
				          4. 2. 5. 7 }).
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 40. 40 })
		         players: 2
		         laps: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 2) equals: 1
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenShipIsMovedByAnEffectToAWormHoleThenIsTPdToACellThatHasNoEffectOnTheShip [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 30 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 100. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 35 endingAt: 4)
		          playedWith: (CardDeck withCards: {  })
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 4
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenShipMovesToAAtomicBombCellThenAllShipsReturnToBeguiningAndLose1Shield [

	| aGame |
	board := self
		         boardWithSize: 50
		         andConfig: (RiggedDice new initializeWith:
				          { 0. 0. 0. 0. 100. 0. 0. 0. 0. 100. 0. 3. 30. 20. 10. 6.
				          4. 2. 5. 7 }).
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 49. 10 })
		         players: 2
		         laps: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame shieldOf: 2) equals: 2
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenShipMovesToABlackHoleCellThenItGoesBack4Spaces [

	| aGame |
	board := self
		         boardWithSize: 100
		         andConfig: (RiggedDice new initializeWith:
				          { 0. 100. 0. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20. 10. 6.
				          4. 2. 5. 7 }).
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 20 })
		         players: 1
		         laps: 1.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 17
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenShipMovesToAHyperJumpWith100ParsecDivisionAnd30_20_10JumpsThenItMoves30Moves [

	| aGame |
	board := self
		         boardWithSize: 50
		         andConfig: (RiggedDice new initializeWith:
				          { 0. 0. 0. 100. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20. 10. 6.
				          4. 2. 5. 7 }).
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 40 })
		         players: 1
		         laps: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 6
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenShipMovesToAHyperSpaceJumpCellThenItMovesForward4SpacesAndLose1Shield [

	| aGame |
	board := self
		         boardWithSize: 50
		         andConfig: (RiggedDice new initializeWith:
				          { 0. 0. 100. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20. 10. 6.
				          4. 2. 5. 7 }).
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 30 })
		         players: 1
		         laps: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 35.
	self assert: (aGame shieldOf: 1) equals: 2
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenShipMovesToAMoonWalkCellOf4ThenItMovesEveryShipExceptForSelectedBack4Steps [

	| aGame |
	board := self
		         boardWithSize: 50
		         andConfig: (RiggedDice new initializeWith:
				          { 0. 0. 0. 0. 0. 100. 0. 0. 0. 100. 0. 3. 30. 20. 10. 4.
				          4. 4. 4. 4. 0 }).
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 10. 11. 46 })
		         players: 3
		         laps: 1.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 3.
	self assert: (aGame positionOf: 2) equals: 8.
	self assert: (aGame positionOf: 3) equals: 47
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenShipMovesToAMoonWalkCellOf6ThenItMovesEveryShipExceptForSelectedBack6Steps [

	| aGame |
	board := self
		         boardWithSize: 100
		         andConfig: (RiggedDice new initializeWith:
				          { 0. 0. 0. 0. 0. 100. 0. 0. 0. 100. 0. 3. 30. 20. 10. 6.
				          6. 6. 6. 6. 6. 0 }).
	aGame := self
		         gameWithDice:
		         (RiggedDice new initializeWith: { 50. 60. 70 })
		         players: 3
		         laps: 1.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 39.
	self assert: (aGame positionOf: 2) equals: 55.
	self assert: (aGame positionOf: 3) equals: 71
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenShipMovesToAMoonWalkCellOf6ThenShipWithNegativePositionMoveToBeguiningOfLap [

	| aGame |
	board := self
		         boardWithSize: 50
		         andConfig: (RiggedDice new initializeWith:
				          { 0. 0. 0. 0. 0. 100. 0. 0. 0. 0. 100. 0. 3. 30. 20. 10.
				          6. 6. 6. 6. 6. 6. 0 }).
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 2. 3. 45 })
		         players: 3
		         laps: 1.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 3) equals: 46
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenShipMovesToNormalCellThenItStaysThere [

	| aGame |
	board := self
		         boardWithSize: 50
		         andConfig: (RiggedDice new initializeWith:
				          { 100. 0. 0. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20. 10. 6.
				          4. 2. 5. 7 }).
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 1 })
		         players: 1
		         laps: 1.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 2
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenShipMovesToNormalInABiggerBoardCellThenItStaysThere [

	| aGame |
	board := self
		         boardWithSize: 100
		         andConfig: (RiggedDice new initializeWith:
				          { 100. 0. 0. 0. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20. 10. 6.
				          4. 2. 5. 7. 5. 6. 3. 4. 2 }).
	aGame := self
		         gameWithDice: (RiggedDice new initializeWith: { 38 })
		         players: 1
		         laps: 1.
	aGame start.
	self assert: (aGame positionOf: 1) equals: 39
]

{ #category : 'tests' }
PowerCellInteractionTest >> testWhenTheProbabilitiesDontSum100ThenCreationFails [

	| aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 2. 2. 2. 2. 5 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 99. 0. 0. 100. 3. 30. 20. 10 }.

	self
		should: [
			Board
				withSize: 100
				composedOf: (WormHole startingAt: 1 endingAt: 1)
				playedWith: (CardDeck withCards: {  })
				andACellConfiguration: aConfigureDiceSet ]
		raise: Error
		withMessageText: 'The probabilites dont sum 100.'
]
