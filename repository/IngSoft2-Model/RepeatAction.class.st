Class {
	#name : 'RepeatAction',
	#superclass : 'CardAction',
	#instVars : [
		'game',
		'targetShipId',
		'cardSystem'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
RepeatAction class >> on: aShip in: aGame [

	^ self new initializeOn: aShip in: aGame
]

{ #category : 'private' }
RepeatAction >> apply [

	cardSystem repeatLastCellEffectOn: targetShipId
]

{ #category : 'initialization' }
RepeatAction >> initializeOn: aShipId in: aCardSystem [

	cardSystem := aCardSystem.
	targetShipId := aShipId.
	^ self
]

{ #category : 'accessing' }
RepeatAction >> prototype [

	^ [ :aShip :aCardSystem :additional |
	  self class on: (additional ifNil: [ aShip id ]) in: aCardSystem ]
]
