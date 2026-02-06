Class {
	#name : 'CancelationCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'card',
		'objective'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CancelationCard class >> withObjective: aCard toShip: objective [

	^ self new initializeWith: aCard and: objective
]

{ #category : 'initialization' }
CancelationCard >> initializeWith: aCard and: anObjective [

	card := aCard.
	objective := anObjective.
]

{ #category : 'as yet unclassified' }
CancelationCard >> playOn: aShip in: aCardSystem [

	aCardSystem assertTheGameIsNotOver ifTrue: [ ^ self ].
	aCardSystem registerPlayOf: self playedRepresentation by: aShip.
	aCardSystem registerLastCardAction:
		(CancelationAction to: card on: objective in: aCardSystem)
]
