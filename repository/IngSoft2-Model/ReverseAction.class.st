Class {
	#name : 'ReverseAction',
	#superclass : 'ActionGroupCard',
	#instVars : [
		'game'
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

	game reverseTurns
]

{ #category : 'initialization' }
ReverseAction >> initializeIn: aGame [

	game := aGame.
	^ self
]

{ #category : 'accessing' }
ReverseAction >> prototype [

	^ [ :aGame | ReverseAction in: aGame ]
]
