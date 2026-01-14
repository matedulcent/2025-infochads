Class {
	#name : 'RepeatCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'cell',
		'objective'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
RepeatCard class >> withObjective: anObjective [
	
	^self new initializeWith: anObjective
]

{ #category : 'initialization' }
RepeatCard >> initializeWith: anObjective [

	"super initializes."
	objective := anObjective. "borrar"
	cell := NoEffect new. "borrar"
]

{ #category : 'accessing' }
RepeatCard >> lastPowerUpPlayed: aCell [
	"borrar"
	cell := aCell
]

{ #category : 'as yet unclassified' }
RepeatCard >> playOn: aShip in: aGame [

	"aGame playLastCellOn: aShip."
]

{ #category : 'as yet unclassified' }
RepeatCard >> replicateCell [
	"borrar"
	^ cell
]

{ #category : 'as yet unclassified' }
RepeatCard >> target: aSpaceShipId [
	"borrar"
	^ objective 
]
