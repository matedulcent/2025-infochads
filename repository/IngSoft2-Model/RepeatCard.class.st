Class {
	#name : 'RepeatCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'target'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
RepeatCard class >> withObjective: aTarget [

	^ self new initializeWithObjective: aTarget
]

{ #category : 'initialization' }
RepeatCard >> initializeWithObjective: anObjective [

	target := anObjective
]

{ #category : 'as yet unclassified' }
RepeatCard >> playOn: aShip in: aCardSystem [

	aCardSystem assertTheGameIsNotOver ifTrue: [ ^ self ].
	aCardSystem registerPlayOf: self playedRepresentation by: aShip.
	aCardSystem registerLastCardAction:
		(RepeatAction on: target in: aCardSystem)
]
