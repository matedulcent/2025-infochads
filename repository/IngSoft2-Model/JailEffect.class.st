Class {
	#name : 'JailEffect',
	#superclass : 'Effect',
	#instVars : [
		'jailOutValue'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
JailEffect class >> with: aJailOutValue [

	aJailOutValue > 0 ifFalse: [
		Error signal: 'The Jail-Out dice toss must be positive.' ].

	^ self new initializeWith: aJailOutValue
]

{ #category : 'as yet unclassified' }
JailEffect >> applyOn: aShip in: aCellSystem [

	aShip changeStateToLockedUpAndNeeds: jailOutValue
]

{ #category : 'initialization' }
JailEffect >> initializeWith: aJailOutValue [

	jailOutValue := aJailOutValue
]

{ #category : 'accessing' }
JailEffect >> prototype [

	| value |
	value := jailOutValue.
	^ [ self class with: value ]
]
