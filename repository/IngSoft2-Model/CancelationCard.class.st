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

{ #category : 'as yet unclassified' }
CancelationCard >> cardObjective: aCard [

	^ card
]

{ #category : 'initialization' }
CancelationCard >> initializeWith: aCard and: anObjective [

	super initializes.
	card := aCard.
	objective := anObjective.
]

{ #category : 'as yet unclassified' }
CancelationCard >> objective: aSpaceShipId [

	^ objective 
]
