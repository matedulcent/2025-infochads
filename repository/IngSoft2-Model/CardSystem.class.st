Class {
	#name : 'CardSystem',
	#superclass : 'Object',
	#instVars : [
		'turnManager',
		'positionManager',
		'activeCardHolder',
		'relationships',
		'gameRules',
		'game',
		'cellSystem'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardSystem class >> withTurnManager: aTurnManager positionManager: aPositionManager activeCardHolder: anActiveCardHolder withAdditional: aCellSystem and: aGame [

	^ self new
		  initializeWithTurnManager: aTurnManager
		  positionManager: aPositionManager
		  activeCardHolder: anActiveCardHolder
		  withAdditional: aCellSystem
		  and: aGame
]

{ #category : 'adding' }
CardSystem >> addActive: aCard to: aShipId [

	activeCardHolder addActive: aCard to: aShipId
]

{ #category : 'asserting' }
CardSystem >> assertItsTurnToPlayOf: aShip [
	
	aShip = turnManager keepCurrentShip ifFalse: [
		Error signal: 'Its not the ships turn to play' ]
]

{ #category : 'asserting' }
CardSystem >> assertMercenaryIsNotHelpingAnotherShip: aMercenaryId [

	(relationships values anySatisfy: [ :mercenaries |
		 mercenaries includes: aMercenaryId ]) ifTrue: [
		Error signal: 'A mercenary cant help multiple ships.' ]
]

{ #category : 'asserting' }
CardSystem >> assertTheGameIsNotOver [

	^ game assertTheGameIsNotOver
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
CardSystem >> initializeWithTurnManager: aTurnManager positionManager: aPositionManager activeCardHolder: anActiveCardHolder withAdditional: aCellSystem and: aGame [

	turnManager := aTurnManager.
	positionManager := aPositionManager.
	activeCardHolder := anActiveCardHolder.
	relationships := aGame obtainRelationsWithMercenaries.
	cellSystem := aCellSystem.
	game := aGame
]

{ #category : 'as yet unclassified' }
CardSystem >> redoLastActionOn: aShip withAdditional: aHelperId [

	| lastActionPrototype |
	lastActionPrototype := game obtainLastCardActionPrototype.
	lastActionPrototype ifNil: [ ^ self ].
	self registerLastCardAction:
		(lastActionPrototype value: aShip value: self value: aHelperId).
	activeCardHolder addLastPermanentCardTo: aShip.
]

{ #category : 'as yet unclassified' }
CardSystem >> registerLastCardAction: anAction [

	game registerLastCardAction: anAction.
	anAction apply
]

{ #category : 'as yet unclassified' }
CardSystem >> repeatLastCellEffectOn: aShipId [

	| ship anEffect lastEffectPrototype |
	lastEffectPrototype := game obtainLastCellEffectPrototype.
	lastEffectPrototype ifNil: [ ^ self ].

	ship := turnManager obtainShipById: aShipId.

	anEffect := lastEffectPrototype value.

	anEffect applyOn: ship in: cellSystem
]

{ #category : 'as yet unclassified' }
CardSystem >> reverseTurns [

	turnManager reverseTheTurns
]

{ #category : 'as yet unclassified' }
CardSystem >> stablish: helper on: aShip [

	(relationships at: aShip id) add: helper
]

{ #category : 'as yet unclassified' }
CardSystem >> unStablish: helper on: aShip [

	relationships valuesDo: [ :helpers |
		helpers remove: helper ifAbsent: [  ] ]
]

{ #category : 'movingOut' }
CardSystem >> use: aCard on: aShipId [

	| ship |
	ship := turnManager obtainShipById: aShipId.

	ship assertAndRemoveIfItHas: aCard.
	aCard playOn: ship in: self
]
