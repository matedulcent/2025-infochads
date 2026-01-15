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
BlackHoleEffect class >> mustBeFour: aDesplacement [

	(aDesplacement isInteger not or: [ aDesplacement ~= 4 ]) ifTrue: [
		Error signal: 'The desplacement must be 4.' ]
]

{ #category : 'as yet unclassified' }
BlackHoleEffect class >> withBackTrack: aDesplacement [

	self mustBeFour: aDesplacement.
	^ self new initializeWith: aDesplacement
]

{ #category : 'as yet unclassified' }
BlackHoleEffect >> applyOn: aShip in: aGame [

	aGame move: aShip backBy: backTrack
]

{ #category : 'as yet unclassified' }
BlackHoleEffect >> applyToSpaceShip: aPosition [

	^ Position at: aPosition - desplacement withLaps: 0.
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
