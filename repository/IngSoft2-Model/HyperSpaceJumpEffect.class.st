Class {
	#name : 'HyperSpaceJumpEffect',
	#superclass : 'Effect',
	#instVars : [
		'forwardTrack'
	],
	#classInstVars : [
		'displacement'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect class >> assertIsANumberAnd4: aDesplacement [

	(aDesplacement isInteger and: [ aDesplacement = 4 ]) ifFalse: [
		Error signal: 'The desplacement must be 4.' ]
]

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect class >> withForwardTrack: aDesplacement [

	self assertIsANumberAnd4: aDesplacement.
	^ self new initializeWithFrowardTrack: aDesplacement
]

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect >> applyOn: aShip in: aCellSystem [

	aCellSystem move: aShip by: forwardTrack.
	aShip loseShield
]

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect >> initializeWithFrowardTrack: n [

	forwardTrack := n
]

{ #category : 'accessing' }
HyperSpaceJumpEffect >> prototype [

	| n |
	n := forwardTrack .
	^ [ self class withForwardTrack: n ]
]
