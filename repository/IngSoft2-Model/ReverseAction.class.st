Class {
	#name : 'ReverseAction',
	#superclass : 'CardAction',
	#instVars : [
		'cardSystem'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'evaluating' }
ReverseAction class >> in: aGame [

	^ self new initializeIn: aGame
]

{ #category : 'private' }
ReverseAction >> apply [

	cardSystem reverseTurns
]

{ #category : 'initialization' }
ReverseAction >> initializeIn: aCardSystem [

	cardSystem := aCardSystem.
	^ self
]

{ #category : 'accessing' }
ReverseAction >> prototype [

	^ [ :newShip :aCardSystem :additional | self class in: aCardSystem ]
]
