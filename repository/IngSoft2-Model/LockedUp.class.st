Class {
	#name : 'LockedUp',
	#superclass : 'Object',
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
