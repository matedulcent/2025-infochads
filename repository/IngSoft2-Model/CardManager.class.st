Class {
	#name : 'CardManager',
	#superclass : 'Object',
	#instVars : [
		'deckOfCards',
		'activeCards'
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
CardManager >> grabTopCard [

	deckOfCards isEmpty ifFalse: [ ^ deckOfCards removeLast ].
	^ WhiteCard create
]

{ #category : 'initialization' }
CardManager >> initializeWith: aDeckOfCards [ 

	deckOfCards := aDeckOfCards.
	activeCards := OrderedDictionary new.
]
