Class {
	#name : 'HyperGravityEffect',
	#superclass : 'Effect',
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

{ #category : 'as yet unclassified' }
HyperGravityEffect >> applyOn: aShip in: aCellSystem [

	aShip changeStateToRetainedAndNeeds: valueToEscape
]

{ #category : 'initialization' }
HyperGravityEffect >> initializeWith: aValueToEscape [

	valueToEscape := aValueToEscape
]

{ #category : 'as yet unclassified' }
HyperGravityEffect >> prototype [

	| value |
	value := valueToEscape.
	^ [ self class with: value ]
]
