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

{ #category : 'asserting' }
MoonWalkEffect class >> assertIsNumberAndNot0: aDesplacement [

	(aDesplacement isInteger and: [ aDesplacement ~= 0 ]) ifFalse: [
		Error signal: 'The desplacement must be a number different from 0.' ]
]

{ #category : 'instance creation' }
MoonWalkEffect class >> withBackTrack: aDesplacement [

	self assertIsNumberAndNot0: aDesplacement.

	^ self new initializeWithBackTrack: aDesplacement
]

{ #category : 'as yet unclassified' }
MoonWalkEffect >> applyOn: aShip in: aCellSystem [
	
	aCellSystem moveEveryShipBut: aShip backBy: backTrack
]

{ #category : 'as yet unclassified' }
MoonWalkEffect >> initializeWithBackTrack: aDesplacement [

	backTrack := aDesplacement
]

{ #category : 'accessing' }
MoonWalkEffect >> prototype [

	| n |
	n := backTrack.
	^ [ :ship :aCellSystem | self class withBackTrack: n ]
]
