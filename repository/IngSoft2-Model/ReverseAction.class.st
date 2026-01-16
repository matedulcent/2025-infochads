Class {
	#name : 'ReverseAction',
	#superclass : 'CardAction',
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

	^ [ :newShip :aGame :additional | self class in: aGame ]
]
