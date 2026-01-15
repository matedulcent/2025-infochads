Class {
	#name : 'MoonWalkEffect',
	#superclass : 'Effect',
	#instVars : [
		'backTrack'
	],
	#classInstVars : [
		'desplacement'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
MoonWalkEffect class >> mustBePositive: aDesplacement [

	(aDesplacement isInteger not or: [ aDesplacement <= 0]) ifTrue: [
		Error signal: 'The desplacement must be a posible value.' ]
]

{ #category : 'instance creation' }
MoonWalkEffect class >> withBackTrack: aDesplacement [

	self mustBePositive: aDesplacement.
	^ self new initializeWithBackTrack: aDesplacement
]

{ #category : 'as yet unclassified' }
MoonWalkEffect >> applyOn: aShip in: aGame [
	
	aGame moveEveryShipBut: aShip backBy: backTrack
]

{ #category : 'as yet unclassified' }
MoonWalkEffect >> initializeWithBackTrack: aDesplacement [

	backTrack := aDesplacement
]

{ #category : 'accessing' }
MoonWalkEffect >> prototype [

	| n |
	n := backTrack.
	^ [ :ship :game | self class withBackTrack: n ]
]
