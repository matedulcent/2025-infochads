Class {
	#name : 'CardSystem',
	#superclass : 'Object',
	#instVars : [
		'turnManager',
		'positionManager',
		'activeCardHolder',
		'relationships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardSystem class >> withTurnManager: aTurnManager positionManager: aPositionManager activeCardHolder: anActiveCardHolder andRelationships: theRelationshipsWithMercenaries [

	^ self new
		  initializeWithTurnManager: aTurnManager
		  positionManager: aPositionManager
		  activeCardHolder: anActiveCardHolder
		  andRelationships: theRelationshipsWithMercenaries
]

{ #category : 'initialization' }
CardSystem >> initializeWithTurnManager: aTurnManager positionManager: aPositionManager activeCardHolder: anActiveCardHolder andRelationships: theRelationshipsWithMercenaries [

	turnManager := aTurnManager.
	positionManager := aPositionManager.
	activeCardHolder := anActiveCardHolder.
	relationships := theRelationshipsWithMercenaries
]
