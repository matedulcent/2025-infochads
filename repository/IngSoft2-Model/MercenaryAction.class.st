Class {
	#name : 'MercenaryAction',
	#superclass : 'CardAction',
	#instVars : [
		'helperId',
		'ship',
		'game'
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

	game assertMercenaryIsNotHelpingAnotherShip: helperId.
	game stablish: helperId on: ship
]

{ #category : 'initialization' }
MercenaryAction >> initializeHelper: aHelperId on: aShip in: aGame [

	helperId := aHelperId.
	ship := aShip.
	game := aGame.
	^ self
]

{ #category : 'accessing' }
MercenaryAction >> prototype [

	^ [ :newShip :aGame :helper |
	  self class helper: helper on: newShip in: aGame ]
]
