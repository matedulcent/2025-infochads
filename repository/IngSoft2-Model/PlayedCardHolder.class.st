Class {
	#name : 'PlayedCardHolder',
	#superclass : 'Object',
	#instVars : [
		'lastCardActivated',
		'playedCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
PlayedCardHolder class >> withPlayers: arg1 [

	^ self new initializeWithPlayers: arg1
]

{ #category : 'adding' }
PlayedCardHolder >> add: aCard to: aShip [

	lastCardActivated := aCard.
	(playedCards at: aShip id) add: aCard
]

{ #category : 'adding' }
PlayedCardHolder >> addLastCardTo: aShip [

	self add: lastCardActivated to: aShip
]

{ #category : 'initialization' }
PlayedCardHolder >> createCardPositionsOf: spaceShips [

	spaceShips do: [ :ship |
		playedCards at: ship id put: OrderedCollection new ]
]

{ #category : 'initialization' }
PlayedCardHolder >> initializeWithPlayers: spaceShips [

	playedCards := Dictionary new.
	lastCardActivated := WhiteCard new.
	self createCardPositionsOf: spaceShips
]

{ #category : 'removing' }
PlayedCardHolder >> removeActive: aCard from: aShipId [

	| cards removedCard |
	cards := playedCards at: aShipId ifAbsent: [ ^ self ].

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
