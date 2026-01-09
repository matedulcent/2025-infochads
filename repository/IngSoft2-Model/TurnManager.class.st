Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'orderedShips',
		'currentShipPlaying',
		'grantExtraTurn'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
TurnManager class >> withThe: spaceShips [
	
	^ self new initializeWith: spaceShips
]

{ #category : 'as yet unclassified' }
TurnManager >> doubleTurnOn: aShip [

	grantExtraTurn:= true.
	"orderedShips addFirst: orderedShips removeLast"
]

{ #category : 'as yet unclassified' }
TurnManager >> grab [

	^ orderedShips first 
]

{ #category : 'as yet unclassified' }
TurnManager >> grabAndUpdate [

	(grantExtraTurn and: currentShipPlaying isNil) ifTrue: [
		grantExtraTurn := false.
		currentShipPlaying := orderedShips first.
		^ currentShipPlaying ].
	grantExtraTurn ifTrue: [
		grantExtraTurn := false.
		^ currentShipPlaying ].

	currentShipPlaying := orderedShips removeFirst.
	orderedShips addLast: currentShipPlaying.
	^ currentShipPlaying
]

{ #category : 'initialization' }
TurnManager >> initializeWith: aListOfSpaceShips [

	orderedShips := aListOfSpaceShips.
	currentShipPlaying := nil.
	grantExtraTurn := false.
]

{ #category : 'as yet unclassified' }
TurnManager >> reverseTheTurns [

	orderedShips := orderedShips reversed
]
