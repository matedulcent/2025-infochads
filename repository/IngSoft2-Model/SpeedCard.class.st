Class {
	#name : 'SpeedCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'increment',
		'holder'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpeedCard class >> mustBeOne: aTossIncrement [

	(aTossIncrement isInteger not or: [ aTossIncrement ~= 1 ]) ifTrue: [
		Error signal: 'The increment in the dice toss must be one.' ]
]

{ #category : 'instance creation' }
SpeedCard class >> with: aTossIncrement [

	self mustBeOne: aTossIncrement.
	^ self new initializeWith: aTossIncrement
]

{ #category : 'as yet unclassified' }
SpeedCard >> effect [

	^ Position at: increment withLaps: 0
]

{ #category : 'initialization' }
SpeedCard >> initializeWith: aTossIncrement [

	super initializes.
	increment := aTossIncrement.
]

{ #category : 'testing' }
SpeedCard >> isPermanent [

	^ true
]

{ #category : 'as yet unclassified' }
SpeedCard >> playOn: aShip in: aGame [

	holder := aShip.
	"check si es el turno de la nave"
	aShip incrementBooster.
	aGame addActive: self to: aShip
]

{ #category : 'as yet unclassified' }
SpeedCard >> unPlay [

	"para el canecel"
]
