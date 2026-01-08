Class {
	#name : 'Retained',
	#superclass : 'ShipState',
	#instVars : [
		'escapeValue',
		'freedomCondition'
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
	freedomCondition := false. "borrar"
]

{ #category : 'testing' }
Retained >> isFreeByTossing: aDiceToss [

	^ aDiceToss >= escapeValue
]

{ #category : 'as yet unclassified' }
Retained >> playTurnFor: aSpaceShip with: aDiceRoll in: aGame [

	(self isFreeByTossing: aDiceRoll) ifFalse: [ ^ self ].
	aSpaceShip changeStateToFree.
	aGame move: aSpaceShip after: aDiceRoll.
	"^self"
]
