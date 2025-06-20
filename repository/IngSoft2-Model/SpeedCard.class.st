Class {
	#name : 'SpeedCard',
	#superclass : 'Object',
	#instVars : [
		'increment'
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

{ #category : 'initialization' }
SpeedCard >> initializeWith: aTossIncrement [

	increment := aTossIncrement
]
