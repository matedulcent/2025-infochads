Class {
	#name : 'DoubleTurnAction',
	#superclass : 'CardAction',
	#instVars : [
		'game',
		'ship'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
DoubleTurnAction class >> on: aShip in: aGame [

	^ self new initializeOn: aShip in: aGame
]

{ #category : 'private' }
DoubleTurnAction >> apply [

	game doubleTurnOn: ship
]

{ #category : 'initialization' }
DoubleTurnAction >> initializeOn: aShip in: aGame [

	game := aGame.
	ship := aShip.
	^ self
]

{ #category : 'accessing' }
DoubleTurnAction >> prototype [

	^ [ :newShip :aGame :additional |
	  self class on: newShip in: aGame ]
]
