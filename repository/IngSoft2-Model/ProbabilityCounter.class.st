Class {
	#name : 'ProbabilityCounter',
	#superclass : 'Object',
	#instVars : [
		'gameBoard',
		'numberOfCellsOfCertainType'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
ProbabilityCounter >> initializeToCount: aGameBoard [

	gameBoard := aGameBoard.
	numberOfCellsOfCertainType := 0.
	^ numberOfCellsOfCertainType
]

{ #category : 'as yet unclassified' }
ProbabilityCounter >> numberOfCells: type [

	| counter |

    counter := 0.

    gameBoard do: [ :cell |
        (cell effect isKindOf: type) ifTrue: [
            counter := counter + 1
        ].
    ].
]
