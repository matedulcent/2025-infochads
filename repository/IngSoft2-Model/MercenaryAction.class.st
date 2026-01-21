Class {
	#name : 'MercenaryAction',
	#superclass : 'CardAction',
	#instVars : [
		'helperId',
		'ship',
		'cardSystem'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
MercenaryAction class >> helper: aHelperId on: aShip in: aGame [

	^ self new initializeHelper: aHelperId on: aShip in: aGame
]

{ #category : 'private' }
MercenaryAction >> apply [

	cardSystem assertMercenaryIsNotHelpingAnotherShip: helperId.
	cardSystem stablish: helperId on: ship
]

{ #category : 'initialization' }
MercenaryAction >> initializeHelper: aHelperId on: aShip in: aCardSystem [

	helperId := aHelperId.
	ship := aShip.
	cardSystem := aCardSystem.
	^ self
]

{ #category : 'accessing' }
MercenaryAction >> prototype [

	^ [ :newShip :aGame :helper |
	  self class helper: helper on: newShip in: aGame ]
]
