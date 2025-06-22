Class {
	#name : 'CardManager',
	#superclass : 'Object',
	#instVars : [
		'deckOfCards',
		'activeCards',
		'lastCardPlayed',
		'lastCellPlayed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardManager class >> createWith: aDeckOfCards [

	^self new initializeWith: aDeckOfCards 
]

{ #category : 'accessing' }
CardManager >> activeCards [

	^ activeCards 
]

{ #category : 'adding' }
CardManager >> addNew: spaceShipID [

	activeCards at: spaceShipID put: OrderedCollection new.
]

{ #category : 'as yet unclassified' }
CardManager >> getLastCardPlayed [

	^ lastCardPlayed 
]

{ #category : 'as yet unclassified' }
CardManager >> grabTopCard [

	deckOfCards isEmpty ifFalse: [ ^ deckOfCards removeLast ].
	^ WhiteCard create
]

{ #category : 'initialization' }
CardManager >> initializeWith: aDeckOfCards [ 

	deckOfCards := aDeckOfCards.
	activeCards := OrderedDictionary new.
	lastCardPlayed := WhiteCard new.
	lastCellPlayed := Cell has: NoEffect new
]

{ #category : 'accessing' }
CardManager >> lastCardPlayed: aCard [

	lastCardPlayed := aCard
]

{ #category : 'accessing' }
CardManager >> lastPlayed: aCell [

	lastCellPlayed := aCell 
]

{ #category : 'as yet unclassified' }
CardManager >> playCancelation: aCard on: aShip [

	| card |
	(aCard objective: aShip id) = '' ifTrue: [ ^ self ].
	card := (activeCards at: (aCard objective: aShip id))
		        detect: [ :cardOfShip |
		        cardOfShip class = (aCard cardObjective: aCard) class ]
		        ifNone: [
			        Error signal:
				        'This card cant be played if the card to be canceled is not active.' ].
	(activeCards at: (aCard objective: aShip id)) remove: card.
	aShip deMercenarize
]

{ #category : 'as yet unclassified' }
CardManager >> playRedo: aCard on: aShip [

	self getLastCardPlayed isRedo ifFalse: [
		aCard mimic: self getLastCardPlayed deepCopy.
		^ self ].

	aCard isRedo ifTrue: [
		aCard mimic: self getLastCardPlayed mimic deepCopy ]
]

{ #category : 'as yet unclassified' }
CardManager >> playRepeat: aCard on: aShip and: spaceShips dependingOn: spaceShipPositions [

	| cell objectiveShip |
	
	aCard lastPowerUpPlayed: lastCellPlayed .
	((aCard target: aShip id) = '') ifTrue: [ ^self ].
	cell := aCard replicateCell.
	objectiveShip := spaceShips detect: [ :ship |
		                 ship id = (aCard target: aShip id) ].
	
	cell
		takeActionOver: objectiveShip
		or: spaceShips
		thatArePlaced: spaceShipPositions.
]
