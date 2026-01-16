Class {
	#name : 'RepeatAction',
	#superclass : 'CardAction',
	#instVars : [
		'game',
		'targetShip'
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

	game repeatLastCellEffectOn: targetShip
]

{ #category : 'initialization' }
RepeatAction >> initializeOn: aShipId in: aGame [

	game := aGame.
	targetShip := aShipId.
	^ self
]

{ #category : 'accessing' }
RepeatAction >> prototype [

	| ship |
	ship := targetShip.
	^ [ :ignoredShip :aGame :additional | self class on: ship in: aGame ]
]
