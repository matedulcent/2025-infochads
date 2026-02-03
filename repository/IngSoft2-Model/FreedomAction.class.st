Class {
	#name : 'FreedomAction',
	#superclass : 'CardAction',
	#instVars : [
		'ship'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
FreedomAction class >> on: aShip [

	^ self new initializeOn: aShip
]

{ #category : 'private' }
FreedomAction >> apply [

	ship state: ship state setFreeByCard
]

{ #category : 'initialization' }
FreedomAction >> initializeOn: aShip [

	ship := aShip.
	^ self.
]

{ #category : 'accessing' }
FreedomAction >> prototype [

	^ [ :newShip :cardSystem :additional | self class on: newShip ]
]
