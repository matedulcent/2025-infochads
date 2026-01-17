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
TurnManager >> advanceTurn [

	currentShipPlaying := orderedShips removeFirst.
	orderedShips addLast: currentShipPlaying.
	^ currentShipPlaying
]

{ #category : 'accessing' }
TurnManager >> currentShipPlaying [

	^ currentShipPlaying
]

{ #category : 'as yet unclassified' }
TurnManager >> doubleTurnOn: aShip [

	grantExtraTurn := true
]

{ #category : 'as yet unclassified' }
TurnManager >> grab [

	^ orderedShips first 
]

{ #category : 'as yet unclassified' }
TurnManager >> grabAndUpdate [

	grantExtraTurn ifTrue: [ ^ self keepCurrentShip ].
	^ self advanceTurn
]

{ #category : 'initialization' }
TurnManager >> initializeWith: aListOfSpaceShips [

	orderedShips := aListOfSpaceShips.
	currentShipPlaying := nil.
	grantExtraTurn := false.
]

{ #category : 'as yet unclassified' }
TurnManager >> keepCurrentShip [

	grantExtraTurn := false.
	currentShipPlaying ifNil: [ currentShipPlaying := orderedShips first ].
	^ currentShipPlaying
]

{ #category : 'as yet unclassified' }
TurnManager >> obtainShipById: aSpaceShipID [

	| aShip |
	aShip := orderedShips
		         detect: [ :ship | ship id = aSpaceShipID ]
		         ifNone: [ Error signal: 'The ship doesnt exist' ].
	^ aShip
]

{ #category : 'as yet unclassified' }
TurnManager >> reverseTheTurns [

	orderedShips := orderedShips reversed
]
