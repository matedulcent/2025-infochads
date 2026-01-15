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
HyperSpaceJumpEffect class >> withForwardTrack: aDesplacement [

	^ self new initializeWithFrowardTrack: aDesplacement
]

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect >> applyOn: aShip in: aGame [

	aGame move: aShip by: forwardTrack.
	aShip loseShield
]

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect >> initializeWithFrowardTrack: n [

	forwardTrack := n
]
