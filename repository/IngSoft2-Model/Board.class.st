Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'wormHole',
		'gameBoard',
		'deckOfCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> assertIsPositiveOverZero: aBoardSize [

	(aBoardSize isInteger and: [ aBoardSize > 0 ]) ifFalse: [
		Error signal: 'Board Size must be a positive interger.' ]
]

{ #category : 'as yet unclassified' }
Board class >> withSize: aBoardSize composedOf: aWormHole playedWith: aDeckOfCards andACellConfiguration: aConfigDiceSet [

	self assertIsPositiveOverZero: aBoardSize.
	^ self new
		  initializeWithSize: aBoardSize
		  composedOf: aWormHole
		  playedWith: aDeckOfCards
		  andConfiguration: aConfigDiceSet
]

{ #category : 'as yet unclassified' }
Board >> adjust: spaceShips positionAnd: totalLaps [

	spaceShips do: [ :ship |
		ship storeageNewPosition:
			(self limitAdjustment: ship position withTotalLaps: totalLaps) ]
]

{ #category : 'as yet unclassified' }
Board >> applyEffectOfCardUponA: aSpaceShip andAll: spaceShips andIts: spaceShipPositions dependingOn: spaceShipCards [

	self
		checkFor: spaceShipCards
		andItsEffectsOver: aSpaceShip
		or: spaceShips
		dependingOn: spaceShipPositions.

	self
		applyEffectOfPowerUpUponA: aSpaceShip
		andAll: spaceShips
		andIts: spaceShipPositions
]

{ #category : 'as yet unclassified' }
Board >> applyEffectOfPowerUpUponA: aSpaceShip andAll: spaceShips andIts: spaceShipPositions [

	| cell |
	gameBoard ifNotEmpty: [
		cell := gameBoard at: (spaceShipPositions at: aSpaceShip id ) position.
		cell takeActionOver: aSpaceShip or: spaceShips thatArePlaced: spaceShipPositions ]
]

{ #category : 'accessing' }
Board >> boardSize [

	^ boardSize
]

{ #category : 'as yet unclassified' }
Board >> checkFor: spaceShipCards andItsEffectsOver: aSpaceShip or: spaceShips dependingOn: spaceShipPositions [

	(spaceShipCards at: aSpaceShip id) do: [ :card |
		spaceShipPositions
			at: aSpaceShip id
			put:
			((spaceShipPositions at: aSpaceShip id) sumTo: card effect) ].
		
	"spaceShipPositions
			at: aSpaceShip id
			put:
			((spaceShipPositions at: aSpaceShip id) sumTo: card effect) ]."
]

{ #category : 'as yet unclassified' }
Board >> checkForPowerUps: aSpaceShip andAllSpaceShips: allSpaceShips [

	| cell |
	gameBoard ifNotEmpty: [
		cell := gameBoard at: aSpaceShip getPosition.
		cell takeAction: aSpaceShip andOtherSpaceShips: allSpaceShips ].

]

{ #category : 'as yet unclassified' }
Board >> checkForWormHole: aPosition [

	^ Position at: (wormHole moveifWormHole: aPosition position) withLaps: 0.
]

{ #category : 'initialization' }
Board >> initializeWithSize: aBoardSize composedOf: aWormHole playedWith: aDeckOfCards andConfiguration: aConfigDiceSet [

	boardSize := aBoardSize.

	gameBoard := CellPlacement new
		             createBoardWithCellConfiguration: aConfigDiceSet
		             andSize: boardSize.
	
	wormHole := aWormHole.
	wormHole mustBeWithInLimits: aBoardSize.
	
	deckOfCards := aDeckOfCards.

]

{ #category : 'as yet unclassified' }
Board >> limitAdjustment: aPosition withTotalLaps: totalLaps [

	aPosition position <= 0 ifTrue: [
		^ Position at: ((aPosition position)negated +1) withLaps: 0 ].

	(self the: aPosition hasReached: totalLaps) ifTrue: [
		^ Position
			  at: boardSize - aPosition position
			  withLaps: totalLaps - aPosition lap ].

	aPosition position <= boardSize ifTrue: [
		^ Position at: 0 withLaps: 0 ].

	^ Position
		  at: boardSize * (aPosition position // boardSize) negated
		  withLaps: aPosition position // boardSize
]

{ #category : 'as yet unclassified' }
Board >> the: aPosition hasReached: totalLaps [

	^ aPosition position + (aPosition lap * boardSize)
	  >= (totalLaps * boardSize)
]

{ #category : 'as yet unclassified' }
Board >> validateThatDeckContains: aCard [

	deckOfCards detect: [ :card | card class = aCard class]
	ifNone: [ Error signal: 'The card is not in the deck' ].
]
