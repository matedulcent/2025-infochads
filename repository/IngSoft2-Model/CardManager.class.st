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

{ #category : 'as yet unclassified' }
CardManager >> grabTopCard [

	deckOfCards isEmpty ifFalse: [ ^ deckOfCards removeLast ].
	^ WhiteCard new
]

{ #category : 'initialization' }
CardManager >> initializeWith: aDeckOfCards [ 

	deckOfCards := aDeckOfCards.
]
