Class {
	#name : 'Retained',
	#superclass : 'Free',
	#instVars : [
		'escapeValue'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Retained class >> withValue: anEscapeValue [

	^ self new initializeWith: anEscapeValue
]

{ #category : 'initialization' }
Retained >> initializeWith: anEscapeValue [

	escapeValue := anEscapeValue.
]

{ #category : 'testing' }
Retained >> isFreeByTossing: aDiceToss [

	^ aDiceToss >= escapeValue
]

{ #category : 'testing' }
Retained >> isLockedUp [
	"borrar"
	^ true
]

{ #category : 'as yet unclassified' }
Retained >> playTurnFor: aSpaceShip with: aDiceRoll in: aGame [
	"akward roll"

	(self isFreeByTossing: aDiceRoll) ifFalse: [
		aGame rollTheDice.
		^ self ].
	aSpaceShip changeStateToFree.
	aGame move: aSpaceShip after: aDiceRoll
]
