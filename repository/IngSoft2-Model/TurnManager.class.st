Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'orderedShips',
		'nextSpaceShipToMove'
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

	^ nextSpaceShipToMove 
]

{ #category : 'as yet unclassified' }
TurnManager >> grabAndUpdate [

	| nextSpaceShip |
	nextSpaceShip := nextSpaceShipToMove.
	self update.
	^ nextSpaceShip
]

{ #category : 'initialization' }
TurnManager >> initializeWith: aListOfSpaceShips [

	orderedShips := aListOfSpaceShips.
	nextSpaceShipToMove := aListOfSpaceShips first.
]

{ #category : 'as yet unclassified' }
TurnManager >> update [

	| nextShip |
	nextShip := orderedShips removeFirst.
	orderedShips addLast: nextShip.
	nextSpaceShipToMove := orderedShips first 
	
]
