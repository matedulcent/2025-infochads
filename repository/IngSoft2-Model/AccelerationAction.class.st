Class {
	#name : 'AccelerationAction',
	#superclass : 'CardAction',
	#instVars : [
		'ship',
		'cardSystem'
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
	
	cardSystem incrementAllBoosters 
]

{ #category : 'initialization' }
AccelerationAction >> initializeOn: aShip in: aCardSystem [

	ship := aShip.
	cardSystem := aCardSystem.
	^ self
]

{ #category : 'accessing' }
AccelerationAction >> prototype [

	^ [ :newShip :aCardSystem :additional |
	  self class on: newShip in: aCardSystem ]
]
