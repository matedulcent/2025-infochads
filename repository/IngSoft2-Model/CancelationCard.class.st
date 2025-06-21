Class {
	#name : 'CancelationCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'card',
		'type',
		'shipID'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CancelationCard class >> withObjective: aCard  ofSpaceShip: spaceShipID [

	^ self new initializeWithObjective: aCard of: spaceShipID 
]

{ #category : 'as yet unclassified' }
CancelationCard >> cardObjective: aCard [

	^ card
]

{ #category : 'initialization' }
CancelationCard >> initializeWithObjective: aCard of: spaceShipID [ 

	super initializes.
	card := aCard.
	shipID := spaceShipID.
	type := 'Instantaneous'
]

{ #category : 'as yet unclassified' }
CancelationCard >> objective: aSpaceShipId [

	^ shipID
]

{ #category : 'accessing' }
CancelationCard >> type [

	^ type
]
