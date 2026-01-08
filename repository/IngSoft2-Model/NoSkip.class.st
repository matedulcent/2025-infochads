Class {
	#name : 'NoSkip',
	#superclass : 'Object',
	#instVars : [
		'nextSkipState'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
NoSkip class >> withNext: aSkipState [

	^ self new initializeWithNext: aSkipState.
]

{ #category : 'initialization' }
NoSkip >> initializeWithNext: aSkipState [

	nextSkipState := aSkipState.
]

{ #category : 'as yet unclassified' }
NoSkip >> will: aSpaceShip skipAfter: aDiceRoll on: aGame [

	aSpaceShip isImprisionedByTossing: aDiceRoll on: aGame
]
