Class {
	#name : 'LockedUp',
	#superclass : 'Object',
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
	
	freedomCondition := true.
]

{ #category : 'testing' }
LockedUp >> canBeFreed [

	^ freedomCondition
]

{ #category : 'initialization' }
LockedUp >> initializeWith: anEscapeValue [

	escapeValue := anEscapeValue.
	freedomCondition := false.
]

{ #category : 'testing' }
LockedUp >> isFreeByTossing: aDiceToss [

	^ aDiceToss = escapeValue
]

{ #category : 'testing' }
LockedUp >> isLockedUp [

	^ true
]
