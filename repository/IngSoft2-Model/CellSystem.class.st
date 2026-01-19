Class {
	#name : 'CellSystem',
	#superclass : 'Object',
	#instVars : [
		'positionManager',
		'board'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CellSystem class >> withBoard: board positionManager: aPositionManager [

	^ self new
		  initializeWithBoard: board
		  positionManager: aPositionManager
]

{ #category : 'initialization' }
CellSystem >> initializeWithBoard: aBoard positionManager: aPositionManager [

	board := aBoard.
	positionManager := aPositionManager.
]
