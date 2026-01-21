Class {
	#name : 'SkipForSkipping',
	#superclass : 'SkipState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SkipForSkipping >> initializeWithNext: aSkipState [

	nextSkipState := aSkipState
]

{ #category : 'as yet unclassified' }
SkipForSkipping >> playTurnFor: aShip with: aDiceRoll in: aGame [

	aShip skipState: nextSkipState
]
