Class {
	#name : 'CellProbabilities',
	#superclass : 'TestCase',
	#instVars : [
		'aConfigDiceSet',
		'boardSize',
		'aGameBoard'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'documentation' }
CellProbabilities >> README [ 

	"The contemplated error is +-0.75%"
]

{ #category : 'running' }
CellProbabilities >> setUp [

	super setUp.

	aConfigDiceSet := RiggedDice new initializeWith:
		                  { 24. 20. 20. 8. 2. 10. 10. 1. 5. 100. 0. 3. 30. 20.
		                  10. 6. 4. 2. 5. 7. 7. 7. 7. 7. 7. 10. 6. 4. 2. 5. 7.
		                  7. 7. 7. 7. 0. 3 }.
	aConfigDiceSet setMaximumValueAs: 10.

	boardSize := 10002.

	aGameBoard := CellPlacement new
		              createBoardWith: aConfigDiceSet
		              withComplementary: boardSize
]

{ #category : 'tests' }
CellProbabilities >> testWhenTheBoardIsGeneratedThenAtomicBombCellsAreApproximatelyTwoPercent [

	| numberOfCells |
	numberOfCells := ProbabilityCounter new
		                 initializeToCountFrom: aGameBoard
		                 theCellsThatHave: AtomicBombEffect .

	self assert: (numberOfCells between: 125 and: 275)
]

{ #category : 'tests' }
CellProbabilities >> testWhenTheBoardIsGeneratedThenBlackHoleCellsAreApproximatelyTwentyPercent [

	| numberOfCells |
	numberOfCells := ProbabilityCounter new
		                 initializeToCountFrom: aGameBoard
		                 theCellsThatHave: BlackHoleEffect.

	self assert: (numberOfCells between: 1925 and: 2075)
]

{ #category : 'tests' }
CellProbabilities >> testWhenTheBoardIsGeneratedThenCardCellsAreApproximatelyTenPercent [

	| numberOfCells |
	numberOfCells := ProbabilityCounter new
		                 initializeToCountFrom: aGameBoard
		                 theCellsThatHave: CardEffect.

	self assert: (numberOfCells between: 925 and: 1075)
]

{ #category : 'tests' }
CellProbabilities >> testWhenTheBoardIsGeneratedThenHyperGravityCellsAreApproximatelyFivePercent [

	| numberOfCells |
	numberOfCells := ProbabilityCounter new
		                 initializeToCountFrom: aGameBoard
		                 theCellsThatHave: HyperGravityEffect .

	self assert: (numberOfCells between: 425 and: 575)
]

{ #category : 'tests' }
CellProbabilities >> testWhenTheBoardIsGeneratedThenHyperJumpCellsAreApproximatelyEightPercent [

	| numberOfCells |
	numberOfCells := ProbabilityCounter new
		                 initializeToCountFrom: aGameBoard
		                 theCellsThatHave: HyperJumpEffect .

	self assert: (numberOfCells between: 725 and: 875)
]

{ #category : 'tests' }
CellProbabilities >> testWhenTheBoardIsGeneratedThenHyperSpaceJumpCellsAreApproximatelyTwentyPercent [

	| numberOfCells |
	numberOfCells := ProbabilityCounter new
		                 initializeToCountFrom: aGameBoard
		                 theCellsThatHave: HyperSpaceJumpEffect .

	self assert: (numberOfCells between: 1925 and: 2075)
]

{ #category : 'tests' }
CellProbabilities >> testWhenTheBoardIsGeneratedThenJailCellsAreApproximatelyOnePercent [

	| numberOfCells |
	numberOfCells := ProbabilityCounter new
		                 initializeToCountFrom: aGameBoard
		                 theCellsThatHave: JailEffect .

	self assert: (numberOfCells between: 25 and: 175)
]

{ #category : 'tests' }
CellProbabilities >> testWhenTheBoardIsGeneratedThenMoonWalkCellsAreApproximatelyTenPercent [

	| numberOfCells |
	numberOfCells := ProbabilityCounter new
		                 initializeToCountFrom: aGameBoard
		                 theCellsThatHave: MoonWalkEffect .

	self assert: (numberOfCells between: 925 and: 1075)
]

{ #category : 'tests' }
CellProbabilities >> testWhenTheBoardIsGeneratedThenNormalCellsAreApproximatelyTwentyFourPercent [

	| numberOfCells |
	numberOfCells := ProbabilityCounter new
		                 initializeToCountFrom: aGameBoard
		                 theCellsThatHave: Normal.

	self assert: (numberOfCells between: 2325 and: 2475)
]
