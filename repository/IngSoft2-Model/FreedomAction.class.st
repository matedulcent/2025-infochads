Class {
	#name : 'FreedomAction',
	#superclass : 'ActionGroupCard',
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

	ship changeStateToFreeByCard
]

{ #category : 'initialization' }
FreedomAction >> initializeOn: aShip [

	ship := aShip.
	^ self.
]

{ #category : 'accessing' }
FreedomAction >> prototype [

	^ [ :newShip :game | FreedomAction on: newShip ]
]
