Class {
	#name : 'ActiveCardHolder',
	#superclass : 'Object',
	#instVars : [
		'activeCards',
		'lastCardActivated'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
ActiveCardHolder class >> withPlayers: arg1 [

	^ self new initializeWithPlayers: arg1
]

{ #category : 'adding' }
ActiveCardHolder >> addActive: aCard to: aShip [

	lastCardActivated := aCard.
	(activeCards at: aShip id) add: aCard
]

{ #category : 'adding' }
ActiveCardHolder >> addLastPermanentCardTo: aShip [

	self addActive: lastCardActivated to: aShip
]

{ #category : 'initialization' }
ActiveCardHolder >> createCardPositionsOf: spaceShips [

	spaceShips do: [ :ship |
		activeCards at: ship id put: OrderedCollection new ]
]

{ #category : 'initialization' }
ActiveCardHolder >> initializeWithPlayers: spaceShips [

	activeCards := Dictionary new.
	lastCardActivated := WhiteCard new.
	self createCardPositionsOf: spaceShips
]

{ #category : 'removing' }
ActiveCardHolder >> removeActive: aCard from: aShipId [

	| cards removedCard |
	cards := activeCards at: aShipId ifAbsent: [ ^ self ].

	removedCard := cards
		               detect: [ :each |
			               (each isKindOf: aCard class) and:
				               each helper = aCard helper ]
		               ifNone: [
			               Error signal:
				               'This card cant be played if the card to be canceled is not active.' ].


	cards remove: removedCard.
	^ removedCard
]
