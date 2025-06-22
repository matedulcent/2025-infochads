Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'spaceShips',
		'diceSet',
		'nextSpaceShipToMove',
		'numberOfSpaceShips',
		'laps',
		'board',
		'spaceShipPositions'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> lapsMustBePositive: aNumberOfLaps [

	(aNumberOfLaps isInteger and: [ aNumberOfLaps > 0 ]) ifFalse: [
		self error: 'Laps must be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Game class >> numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips [

	aNumberOfSpaceShips <= 0 ifTrue: [
		Error signal: 'The number of space ships must be at least 1.' ]
]

{ #category : 'as yet unclassified' }
Game class >> numberOfSpaceShipsMustBePositive: aNumberOfSpaceShips [

	(aNumberOfSpaceShips isInteger not or: [
		 aNumberOfSpaceShips negative ]) ifTrue: [
		Error signal:
			'The number of space ships should be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Game class >> playedIn: aBoard by: aNumberOfSpaceShips throwing: aDiceSet wonAfter: aNumberOfLaps [

	self numberOfSpaceShipsMustBePositive: aNumberOfSpaceShips.
	self numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips.
	self lapsMustBePositive: aNumberOfLaps.

	^ self new
		  initializeWithBoardSize: aBoard
		  by: aNumberOfSpaceShips
		  thorwing: aDiceSet
		  wonAfter: aNumberOfLaps
]

{ #category : 'as yet unclassified' }
Game >> battleBetween: aSpaceShip1 and: aSpaceShip2 [

	| throwSpaceShip1 throwSpaceShip2 numberOfTosses2 numberOfTosses1 |
	numberOfTosses2 := (board activeCards at: aSpaceShip2 id) select: [
		                   :card | card isMercenary ].
	numberOfTosses1 := (board activeCards at: aSpaceShip1 id) select: [
		                   :card | card isMercenary ].

	[
	throwSpaceShip2 := 0.
	throwSpaceShip1 := 0.

	1 to: numberOfTosses2 size + 1 do: [ :mercenary |
	throwSpaceShip2 := throwSpaceShip2 + diceSet toss ].

	1 to: numberOfTosses1 size + 1 do: [ :mercenary |
	throwSpaceShip1 := throwSpaceShip1 + diceSet toss ].

	throwSpaceShip1 = throwSpaceShip2 ] whileTrue: [  ].
	throwSpaceShip1 < throwSpaceShip2
		ifTrue: [ self lostBattle: aSpaceShip1 ]
		ifFalse: [ self lostBattle: aSpaceShip2 ]
]

{ #category : 'whats left of race positions' }
Game >> create: aNumberOfSpaceShips [

	| aPosition aShield |
	aPosition := Position at: 1 withLaps: 0.
	aShield := 3.

	spaceShips := OrderedCollection new.
	spaceShipPositions := OrderedDictionary new.


	1 to: aNumberOfSpaceShips do: [ :id |
		spaceShips add: (SpaceShip
				 with: id
				 startingWith: board pickACard
				 and: board pickACard
				 with: aShield).
		spaceShipPositions at: id put: aPosition.
		board addNewActiveCardSlot: id ]
]

{ #category : 'informationTest' }
Game >> getRanking [

	| ranking |
	self isOver ifFalse: [ ^ #(  ) ].

	ranking := spaceShips sorted: [ :ship1 :ship2 |
		           (spaceShipPositions at: ship1 id) lap
		           -> (spaceShipPositions at: ship1 id) position
		           > ((spaceShipPositions at: ship2 id) lap
			            -> (spaceShipPositions at: ship2 id) position) ].

	^ (ranking collect: [ :each | each id ]) asArray
]

{ #category : 'initialization' }
Game >> initializeWithBoardSize: aBoard by: aNumberOfSpaceShips thorwing: aDiceSet wonAfter: aNumberOfLaps [

	board := aBoard.

	spaceShipPositions := OrderedDictionary new.
	"spaceShipActiveCards := OrderedDictionary new."
	self create: aNumberOfSpaceShips.

	diceSet := aDiceSet.
	nextSpaceShipToMove := 1.
	numberOfSpaceShips := aNumberOfSpaceShips.
	laps := aNumberOfLaps.
]

{ #category : 'whats left of race positions' }
Game >> isGameOver [

	^ spaceShips anySatisfy: [ :aShip |
		  (spaceShipPositions at: aShip id) isEqualTo:
			  (Position at: board boardSize withLaps: laps) ]
]

{ #category : 'informationTest' }
Game >> isOver [

	^ self isGameOver
]

{ #category : 'informationTest' }
Game >> lapOf: aSpaceShipID [

	^ (spaceShipPositions at: aSpaceShipID) lap
]

{ #category : 'as yet unclassified' }
Game >> lookForBattle: aSpaceShip [

	| opponentShip |
	((spaceShipPositions at: aSpaceShip id) isPositionEqualTo:
		 (Position at: 1 withLaps: 0)) ifTrue: [ ^ self ].

	opponentShip := self obtainOponentShip: aSpaceShip.

	(((board activeCards at: aSpaceShip id) anySatisfy: [ :card |
		  aSpaceShip id = card helper ]) or:
		 ((board activeCards at: opponentShip id) anySatisfy: [ :card |
			  aSpaceShip id = card helper ])) ifTrue: [ ^ self ].

	opponentShip == aSpaceShip ifFalse: [
		self battleBetween: aSpaceShip and: opponentShip ]
]

{ #category : 'as yet unclassified' }
Game >> lostBattle: aSpaceShip [

	| mercenaries |
	spaceShipPositions
		at: aSpaceShip id
		put: ((spaceShipPositions at: aSpaceShip id) sumTo: (Position
					  at: (spaceShipPositions at: aSpaceShip id) position negated + 1
					  withLaps: 0)).
	aSpaceShip loseShield.

	mercenaries := (board activeCards at: aSpaceShip id) collect: [
		               :card | card helper ].



	mercenaries do: [ :shipId |
		spaceShipPositions
			at: shipId
			put: ((spaceShipPositions at: shipId) sumTo: (Position
						  at: (spaceShipPositions at: shipId) position negated + 1
						  withLaps: 0)).
		(spaceShips detect: [ :ship | ship id = shipId ]) loseShield ]
]

{ #category : 'as yet unclassified' }
Game >> move: aSpaceShip after: aDiceRoll [

	(self skippingTurn: aSpaceShip after: aDiceRoll) ifTrue: [ ^ self ].

	self sumTo: aSpaceShip the: (Position at: aDiceRoll withLaps: 0).

	spaceShips do: [ :ship |
		self sumTo: ship the: (board
				 limitAdjustment: (spaceShipPositions at: ship id)
				 withTotalLaps: laps) ].

	self playPendingCardsOn: aSpaceShip.

	board
		checkForCardEffectsOver: aSpaceShip
		or: spaceShips
		dependingOn: spaceShipPositions.
	"board
		checkFor: spaceShipActiveCards
		andItsEffectsOver: aSpaceShip
		or: spaceShips
		dependingOn: spaceShipPositions."

	spaceShips do: [ :ship |
		self sumTo: ship the: (board
				 limitAdjustment: (spaceShipPositions at: ship id)
				 withTotalLaps: laps) ].
	board
		applyEffectOfPowerUpUponA: aSpaceShip
		andAll: spaceShips
		andIts: spaceShipPositions.

	spaceShips do: [ :ship |
		self sumTo: ship the: (board
				 limitAdjustment: (spaceShipPositions at: ship id)
				 withTotalLaps: laps) ].

	self
		replacePositionOf: aSpaceShip
		with:
		(board checkForWormHole: (spaceShipPositions at: aSpaceShip id)).

	self lookForBattle: aSpaceShip
]

{ #category : 'as yet unclassified' }
Game >> obtainOponentShip: aSpaceShip [

	| otherShips |
	otherShips := spaceShips reject: [ :ship | ship = aSpaceShip ].

	otherShips ifEmpty: [ ^ aSpaceShip ].

	^ otherShips
		  detect: [ :ship |
			  ((spaceShipPositions at: ship id) isPositionEqualTo:
				   (spaceShipPositions at: aSpaceShip id)) and: ship canBattle ]
		  ifNone: [ aSpaceShip ]
]

{ #category : 'as yet unclassified' }
Game >> playPendingCardsOn: aSpaceShip [

	aSpaceShip pendingCard do: [ :card |
		self use: card on: aSpaceShip id ]
]

{ #category : 'informationTest' }
Game >> positionOf: aSpaceShipID [

	^ (spaceShipPositions at: aSpaceShipID) position
]

{ #category : 'as yet unclassified' }
Game >> replacePositionOf: aSpaceShip with: aPosition [

	spaceShipPositions
		at: aSpaceShip id
		put:
		((spaceShipPositions at: aSpaceShip id) replacePositionWith:
			 aPosition)
]

{ #category : 'informationTest' }
Game >> shieldOf: aSpaceShipID [

	^ (spaceShips at: aSpaceShipID) getShield
]

{ #category : 'as yet unclassified' }
Game >> skippingTurn: aSpaceShip after: aDiceRoll [

	^ aSpaceShip skipTurns or: (aSpaceShip skipATurn: aDiceRoll)
]

{ #category : 'accessing' }
Game >> start [

	| aDiceRoll spaceShip |
	aDiceRoll := diceSet toss.
	"-1 allows to stop the rigged dice"
	[ self isGameOver or: aDiceRoll = -1 ] whileFalse: [
		spaceShip := spaceShips at: nextSpaceShipToMove.

		self move: spaceShip after: aDiceRoll.

		self updateNextShipToMove: nextSpaceShipToMove.
		aDiceRoll := diceSet toss ]
]

{ #category : 'as yet unclassified' }
Game >> sumTo: aSpaceShip the: aPosition [

	spaceShipPositions
		at: aSpaceShip id
		put: ((spaceShipPositions at: aSpaceShip id) sumTo: aPosition)
]

{ #category : 'as yet unclassified' }
Game >> updateNextShipToMove: spaceShipID [

	nextSpaceShipToMove := spaceShipID + 1.
	nextSpaceShipToMove > numberOfSpaceShips ifTrue: [
		nextSpaceShipToMove := 1 ]
]

{ #category : 'movingOut' }
Game >> use: aCard on: aSpaceShipID [

	| aShip |
	aShip := spaceShips
		         detect: [ :ship | ship id = aSpaceShipID ]
		         ifNone: [ Error signal: 'The ship doesnt exist' ].

	(self isGameOver and: aCard type = 'Instantaneous') ifTrue: [
		Error signal:
			'Instantaneous cards cant be played after the game is over.' ].

	board
		play: aCard
		on: aShip
		thatIsIn: spaceShips
		with: nextSpaceShipToMove
		and: spaceShipPositions.
		
	spaceShips do: [ :ship |
		self sumTo: ship the: (board
				 limitAdjustment: (spaceShipPositions at: ship id)
				 withTotalLaps: laps) ]

]
