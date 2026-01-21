Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'spaceShips',
		'diceSet',
		'numberOfSpaceShips',
		'laps',
		'board',
		'manage',
		'stepOfNextSpaceShipToMove',
		'listOfAlteredSteps',
		'diceRoll',
		'activeCardHolder',
		'relationshipsWithMercenaries',
		'lastActionPrototype',
		'lastEffectPrototype',
		'turnManager',
		'cardSystem',
		'cellSystem'
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
	"stay ?"
	spaceShips do: [ :ship |
		manage sumAt: ship id with: (board
				 limitAdjustment: (manage positions at: ship id)
				 withTotalLaps: laps) ]
]

{ #category : 'as yet unclassified' }
Game >> applyAction: anAction [

	lastActionPrototype := anAction prototype
]

{ #category : 'as yet unclassified' }
Game >> applyEffect: anEffect [

	lastEffectPrototype := anEffect 
]

{ #category : 'as yet unclassified' }
Game >> applyPowerUpTo: aSpaceShip [
	"ver si puedo mover"
	cellSystem applyPowerUpTo: aSpaceShip
]

{ #category : 'asserting' }
Game >> assertTheGameIsNotOver [

	^ turnManager allShips anySatisfy: [ :aShip |
		  (manage at: aShip id) isEqualTo:
			  (Position at: board boardSize withLaps: laps) ]
]

{ #category : 'initialization' }
Game >> createRelationsWithMercenaries [

	relationshipsWithMercenaries := OrderedDictionary new.
	spaceShips do: [ :ship |
		relationshipsWithMercenaries at: ship id put: OrderedCollection new ]
]

{ #category : 'whats left of race positions' }
Game >> createSpaceShips [

	| shield |
	shield := 3.
	spaceShips := OrderedCollection new.
	1 to: numberOfSpaceShips do: [ :id |
		spaceShips add: (SpaceShip
				 with: id
				 startingWith: board pickACard
				 and: board pickACard
				 with: shield) ]
]

{ #category : 'informationTest' }
Game >> getRanking [
	"stay"
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
	numberOfSpaceShips := aNumberOfSpaceShips.
	self createSpaceShips.
	manage := PositionManager of: spaceShips.
	diceSet := aDiceSet.
	laps := aNumberOfLaps.
	turnManager := TurnManager withThe: spaceShips.
	activeCardHolder := ActiveCardHolder withPlayers: spaceShips.
	self createRelationsWithMercenaries.

	cellSystem := CellSystem
		              withBoard: board
		              positionManager: manage
		              turnManager: turnManager
		              and: self.

	cardSystem := CardSystem
		              withTurnManager: turnManager
		              positionManager: manage
		              activeCardHolder: activeCardHolder
		              andRelationships: relationshipsWithMercenaries
		              withAdditional: cellSystem
		              and: self
]

{ #category : 'testing' }
Game >> isLockedUpInCell: aSpaceShipID [

	turnManager obtainShipById: aSpaceShipID.
	^ (spaceShips at: aSpaceShipID) isLockedUp
]

{ #category : 'informationTest' }
Game >> isOver [
	"testing" "stay"
	^ self assertTheGameIsNotOver
]

{ #category : 'informationTest' }
Game >> lapOf: aSpaceShipID [
	"testing"
	^ (manage at: aSpaceShipID) lap
]

{ #category : 'as yet unclassified' }
Game >> move: aSpaceShip after: aDiceRoll [
	"stay"

	manage
		sumAt: aSpaceShip id
		with: (Position at: aDiceRoll withLaps: 0).
	self adjustPosition.


	self applyPowerUpTo: aSpaceShip.


	manage
		at: aSpaceShip id
		replacePositionWith:
		(board checkForWormHole: (manage positions at: aSpaceShip id)).
	self adjustPosition.
	Battle
		between: aSpaceShip
		andOneOf: spaceShips
		with: manage
		on: board
		with: diceSet
		andIts: relationshipsWithMercenaries.
	diceRoll := diceSet toss
]

{ #category : 'as yet unclassified' }
Game >> obtainLastCardActionPrototype [

	^ lastActionPrototype 
]

{ #category : 'as yet unclassified' }
Game >> obtainLastCellEffectPrototype [

	^ lastEffectPrototype 
]

{ #category : 'informationTest' }
Game >> positionOf: aSpaceShipID [

	^ (manage positions at: aSpaceShipID) position
]

{ #category : 'as yet unclassified' }
Game >> rollTheDice [
	"stay"
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

{ #category : 'accessing' }
Game >> start [
	"stay"
	| aSpaceShip |
	diceRoll := diceSet toss.
	[ self assertTheGameIsNotOver or: diceRoll =  -1 ] whileFalse: [
		aSpaceShip := turnManager grabAndUpdate.
		aSpaceShip willPlayByTossing: diceRoll on: self ]
]

{ #category : 'movingOut' }
Game >> use: aCard on: aShipId [

	cardSystem use: aCard on: aShipId.
	self adjustPosition
]
