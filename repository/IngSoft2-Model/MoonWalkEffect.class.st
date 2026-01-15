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

{ #category : 'instance creation' }
MoonWalkEffect class >> withBackTrack: aDesplacement [


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
