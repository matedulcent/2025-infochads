Class {
	#name : 'RepeatAction',
	#superclass : 'CardAction',
	#instVars : [
		'game',
		'targetShipId'
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

	game repeatLastCellEffectOn: targetShipId "ver"
]

{ #category : 'initialization' }
RepeatAction >> initializeOn: aShipId in: aGame [

	game := aGame.
	targetShipId := aShipId.
	^ self
]

{ #category : 'accessing' }
RepeatAction >> prototype [

	^ [ :aShip :aGame :additional |
	  self class on: (additional ifNil: [ aShip id ]) in: aGame ]
]
