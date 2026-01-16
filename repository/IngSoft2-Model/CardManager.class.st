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

{ #category : 'as yet unclassified' }
CardManager >> grabTopCard [

	deckOfCards isEmpty ifFalse: [ ^ deckOfCards removeLast ].
	^ WhiteCard new
]

{ #category : 'initialization' }
CardManager >> initializeWith: aDeckOfCards [ 

	deckOfCards := aDeckOfCards.
	lastCellPlayed := Cell has: Effect new
]

{ #category : 'accessing' }
CardManager >> lastCellPlayed: aCell [

	lastCellPlayed := aCell 
]
