Class {
	#name : 'LockedUp',
	#superclass : 'Free',
	#instVars : [
		'escapeValue'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
LockedUp class >> withValue: anEscapeValue [

	^ self new initializeWith: anEscapeValue
]

{ #category : 'testing' }
LockedUp >> canBattleWithShield: shield [

	^ false
]

{ #category : 'initialization' }
LockedUp >> initializeWith: anEscapeValue [

	escapeValue := anEscapeValue
]

{ #category : 'testing' }
LockedUp >> isFreeByTossing: aDiceToss [

	^ aDiceToss = escapeValue
]

{ #category : 'testing' }
LockedUp >> isLockedUp [
	
	^ true
]

{ #category : 'as yet unclassified' }
LockedUp >> playTurnFor: aSpaceShip with: aDiceRoll in: aGame [

	aDiceRoll = escapeValue ifFalse: [
		aGame rollTheDice.
		^ self ].
	aSpaceShip state: Free new.
	aGame move: aSpaceShip after: aDiceRoll
]

{ #category : 'initialization' }
LockedUp >> setFreeByCard [

	^ Free new
]
