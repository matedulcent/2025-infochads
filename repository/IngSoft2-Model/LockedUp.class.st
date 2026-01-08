Class {
	#name : 'LockedUp',
	#superclass : 'ShipState',
	#instVars : [
		'escapeValue',
		'freedomCondition'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
LockedUp class >> withValue: anEscapeValue [

	^ self new initializeWith: anEscapeValue
]

{ #category : 'adding' }
LockedUp >> addFreedomCardCondition [
	"borrar"
	freedomCondition := true.
]

{ #category : 'testing' }
LockedUp >> canBeFreed [
	"borrar"
	^ freedomCondition
]

{ #category : 'initialization' }
LockedUp >> initializeWith: anEscapeValue [

	escapeValue := anEscapeValue.
	freedomCondition := false. "borrar"
]

{ #category : 'testing' }
LockedUp >> isFreeByTossing: aDiceToss [

	^ aDiceToss = escapeValue
]

{ #category : 'as yet unclassified' }
LockedUp >> playTurnFor: aSpaceShip with: aDiceRoll in: aGame [

	(self isFreeByTossing: aDiceRoll ) ifFalse: [ ^ self ].
	aSpaceShip changeStateToFree.
	aGame move: aSpaceShip after: aDiceRoll.
	"^self"
]
