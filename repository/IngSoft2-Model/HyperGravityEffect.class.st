Class {
	#name : 'HyperGravityEffect',
	#superclass : 'NoEffect',
	#instVars : [
		'valueToEscape'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
HyperGravityEffect class >> with: aValueToEscape [

	aValueToEscape > 0 ifFalse: [
		Error signal:
			'The Value to escape de Hyper Gravity cell must be positive ' ].

	^ self new initializeWith: aValueToEscape
]

{ #category : 'as yet unclassified' }
HyperGravityEffect >> imprison: aSpaceShip [

	aSpaceShip lockedUpAndNeeds: valueToEscape
]

{ #category : 'initialization' }
HyperGravityEffect >> initializeWith: aValueToEscape [

	valueToEscape := aValueToEscape
]

{ #category : 'as yet unclassified' }
HyperGravityEffect >> lock: aSpaceShip [

	aSpaceShip lockedUpAndNeeds: valueToEscape
]
