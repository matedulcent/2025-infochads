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
		'listOfAlteredSteps',
		'diceRoll',
		'nextSpaceShip',
		'activeCardHolder',
		'relationshipsWithMercenaries',
		'lastActionPrototype'
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

{ #category : 'adding' }
Game >> addActive: arg1 to: arg2 [
	"??? borar?"
	activeCardHolder addActive: arg1 to: arg2
]

{ #category : 'as yet unclassified' }
Game >> adjustPosition [

	spaceShips do: [ :ship |
		manage sumAt: ship id with: (board
				 limitAdjustment: (manage positions at: ship id)
				 withTotalLaps: laps) ]
]

{ #category : 'as yet unclassified' }
Game >> applyAction: anAction [

	lastActionPrototype := anAction prototype.
	anAction apply
]

{ #category : 'as yet unclassified' }
Game >> assertMercenaryIsNotHelpingAnotherShip: aMercenaryId [

	(relationshipsWithMercenaries values anySatisfy: [ :mercenaries |
		 mercenaries includes: aMercenaryId ]) ifTrue: [
		Error signal: 'A mercenary cant help multiple ships.' ]
]

{ #category : 'movingOut' }
Game >> checkFor: aSpaceShipID [
	"refactor para que use Turn Manager Quiza"
	| aShip |
	aShip := spaceShips
		         detect: [ :ship | ship id = aSpaceShipID ]
		         ifNone: [ Error signal: 'The ship doesnt exist' ].
	^ aShip
]

{ #category : 'whats left of race positions' }
Game >> create: arg1 [

	| tmp1 |
	tmp1 := 3.
	spaceShips := OrderedCollection new.
	1 to: arg1 do: [ :tmp2 |
		spaceShips add: (SpaceShip
				 with: tmp2
				 startingWith: board pickACard
				 and: board pickACard
				 with: tmp1) ].
	1
]

{ #category : 'as yet unclassified' }
Game >> doubleTurnOn: aShip [

	nextSpaceShip doubleTurnOn: aShip
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

{ #category : 'as yet unclassified' }
Game >> incrementAllBoosters [

	spaceShips do: [ :ship | ship incrementBooster ]
]

{ #category : 'initialization' }
Game >> initializeWithBoardSize: aBoard by: aNumberOfSpaceShips thorwing: aDiceSet wonAfter: aNumberOfLaps [

	board := aBoard.

	self create: aNumberOfSpaceShips.
	manage := PositionManager of: spaceShips.

	diceSet := aDiceSet.


	numberOfSpaceShips := aNumberOfSpaceShips.
	laps := aNumberOfLaps.

	nextSpaceShip := TurnManager withThe: spaceShips.

	activeCardHolder := CardHolderGlobal withPlayers: spaceShips.

	relationshipsWithMercenaries := OrderedDictionary new.
	spaceShips do: [ :ship |
		relationshipsWithMercenaries at: ship id put: OrderedCollection new ]
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
	"testing"
	^ self isGameOver
]

{ #category : 'informationTest' }
Game >> lapOf: aSpaceShipID [
	"testing"
	^ (manage at: aSpaceShipID) lap
]

{ #category : 'as yet unclassified' }
Game >> move: aSpaceShip after: aDiceRoll [

	manage
		sumAt: aSpaceShip id
		with: (Position at: aDiceRoll withLaps: 0).
	self adjustPosition.

	self playPendingCardsOn: aSpaceShip.

	"board manageCards
		applyCardEffectsOver: aSpaceShip
		or: spaceShips
		dependingOn: manage.
	self adjustPosition."

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
		with: diceSet
		andIts: relationshipsWithMercenaries.
	diceRoll := diceSet toss.
]

{ #category : 'movingOut' }
Game >> noPermanent: aCard [
	"refactorizar y borrar"
	(self isGameOver and: aCard isPermanent not) ifTrue: [
		Error signal:
			'Instantaneous cards cant be played after the game is over.' ]
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

{ #category : 'as yet unclassified' }
Game >> redoLastActionOn: aShip [

	lastActionPrototype ifNil: [ ^ self ].

	self applyAction: (lastActionPrototype value: aShip value: self)
]

{ #category : 'as yet unclassified' }
Game >> reverseTurns [

	nextSpaceShip reverseTheTurns
]

{ #category : 'as yet unclassified' }
Game >> rollTheDice [

	diceRoll := diceSet toss.
]

{ #category : 'informationTest' }
Game >> shieldOf: aSpaceShipID [
	"for testing"

	^ spaceShips
		  detect: [ :ship | ship id = aSpaceShipID ]
		  ifFound: [ :ship | ship getShield ]
		  ifNone: [ nil ]
]

{ #category : 'as yet unclassified' }
Game >> stablish: helper on: aShip [
	
	(relationshipsWithMercenaries at: aShip id) add: helper
]

{ #category : 'accessing' }
Game >> start [

	| aSpaceShip |
	diceRoll := diceSet toss.
	[ self isGameOver or: diceRoll =  -1 ] whileFalse: [
		aSpaceShip := nextSpaceShip grabAndUpdate.
		aSpaceShip willPlayByTossing: diceRoll on: self ]
]

{ #category : 'movingOut' }
Game >> use: aCard on: aShipId [

	| ship |
	ship := self checkFor: aShipId.
	self noPermanent: aCard.
	board manageCards
		play: aCard
		on: ship
		thatIsIn: spaceShips
		with: nextSpaceShip grab
		modifiedBy: stepOfNextSpaceShipToMove
		and: manage positions.
	aCard playOn: ship in: self.
	self adjustPosition
]
