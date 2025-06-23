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
		'manage'
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
Game >> adjustPosition [

	spaceShips do: [ :ship |
		manage sumAt: ship id with: (board
				 limitAdjustment: (manage positions at: ship id)
				 withTotalLaps: laps) ]
]

{ #category : 'as yet unclassified' }
Game >> battleBetween: aSpaceShip1 and: aSpaceShip2 [

	| throwSpaceShip1 throwSpaceShip2 |
	[
	throwSpaceShip2 := self mercenaryHelpTo: aSpaceShip2.
	throwSpaceShip1 := self mercenaryHelpTo: aSpaceShip1.

	throwSpaceShip1 = throwSpaceShip2 ] whileTrue: [  ].
	throwSpaceShip1 < throwSpaceShip2
		ifTrue: [ self lostBattle: aSpaceShip1 ]
		ifFalse: [ self lostBattle: aSpaceShip2 ]
]

{ #category : 'movingOut' }
Game >> checkFor: aSpaceShipID [

	| aShip |
	aShip := spaceShips
		         detect: [ :ship | ship id = aSpaceShipID ]
		         ifNone: [ Error signal: 'The ship doesnt exist' ].
	^ aShip
]

{ #category : 'whats left of race positions' }
Game >> create: aNumberOfSpaceShips [

	| aShield |
	aShield := 3.
	spaceShips := OrderedCollection new.

	1 to: aNumberOfSpaceShips do: [ :id |
		spaceShips add: (SpaceShip
				 with: id
				 startingWith: board pickACard
				 and: board pickACard
				 with: aShield).
		board manageCards addNew: id ]
]

{ #category : 'informationTest' }
Game >> getRanking [

	| ranking |
	self isOver ifFalse: [ ^ #(  ) ].

	ranking := spaceShips sorted: [ :ship1 :ship2 |
		           (manage at: ship1 id) lap
		           -> (manage at: ship1 id) position
		           >
		           ((manage at: ship2 id) lap
		            -> (manage at: ship2 id) position) ].

	^ (ranking collect: [ :each | each id ]) asArray
]

{ #category : 'initialization' }
Game >> initializeWithBoardSize: aBoard by: aNumberOfSpaceShips thorwing: aDiceSet wonAfter: aNumberOfLaps [

	board := aBoard.

	self create: aNumberOfSpaceShips.
	manage := PositionManager of: spaceShips.

	diceSet := aDiceSet.
	nextSpaceShipToMove := 1.
	numberOfSpaceShips := aNumberOfSpaceShips.
	laps := aNumberOfLaps
]

{ #category : 'whats left of race positions' }
Game >> isGameOver [

	^ spaceShips anySatisfy: [ :aShip |
		  (manage at: aShip id) isEqualTo:
			  (Position at: board boardSize withLaps: laps) ]
]

{ #category : 'informationTest' }
Game >> isOver [

	^ self isGameOver
]

{ #category : 'informationTest' }
Game >> lapOf: aSpaceShipID [

	^ (manage at: aSpaceShipID) lap
]

{ #category : 'as yet unclassified' }
Game >> lookForBattle: aSpaceShip [

	| opponentShip |
	((manage at: aSpaceShip id) isPositionEqualTo:
		 (Position at: 1 withLaps: 0)) ifTrue: [ ^ self ].

	opponentShip := self obtainOponentShip: aSpaceShip.

	(board manageCards the: opponentShip isMercenaryOf: aSpaceShip)
		ifTrue: [ ^ self ].

	opponentShip == aSpaceShip ifFalse: [
		self battleBetween: aSpaceShip and: opponentShip ]
]

{ #category : 'as yet unclassified' }
Game >> lostBattle: aSpaceShip [

	| mercenaries |

	manage sumAt: aSpaceShip id with:(Position
					  at: (manage positions at: aSpaceShip id) position negated + 1
					  withLaps: 0).
	aSpaceShip loseShield.

	mercenaries := board manageCards listOfMercenariesOf: aSpaceShip .

	mercenaries do: [ :shipId |
		manage sumAt: shipId with:(Position
					  at: (manage positions at: shipId) position negated + 1
					  withLaps: 0).
		(spaceShips detect: [ :ship | ship id = shipId ]) loseShield ]
]

{ #category : 'as yet unclassified' }
Game >> mercenaryHelpTo: aSpaceShip [

	| numberOfTosses throwSpaceShip |
	numberOfTosses := board manageCards numberOfMercenariesOf: aSpaceShip.

	throwSpaceShip := 0.
	1 to: numberOfTosses do: [ :mercenary |
	throwSpaceShip := throwSpaceShip + diceSet toss ].

	^ throwSpaceShip
]

{ #category : 'as yet unclassified' }
Game >> move: aSpaceShip after: aDiceRoll [

	(self skippingTurn: aSpaceShip after: aDiceRoll) ifTrue: [ ^ self ].

	manage
		sumAt: aSpaceShip id
		with: (Position at: aDiceRoll withLaps: 0).
	self adjustPosition.

	self playPendingCardsOn: aSpaceShip.

	board manageCards
		applyCardEffectsOver: aSpaceShip
		or: spaceShips
		dependingOn: manage.
	self adjustPosition.

	board
		applyPowerUpEffectUponA: aSpaceShip
		andAll: spaceShips
		andIts: manage positions.
	self adjustPosition.

	manage
		at: aSpaceShip id
		replacePositionWith:
		(board checkForWormHole: (manage positions at: aSpaceShip id)).

	self lookForBattle: aSpaceShip
]

{ #category : 'movingOut' }
Game >> noPermanent: aCard [

	(self isGameOver and: aCard isPermanent not) ifTrue: [
		Error signal:
			'Instantaneous cards cant be played after the game is over.' ]
]

{ #category : 'as yet unclassified' }
Game >> obtainOponentShip: aSpaceShip [

	| otherShips |
	otherShips := spaceShips reject: [ :ship | ship = aSpaceShip ].

	otherShips ifEmpty: [ ^ aSpaceShip ].

	^ otherShips
		  detect: [ :ship |
			  ((manage positions at: ship id) isPositionEqualTo:
				   (manage positions at: aSpaceShip id)) and: ship canBattle ]
		  ifNone: [ aSpaceShip ]
]

{ #category : 'as yet unclassified' }
Game >> playPendingCardsOn: aSpaceShip [

	aSpaceShip pendingCard do: [ :card |
		self use: card on: aSpaceShip id ]
]

{ #category : 'informationTest' }
Game >> positionOf: aSpaceShipID [

	^ (manage positions at: aSpaceShipID) position
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
Game >> updateNextShipToMove: spaceShipID [

	nextSpaceShipToMove := spaceShipID + 1.
	nextSpaceShipToMove > numberOfSpaceShips ifTrue: [
		nextSpaceShipToMove := 1 ]
]

{ #category : 'movingOut' }
Game >> use: aCard on: aSpaceShipID [

	| aShip |
	aShip := self checkFor: aSpaceShipID.
		
	self noPermanent: aCard.

	board manageCards
		play: aCard
		on: aShip
		thatIsIn: spaceShips
		with: nextSpaceShipToMove
		and: manage positions.

	self adjustPosition
]
