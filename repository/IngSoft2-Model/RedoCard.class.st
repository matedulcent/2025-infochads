Class {
	#name : 'RedoCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'type',
		'cell'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
RedoCard class >> withObjective [
	
	^self new initializeWithObjective
]

{ #category : 'initialization' }
RedoCard >> initializeWithObjective [

	super initializes.
	cell := NoEffect new.
	type := 'Instantaneous'
]

{ #category : 'accessing' }
RedoCard >> lastPowerUpPlayed: aCell [

	cell := aCell
]

{ #category : 'as yet unclassified' }
RedoCard >> replicateCell [

	^ cell
]

{ #category : 'accessing' }
RedoCard >> type [

	^ type
]
