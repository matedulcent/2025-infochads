Class {
	#name : 'WhiteCard',
	#superclass : 'Object',
	#instVars : [
		'used'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
WhiteCard class >> create [

	^self new initializes
]

{ #category : 'as yet unclassified' }
WhiteCard >> cardObjective: aCard [

	^ aCard class
]

{ #category : 'as yet unclassified' }
WhiteCard >> effect [

	^ Position at: 0 withLaps: 0
]

{ #category : 'as yet unclassified' }
WhiteCard >> effectAll [

	^ Position at: 0 withLaps: 0
]

{ #category : 'as yet unclassified' }
WhiteCard >> initializes [

	used := false
]

{ #category : 'as yet unclassified' }
WhiteCard >> mercenary: aSpaceShipID [

	^ aSpaceShipID
]

{ #category : 'as yet unclassified' }
WhiteCard >> objective: aShipId [

	^ aShipId
]

{ #category : 'accessing' }
WhiteCard >> used [

	^ used
]
