Class {
	#name : 'GameRules',
	#superclass : 'Object',
	#instVars : [
		'board',
		'manage',
		'turnManager',
		'laps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
GameRules class >> withBoard: board positionManager: manage ships: turnManager laps: aNumberOfLaps [

	^ self new
	initializeWithBoard: board
	positionManager: manage
	ships: turnManager
	laps: aNumberOfLaps
]

{ #category : 'asserting' }
GameRules >> assertTheGameIsNotOver [

	"^ turnManager allShips anySatisfy: [ :aShip |
		  (manage at: aShip id) isEqualTo:
			  (Position at: board boardSize withLaps: laps) ]"
]

{ #category : 'initialization' }
GameRules >> initializeWithBoard: aBoard positionManager: aPositionManager ships: aTurnManager laps: aNumberOfLaps [

	board := aBoard.
	manage := aPositionManager.
	turnManager := aTurnManager.
	laps := aNumberOfLaps
]
