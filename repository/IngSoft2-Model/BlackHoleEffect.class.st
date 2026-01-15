Class {
	#name : 'BlackHoleEffect',
	#superclass : 'Effect',
	#instVars : [
		'backTrack'
	],
	#classInstVars : [
		'displacement'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'asserting' }
BlackHoleEffect class >> assertIsANumberAnd4: aDesplacement [

	(aDesplacement isInteger and: [ aDesplacement = -4 ]) ifFalse: [
		Error signal: 'The desplacement must be 4.' ]
]

{ #category : 'as yet unclassified' }
BlackHoleEffect class >> withBackTrack: aDesplacement [

	self assertIsANumberAnd4: aDesplacement.
	^ self new initializeWithBackTrack: aDesplacement
]

{ #category : 'as yet unclassified' }
BlackHoleEffect >> applyOn: aShip in: aGame [
	
	aGame move: aShip by: backTrack
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
