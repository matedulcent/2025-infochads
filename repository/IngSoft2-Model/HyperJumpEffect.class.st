Class {
	#name : 'HyperJumpEffect',
	#superclass : 'Effect',
	#instVars : [
		'listOfJumps',
		'parsecsPerCell'
	],
	#classInstVars : [
		'parsecs',
		'parsecScale',
		'listOfJumps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperJumpEffect class >> mustHaveAtleastOne: jumps [

	jumps ifEmpty: [
		Error signal: 'The Jump list must have at least one value.' ]
]

{ #category : 'as yet unclassified' }
HyperJumpEffect class >> with: aParsecValue andParsec: jumps [

	self mustHaveAtleastOne: jumps.
	^self new initializeWith: aParsecValue andParsec: jumps
]

{ #category : 'as yet unclassified' }
HyperJumpEffect >> applyOn: aShip in: aGame [

	| aDisplacement |
	aDisplacement := listOfJumps removeFirst.
	listOfJumps add: aDisplacement.

	aGame move: aShip by: aDisplacement / parsecsPerCell
]

{ #category : 'as yet unclassified' }
HyperJumpEffect >> initializeWith: aParsecValue andParsec: jumps [

	parsecsPerCell := aParsecValue.
	listOfJumps := jumps
]

{ #category : 'accessing' }
HyperJumpEffect >> prototype [

	| parsec jumps |
	parsec := parsecsPerCell.
	jumps := listOfJumps.
	^ [ :ship :game | self class with: parsec andParsec: jumps ]
]
