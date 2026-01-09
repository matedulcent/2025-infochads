Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'spaceShips',
		'nextSpaceShip',
		'orderedShips'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
TurnManager class >> withThe: spaceShips [
	
	^ self new initializeWith: spaceShips
]

{ #category : 'as yet unclassified' }
TurnManager >> futureShip [

	^ orderedShips first.
]

{ #category : 'as yet unclassified' }
TurnManager >> grab [

	| nextShip |
	nextShip := orderedShips removeFirst.
	orderedShips addLast: nextShip.

	^ nextShip
]

{ #category : 'initialization' }
TurnManager >> initializeWith: aListOfSpaceShips [

	spaceShips := aListOfSpaceShips. 
	orderedShips := aListOfSpaceShips.
]
