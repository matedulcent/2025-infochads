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
SkipStates >> the: aSpaceShip hasTossed0On: aDiceRoll [

	aDiceRoll = 0 ifTrue: [
		aSpaceShip changeSkippingStateTo: SkipForShields.
		^ true ].

	^ false
]

{ #category : 'as yet unclassified' }
SkipStates >> will: aSpaceShip skipAfter: aDiceRoll on: aGame [

	(self the: aSpaceShip hasTossed0On: aDiceRoll) ifTrue: [ ^ self ].
	aSpaceShip isImprisionedByTossing: aDiceRoll on: aGame
]
