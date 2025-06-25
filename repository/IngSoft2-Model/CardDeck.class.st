Class {
	#name : 'CardDeck',
	#superclass : 'Object',
	#instVars : [
		'cardDeck',
		'allCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardDeck class >> withCards: aSelectionOfCards [

	^ self new initializeWithCards: aSelectionOfCards
]

{ #category : 'as yet unclassified' }
CardDeck >> allPosibleCardsShuffled [

	cardDeck := {
		            AccelerationCard.
		            CancelationCard.
		            MercenaryCard.
		            RedoCard.
		            RepeatCard.
		            SpeedCard }.
	self shuffleTheCards
]

{ #category : 'as yet unclassified' }
CardDeck >> initializeWithCards: aSelectionOfCards [

	allCards := false.
	cardDeck := OrderedCollection new.
	cardDeck := OrderedCollection newFrom: aSelectionOfCards.
	aSelectionOfCards ifEmpty: [
		allCards := true.
		self allPosibleCardsShuffled ]
]

{ #category : 'testing' }
CardDeck >> isEmpty [

	^ cardDeck isEmpty 
]

{ #category : 'removing' }
CardDeck >> removeLast [

	allCards ifTrue: [
		self shuffleTheCards.
		^ cardDeck first deepCopy ].
	^ cardDeck removeLast
]

{ #category : 'as yet unclassified' }
CardDeck >> shuffleTheCards [

	cardDeck shuffle
]
