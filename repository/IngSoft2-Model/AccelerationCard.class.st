Class {
	#name : 'AccelerationCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'increment'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AccelerationCard class >> mustBeOne: aTossIncrement [

	(aTossIncrement isInteger not or: [ aTossIncrement ~= 1 ]) ifTrue: [
		Error signal: 'The increment in the dice toss must be one.' ]
]

{ #category : 'instance creation' }
AccelerationCard class >> with: aTossIncrement [

	self mustBeOne: aTossIncrement.
	^ self new initializeWith: aTossIncrement
]

{ #category : 'as yet unclassified' }
AccelerationCard >> effectAll [

	^ Position at: increment withLaps: 0
]

{ #category : 'initialization' }
AccelerationCard >> initializeWith: aTossIncrement [

	super initializes.
	increment := aTossIncrement.
]

{ #category : 'testing' }
AccelerationCard >> isPermanent [

	^ true
]
