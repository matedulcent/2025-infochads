Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
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
TurnManager >> doubleTurn [

	orderedShips addFirst: (orderedShips removeLast) 
]

{ #category : 'as yet unclassified' }
TurnManager >> grab [

	^ orderedShips first 
]

{ #category : 'as yet unclassified' }
TurnManager >> grabAndUpdate [

	| nextShip |
	nextShip := orderedShips removeFirst.
	orderedShips addLast: nextShip.
	^ nextShip
]

{ #category : 'initialization' }
TurnManager >> initializeWith: aListOfSpaceShips [

	orderedShips := aListOfSpaceShips.
]

{ #category : 'as yet unclassified' }
TurnManager >> reverseTheTurns [

	orderedShips := orderedShips reversed
]
