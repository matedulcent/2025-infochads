Class {
	#name : 'CellSystem',
	#superclass : 'Object',
	#instVars : [
		'positionManager',
		'board',
		'game',
		'turnManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CellSystem class >> withBoard: board positionManager: aPositionManager turnManager: aTurnManager and: aGame [

	^ self new
		  initializeWithBoard: board
		  positionManager: aPositionManager
		  turnManager: aTurnManager
		  and: aGame
]

{ #category : 'as yet unclassified' }
CellSystem >> applyPowerUpTo: aSpaceShip [

	| cell position effectPrototype anEffect |
	position := positionManager at: aSpaceShip id.
	cell := board cellInThe: position.
	cell ifNil: [ ^ self ].

	effectPrototype := cell percieveAction.
	game registerLastEffectPrototype: effectPrototype.
	anEffect := effectPrototype value.
	anEffect applyOn: aSpaceShip in: self
]

{ #category : 'as yet unclassified' }
CellSystem >> deductAShieldFromEveryShip [

	turnManager allShips do: [ :ship | ship loseShield ]
]

{ #category : 'as yet unclassified' }
CellSystem >> giveACardTo: aShip [

	| aCard |
	aCard := board pickACard.
	aShip addA: aCard
]

{ #category : 'initialization' }
CellSystem >> initializeWithBoard: aBoard positionManager: aPositionManager turnManager: aTurnManager and: aGame [

	board := aBoard.
	positionManager := aPositionManager.
	game := aGame.
	turnManager := aTurnManager.
]

{ #category : 'as yet unclassified' }
CellSystem >> move: aShip by: backTrack [
	
	| actualPosition |
	actualPosition := positionManager positions at: aShip id.
	
	positionManager positions
		at: aShip id
		put: ((positionManager positions at: aShip id) replacePositionWith:
				 (Position at: (actualPosition position) + backTrack withLaps: 0))
]

{ #category : 'as yet unclassified' }
CellSystem >> moveEveryShipBut: aShip backBy: backTrack [

	| otherShips |
	otherShips := turnManager allShips reject: [ :each |
		              each id = aShip id ].

	otherShips do: [ :ship | self move: ship by: backTrack ]
]

{ #category : 'as yet unclassified' }
CellSystem >> returnEveryShipToTheBeguining [

	turnManager allShips do: [ :ship |
		self
			move: ship
			by: (positionManager positions at: ship id) position negated + 1 ]
]
