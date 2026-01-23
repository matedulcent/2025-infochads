Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'spaceShips',
		'diceSet',
		'laps',
		'board',
		'stepOfNextSpaceShipToMove',
		'listOfAlteredSteps',
		'diceRoll',
		'activeCardHolder',
		'relationshipsWithMercenaries',
		'lastActionPrototype',
		'lastEffectPrototype',
		'turnManager',
		'cardSystem',
		'cellSystem',
		'positionManager'
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

	"turnManager allShips do: [ :ship |
		positionManager sumAt: ship id with: (board
				 limitAdjustment: (positionManager positions at: ship id)
				 withTotalLaps: laps) ]"
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
		  (positionManager at: aShip id) isEqualTo:
			  (Position at: board boardSize withLaps: laps) ]
]

{ #category : 'initialization' }
Game >> createRelationsWithMercenaries [

	relationshipsWithMercenaries := OrderedDictionary new.
	spaceShips do: [ :ship |
		relationshipsWithMercenaries at: ship id put: OrderedCollection new ]
]

{ #category : 'whats left of race positions' }
Game >> createSpaceShipsWith: aNumberOfSpaceShips [

	| shield |
	shield := 3.
	spaceShips := OrderedCollection new.
	1 to: aNumberOfSpaceShips do: [ :id |
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
		           (positionManager at: ship1 id) lap
		           -> (positionManager at: ship1 id) position
		           >
		           ((positionManager at: ship2 id) lap
		            -> (positionManager at: ship2 id) position) ].

	^ (ranking collect: [ :each | each id ]) asArray
]

{ #category : 'initialization' }
Game >> initializeWithBoardSize: aBoard by: aNumberOfSpaceShips thorwing: aDiceSet wonAfter: aNumberOfLaps [

	board := aBoard.
	diceSet := aDiceSet.
	laps := aNumberOfLaps.
	
	self createSpaceShipsWith: aNumberOfSpaceShips.
	positionManager := PositionManager of: spaceShips.
	
	turnManager := TurnManager withThe: spaceShips.
	activeCardHolder := ActiveCardHolder withPlayers: spaceShips.
	self createRelationsWithMercenaries.

	cellSystem := CellSystem
		              withBoard: board
		              positionManager: positionManager
		              turnManager: turnManager
		              and: self.

	cardSystem := CardSystem
		              withTurnManager: turnManager
		              positionManager: positionManager
		              activeCardHolder: activeCardHolder
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
	^ (positionManager at: aSpaceShipID) lap
]

{ #category : 'as yet unclassified' }
Game >> move: aSpaceShip after: aDiceRoll [

	positionManager
		move: aSpaceShip id
		by: aDiceRoll
		on: board
		totalLaps: laps.

	self applyPowerUpTo: aSpaceShip.
	
	positionManager
		applyBoardEffectsOn: aSpaceShip id
		using: board
		totalLaps: laps.


	Battle
		in: self
		and: turnManager
		with: positionManager
		on: board
		with: diceSet.
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

{ #category : 'as yet unclassified' }
Game >> obtainRelationsWithMercenaries [

	^ relationshipsWithMercenaries
]

{ #category : 'informationTest' }
Game >> positionOf: aSpaceShipID [

	^ (positionManager positions at: aSpaceShipID) position
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
