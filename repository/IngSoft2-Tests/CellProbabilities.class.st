Class {
	#name : 'CellProbabilities',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CellProbabilities >> testA [

	| aConfigDiceSet boardSize numberOfCells anEffect aGameBoard |
	aConfigDiceSet := RiggedDice new initializeWith:
		                  { 24. 20. 20. 8. 2. 10. 10. 1. 5. 100. 0. 3. 30. 20.
		                  10. 6. 4. 2. 5. 7. 7. 7. 7. 7. 7. 10. 6. 4. 2. 5. 7.
		                  7. 7. 7. 7. 0. 3 }.
	aConfigDiceSet setMaximumValueAs: 10.
	
	boardSize := 1002.
	
	aGameBoard := CellPlacement new
		              createBoardWith: aConfigDiceSet
		              withComplementary: boardSize.
		
	anEffect := BlackHoleEffect withBackTrack: -4.

	numberOfCells := ProbabilityCounter new
		                 initializeToCountFrom: aGameBoard
		                 theCellsThatHave: anEffect.

	self assert: (numberOfCells between: 235 and: 245)
]
