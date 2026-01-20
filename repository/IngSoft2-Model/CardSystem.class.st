Class {
	#name : 'CardSystem',
	#superclass : 'Object',
	#instVars : [
		'turnManager',
		'positionManager',
		'activeCardHolder',
		'relationships',
		'lastActionPrototype',
		'gameRules'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardSystem class >> withTurnManager: aTurnManager positionManager: aPositionManager activeCardHolder: anActiveCardHolder andRelationships: theRelationshipsWithMercenaries withIn: gameRules [

	^ self new
		  initializeWithTurnManager: aTurnManager
		  positionManager: aPositionManager
		  activeCardHolder: anActiveCardHolder
		  andRelationships: theRelationshipsWithMercenaries
		  withIn: gameRules
]

{ #category : 'adding' }
CardSystem >> addActive: aCard to: aShipId [

	activeCardHolder addActive: aCard to: aShipId
]

{ #category : 'as yet unclassified' }
CardSystem >> applyAction: anAction [

	lastActionPrototype := anAction prototype.
	anAction apply
]

{ #category : 'asserting' }
CardSystem >> assertItsTurnToPlayOf: aShip [

	aShip = turnManager keepCurrentShip ifFalse: [
		Error signal: 'Its not the ships turn to play' ]
]

{ #category : 'as yet unclassified' }
CardSystem >> cancel: targetCard on: targetShip [
	
	| aCard aShip |
	aCard := activeCardHolder removeActive: targetCard from: targetShip.
	aShip := turnManager obtainShipById: targetShip.
	aCard unplayOn: aShip in: self
]

{ #category : 'as yet unclassified' }
CardSystem >> decrementAllBoosters [

	(turnManager allShips) do: [ :ship | ship decrementBooster ]
]

{ #category : 'as yet unclassified' }
CardSystem >> doubleTurnOn: aShip [

	turnManager doubleTurnOn: aShip
]

{ #category : 'as yet unclassified' }
CardSystem >> incrementAllBoosters [

	turnManager allShips do: [ :ship | ship incrementBooster ]
]

{ #category : 'initialization' }
CardSystem >> initializeWithTurnManager: aTurnManager positionManager: aPositionManager activeCardHolder: anActiveCardHolder andRelationships: theRelationshipsWithMercenaries withIn: someGameRules [

	turnManager := aTurnManager.
	positionManager := aPositionManager.
	activeCardHolder := anActiveCardHolder.
	relationships := theRelationshipsWithMercenaries.
	gameRules := someGameRules.
]

{ #category : 'movingOut' }
CardSystem >> use: aCard on: aShipId [
	"cardSystem use: aCard on: aShipId"

	| ship |
	ship := turnManager obtainShipById: aShipId.

	ship assertItHas: aCard.
	aCard playOn: ship in: self.
]
