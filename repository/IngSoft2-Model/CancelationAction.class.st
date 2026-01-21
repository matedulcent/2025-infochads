Class {
	#name : 'CancelationAction',
	#superclass : 'CardAction',
	#instVars : [
		'targetCard',
		'targetShip',
		'cardSystem'
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

	cardSystem cancel: targetCard on: targetShip
]

{ #category : 'initialization' }
CancelationAction >> initializeTo: aCard on: aShipId in: aCardSystem [

	targetCard := aCard.
	targetShip := aShipId.
	cardSystem := aCardSystem.
]

{ #category : 'accessing' }
CancelationAction >> prototype [

	| card |
	card := targetCard.

	^ [ :redoShip :aCardSystem :helperShip |
	  self class to: card on: helperShip in: cardSystem ]
]
