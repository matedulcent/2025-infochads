Class {
	#name : 'SkipStates',
	#superclass : 'Object',
	#instVars : [
		'nextSkipState'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SkipStates class >> withNext: aSkipState [

	^ self new initializeWithNext: aSkipState.
]

{ #category : 'initialization' }
SkipStates >> initializeWithNext: aSkipState [

	nextSkipState := aSkipState.
]

{ #category : 'as yet unclassified' }
SkipStates >> will: aSpaceShip skipAfter: aDiceRoll on: aGame [
	
	aSpaceShip isImprisionedByTossing: aDiceRoll on: aGame 
	
]
