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
		'manage',
		'stepOfNextSpaceShipToMove',
		'listOfAlteredSteps'
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
Game >> affectTheShipOrder: aCard [
	"Reverse Card"
	stepOfNextSpaceShipToMove := aCard invertOrder:
		                             stepOfNextSpaceShipToMove.
	"Skip Card"
	aCard skip ifTrue: [ self updateNextShipToMove ].

	"Double Card"
	listOfAlteredSteps := aCard playTwice:
		                             listOfAlteredSteps.
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
	
	stepOfNextSpaceShipToMove := 1.
	listOfAlteredSteps := OrderedCollection new.
	nextSpaceShipToMove := 1.
	
	numberOfSpaceShips := aNumberOfSpaceShips.
	laps := aNumberOfLaps.
	
]

{ #category : 'whats left of race positions' }
Game >> isGameOver [

	^ spaceShips anySatisfy: [ :aShip |
		  (manage at: aShip id) isEqualTo:
			  (Position at: board boardSize withLaps: laps) ]
]

{ #category : 'testing' }
Game >> isLockedUpInCell: aSpaceShipID [

	self checkFor: aSpaceShipID.
	^ (spaceShips at: aSpaceShipID) isLockedUp
]

{ #category : 'informationTest' }
Game >> isOver [

	^ self isGameOver
]

{ #category : 'informationTest' }
Game >> lapOf: aSpaceShipID [

	^ (manage at: aSpaceShipID) lap
]

{ #category : 'accessing' }
Game >> modifyOrderDueToPreviousCards [

	"If the first player inverts the order then the last starts "
	stepOfNextSpaceShipToMove = -1 ifTrue: [
		nextSpaceShipToMove := numberOfSpaceShips ].
	
	"If the player to play plays double turn then it plays again, not twice more"
	(listOfAlteredSteps isNotEmpty and: [ listOfAlteredSteps first = 0 ])
		ifTrue: [ listOfAlteredSteps removeFirst ]
]

{ #category : 'as yet unclassified' }
Game >> move: aSpaceShip after: aDiceRoll [

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

	Battle
		between: aSpaceShip
		andOneOf: spaceShips
		with: manage
		on: board
		with: diceSet.
]

{ #category : 'movingOut' }
Game >> noPermanent: aCard [

	(self isGameOver and: aCard isPermanent not) ifTrue: [
		Error signal:
			'Instantaneous cards cant be played after the game is over.' ]
]

{ #category : 'as yet unclassified' }
Game >> obtainStep [

	^ listOfAlteredSteps isEmpty
		  ifFalse: [ listOfAlteredSteps removeFirst ]
		  ifTrue: [ stepOfNextSpaceShipToMove ]
]

{ #category : 'as yet unclassified' }
Game >> play: aSpaceShip ifItsNotTrappedByTossing: aDiceRoll [
	"Check for losing turn by dodging or by shields"
	(self skippingTurn: aSpaceShip after: aDiceRoll) ifTrue: [ ^ self ].
	"Retained or LockedUp"
	aSpaceShip isImprisionedByTossing: aDiceRoll on: self.
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
	self modifyOrderDueToPreviousCards.
	
	"-1 allows to stop the rigged dice"
	[ self isGameOver or: aDiceRoll = -1 ] whileFalse: [
		spaceShip := spaceShips at: nextSpaceShipToMove.
		self play: spaceShip ifItsNotTrappedByTossing: aDiceRoll.
		"self move: spaceShip after: aDiceRoll."

		self updateNextShipToMove.
		
		aDiceRoll := diceSet toss ]
]

{ #category : 'as yet unclassified' }
Game >> theNextSpaceShipToMoveIsOverTheLimit [

	nextSpaceShipToMove > numberOfSpaceShips ifTrue: [
		nextSpaceShipToMove := 1 ]
]

{ #category : 'as yet unclassified' }
Game >> theNextSpaceShipToMoveIsUnderTheLimit [

	nextSpaceShipToMove <= 0 ifTrue: [
		nextSpaceShipToMove := numberOfSpaceShips ]
]

{ #category : 'as yet unclassified' }
Game >> updateNextShipToMove [

	| sum |
	sum := self obtainStep.

	nextSpaceShipToMove := nextSpaceShipToMove + sum.
	
	self theNextSpaceShipToMoveIsOverTheLimit.
	
	self theNextSpaceShipToMoveIsUnderTheLimit
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
		modifiedBy: stepOfNextSpaceShipToMove
		and: manage positions.

	self affectTheShipOrder: aCard.

	self adjustPosition
]
