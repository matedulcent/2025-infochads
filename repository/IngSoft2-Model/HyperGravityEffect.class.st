Class {
	#name : 'HyperGravityEffect',
	#superclass : 'NoEffect',
	#instVars : [
		'valueToEscape'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperGravityEffect class >> mustBePositive: aValueToEscape [

	aValueToEscape > 0 ifFalse: [
		Error signal:
			'The Value to escape de Hyper Gravity cell must be positive ' ]
]

{ #category : 'instance creation' }
HyperGravityEffect class >> with: aValueToEscape [

	self mustBePositive: aValueToEscape.

	^ self new initializeWith: aValueToEscape
]

{ #category : 'initialization' }
HyperGravityEffect >> initializeWith: aValueToEscape [

	valueToEscape := aValueToEscape
]

{ #category : 'as yet unclassified' }
HyperGravityEffect >> lock: aSpaceShip [

	aSpaceShip lockedUpAndNeeds: valueToEscape
]
