Class {
	#name : 'SpeedAction',
	#superclass : 'ActionGroupCard',
	#instVars : [
		'ship',
		'game'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
SpeedAction class >> on: aShip in: aGame [

	^ self new initializeOn: aShip in: aGame
]

{ #category : 'private' }
SpeedAction >> apply [

	ship incrementBooster
]

{ #category : 'initialization' }
SpeedAction >> initializeOn: aShip in: aGame [

	ship := aShip.
	game := aGame.
	^ self
]

{ #category : 'accessing' }
SpeedAction >> prototype [

	^ [ :newShip :aGame :additional | SpeedAction on: newShip in: aGame ]
]
