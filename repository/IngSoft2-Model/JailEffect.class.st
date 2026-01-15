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
JailEffect >> imprison: aSpaceShip [
	"cambiar nombre a lock"

	aSpaceShip changeStateToLockedUpAndNeeds: jailOutValue
]

{ #category : 'initialization' }
JailEffect >> initializeWith: aJailOutValue [

	jailOutValue := aJailOutValue
]
