Class {
	#name : 'CancelationAction',
	#superclass : 'CardAction',
	#instVars : [
		'targetCard',
		'targetShip',
		'game'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CancelationAction class >> to: aCard on: aShip in: aGame [

	^ self new initializeTo: aCard on: aShip in: aGame
]

{ #category : 'private' }
CancelationAction >> apply [

	game cancel: targetCard on: targetShip
]

{ #category : 'initialization' }
CancelationAction >> initializeTo: aCard on: aShip in: aGame [

	targetCard := aCard.
	targetShip := aShip.
	game := aGame.
]

{ #category : 'accessing' }
CancelationAction >> prototype [

	^ [ :newShip :aGame :aCard |
	  self class to: aCard on: newShip in: aGame ]
]
