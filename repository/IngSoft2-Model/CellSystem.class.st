Class {
	#name : 'CellSystem',
	#superclass : 'Object',
	#instVars : [
		'positionManager',
		'board',
		'game'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CellSystem class >> withBoard: board positionManager: aPositionManager and: aGame [

	^ self new
		  initializeWithBoard: board
		  positionManager: aPositionManager
		  and: aGame
]

{ #category : 'as yet unclassified' }
CellSystem >> applyPowerUpTo: aSpaceShip [

	| cell position effectPrototype anEffect |
	position := positionManager at: aSpaceShip id.
	cell := board cellInThe: position.
	cell ifNil: [ ^ self ].

	effectPrototype := cell percieveAction.
	game applyEffect: effectPrototype. "En game"
	anEffect := effectPrototype value: aSpaceShip value: self.
	anEffect applyOn: aSpaceShip in: self
]

{ #category : 'initialization' }
CellSystem >> initializeWithBoard: aBoard positionManager: aPositionManager and: aGame [

	board := aBoard.
	positionManager := aPositionManager.
	game := aGame
]
