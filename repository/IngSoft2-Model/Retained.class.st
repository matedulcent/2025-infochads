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

{ #category : 'testing' }
Retained >> canBattleWithShield: shield [

	^ false
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
	
	^ true
]

{ #category : 'as yet unclassified' }
Retained >> playTurnFor: aSpaceShip with: aDiceRoll in: aGame [

	aDiceRoll < escapeValue ifTrue: [
		aGame rollTheDice.
		^ self ].
	aSpaceShip state: Free new.
	aGame move: aSpaceShip after: aDiceRoll
]
