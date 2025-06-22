Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'wormHole',
		'gameBoard',
		'lastCellPlayed',
		'cardManager',
		'lastCardPlayed',
		'spaceShipActiveCards'
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

{ #category : 'accessing' }
Board >> activeCards [

	^ cardManager activeCards
]

{ #category : 'adding' }
Board >> addNewActiveCardSlot: spaceShipID [

	cardManager addNew: spaceShipID
]

{ #category : 'as yet unclassified' }
Board >> applyEffectOfPowerUpUponA: aSpaceShip andAll: spaceShips andIts: spaceShipPositions [

	| cell |
	gameBoard ifEmpty: [ ^ self ].
	cell := gameBoard at: (spaceShipPositions at: aSpaceShip id) position.

	lastCellPlayed := cell.

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
Board >> checkForCardEffectsOver: aSpaceShip
		or: spaceShips
		dependingOn: spaceShipPositions [

	| mercenary |
	(cardManager activeCards at: aSpaceShip id) do: [ :card |
		spaceShipPositions
			at: aSpaceShip id
			put: ((spaceShipPositions at: aSpaceShip id) sumTo: card effect) ].


	cardManager activeCards associationsDo: [ :shipCards |
		shipCards value do: [ :card |
			spaceShipPositions
				at: aSpaceShip id
				put:
				((spaceShipPositions at: aSpaceShip id) sumTo: card effectAll) ] ].

	(cardManager activeCards at: aSpaceShip id) do: [ :card |
		(card activateMercenaryOn) ifTrue: [
			mercenary := spaceShips detect: [ :ship | ship id = card helper ].
			
			mercenary isHelpingOthers ifTrue: [
				Error signal: 'A mercenary cant help multiple ships.' ] ] ]
]

{ #category : 'as yet unclassified' }
Board >> checkForWormHole: aPosition [

	^ Position at: (wormHole moveifWormHole: aPosition position) withLaps: 0.
]

{ #category : 'as yet unclassified' }
Board >> does: mercenaryId appearsInOther: spaceShipCards [

	spaceShipCards associationsDo: [ :shipCard |
		((shipCard value collect: [ :card | card helper = mercenaryId ]) size > 1)
			ifTrue: [ ^ true ] ].

	^ false
]

{ #category : 'initialization' }
Board >> initializeWithSize: aBoardSize composedOf: aWormHole playedWith: aDeckOfCards andConfiguration: aConfigDiceSet [

	boardSize := aBoardSize.
	cardManager := CardManager createWith: aDeckOfCards.
	"spaceShipActiveCards := OrderedDictionary new."
	gameBoard := CellPlacement new
		             createBoardWith: aConfigDiceSet
		             withComplementary: cardManager
		             And: boardSize.

	wormHole := aWormHole.
	wormHole mustBeWithInLimits: aBoardSize.
	lastCardPlayed := WhiteCard new.
	lastCellPlayed := Cell has: NoEffect new
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
Board >> manageCards [

	^ cardManager
]

{ #category : 'as yet unclassified' }
Board >> pickACard [
	
	^ cardManager grabTopCard
]

{ #category : 'as yet unclassified' }
Board >> play: aCard on: aShip thatIsIn: spaceShips with: nextSpaceShipToMove and: spaceShipPositions [

	self playRedo: aCard on: aShip.
	(aShip id ~= nextSpaceShipToMove and: aCard type = 'Permanent')
		ifTrue: [
			aShip pending: aCard.
			^ self ].

	aCard type = 'Permanent' ifTrue: [
		lastCardPlayed := aShip has: aCard.
		(cardManager activeCards at: aShip id) add: lastCardPlayed.
		^ self ].

	"self isGameOver ifTrue: [
		Error signal:
			'Instantaneous cards cant be played after the game is over.' ]."

	self playCancelation: aCard of: aShip.

	self playRepeat: aCard on: aShip and: spaceShips dependingOn: spaceShipPositions.

	lastCardPlayed := aShip has: aCard
]

{ #category : 'as yet unclassified' }
Board >> playCancelation: aCard of: aShip [

	| card |
	(aCard objective: aShip id) = '' ifTrue: [ ^ self ].
	card := (cardManager activeCards at: (aCard objective: aShip id))
		        detect: [ :cardOfShip |
		        cardOfShip class = (aCard cardObjective: aCard) class ]
		        ifNone: [
			        Error signal:
				        'This card cant be played if the card to be canceled is not active.' ].
	(cardManager activeCards at: (aCard objective: aShip id)) remove: card.
	aShip deMercenarize
]

{ #category : 'as yet unclassified' }
Board >> playRedo: aCard on: aShip [

	lastCardPlayed isRedo ifFalse: [
		aCard mimic: lastCardPlayed deepCopy.
		^ self ].

	aCard isRedo ifTrue: [ aCard mimic: lastCardPlayed mimic deepCopy ]
]

{ #category : 'as yet unclassified' }
Board >> playRepeat: aCard on: aShip and: spaceShips dependingOn: spaceShipPositions [

	| cell objectiveShip |
	
	aCard lastPowerUpPlayed: lastCellPlayed .
	((aCard target: aShip id) = '') ifTrue: [ ^self ].
	cell := aCard replicateCell.
	objectiveShip := spaceShips detect: [ :ship |
		                 ship id = (aCard target: aShip id) ].
	cell
		takeActionOver: objectiveShip
		or: spaceShips
		thatArePlaced: spaceShipPositions.

]

{ #category : 'as yet unclassified' }
Board >> the: aPosition hasReached: totalLaps [

	^ aPosition position + (aPosition lap * boardSize)
	  >= (totalLaps * boardSize)
]
