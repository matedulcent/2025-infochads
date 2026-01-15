Class {
	#name : 'BlackHoleEffect',
	#superclass : 'Effect',
	#instVars : [
		'desplacement',
		'backTrack'
	],
	#classInstVars : [
		'displacement'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BlackHoleEffect class >> withBackTrack: aDesplacement [

	^ self new initializeWithBackTrack: aDesplacement
]

{ #category : 'as yet unclassified' }
BlackHoleEffect >> applyOn: aShip in: aGame [
	
	aGame move: aShip backBy: backTrack
]

{ #category : 'as yet unclassified' }
BlackHoleEffect >> initializeWithBackTrack: n [

	backTrack := n
]

{ #category : 'as yet unclassified' }
BlackHoleEffect >> prototype [

	| n |
	n := backTrack.
	^ [ :ship :game | self class withBackTrack: n ]
]
