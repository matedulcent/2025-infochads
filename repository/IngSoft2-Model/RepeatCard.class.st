Class {
	#name : 'RepeatCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'type',
		'cell'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
RepeatCard class >> withObjective [
	
	^self new initializeWithObjective
]

{ #category : 'initialization' }
RepeatCard >> initializeWithObjective [

	super initializes.
	cell := NoEffect new.
	type := 'Instantaneous'
]

{ #category : 'accessing' }
RepeatCard >> lastPowerUpPlayed: aCell [

	cell := aCell
]

{ #category : 'as yet unclassified' }
RepeatCard >> replicateCell [

	^ cell
]

{ #category : 'accessing' }
RepeatCard >> type [

	^ type
]
