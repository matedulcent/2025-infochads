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

	super initializes.
	objective := anObjective.
	cell := NoEffect new.
]

{ #category : 'accessing' }
RepeatCard >> lastPowerUpPlayed: aCell [

	cell := aCell
]

{ #category : 'as yet unclassified' }
RepeatCard >> replicateCell [

	^ cell
]

{ #category : 'as yet unclassified' }
RepeatCard >> target: aSpaceShipId [

	^ objective 
]
