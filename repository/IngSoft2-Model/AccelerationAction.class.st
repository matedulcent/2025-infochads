Class {
	#name : 'AccelerationAction',
	#superclass : 'ActionGroupCard',
	#instVars : [
		'ship',
		'game'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
AccelerationAction class >> on: aShip in: aGame [

	^ self new initializeOn: aShip in: aGame
]

{ #category : 'private' }
AccelerationAction >> apply [

	game incrementAllBoosters 
]

{ #category : 'initialization' }
AccelerationAction >> initializeOn: aShip in: aGame [

	ship := aShip.
	game := aGame.
	^ self
]

{ #category : 'accessing' }
AccelerationAction >> prototype [

	^ [ :newShip :aGame | AccelerationAction on: newShip in: aGame ]
]
