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
Board >> applyPowerUpEffectUponA: aSpaceShip andAll: spaceShips andIts: spaceShipPositions [

	| cell |
	gameBoard ifEmpty: [ ^ self ].
	cell := gameBoard at: (spaceShipPositions at: aSpaceShip id) position.

	cell
		takeActionOver: aSpaceShip
		or: spaceShips
		thatArePlaced: spaceShipPositions
]

{ #category : 'accessing' }
Board >> boardSize [

	^ boardSize
]

{ #category : 'as yet unclassified' }
Board >> cellInThe: position [

	| cell |
	gameBoard ifEmpty: [ ^ nil ].
	cell := gameBoard at: (position position).
	^ cell
]

{ #category : 'as yet unclassified' }
Board >> checkForWormHole: aPosition [

	^ Position at: (wormHole moveifWormHole: aPosition position) withLaps: 0.
]

{ #category : 'initialization' }
Board >> initializeWithSize: aBoardSize composedOf: aWormHole playedWith: aDeckOfCards andConfiguration: aConfigDiceSet [

	boardSize := aBoardSize.
	deckOfCards := aDeckOfCards.

	gameBoard := CellPlacement new
		             createBoardWith: aConfigDiceSet
		             withComplementary: boardSize.

	wormHole := aWormHole.
	wormHole mustBeWithInLimits: aBoardSize
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
Board >> pickACard [

	^ deckOfCards grabCard
]

{ #category : 'as yet unclassified' }
Board >> the: aPosition hasReached: totalLaps [

	^ aPosition position + (aPosition lap * boardSize)
	  >= (totalLaps * boardSize)
]
