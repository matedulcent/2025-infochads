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
		            SpeedCard.
		            FreedomCard.
		            ReverseCard.
		            DoubleCard.
		            SkipCard }.

	self shuffleTheCards
]

{ #category : 'as yet unclassified' }
CardDeck >> grabCard [

	^ self nextCard ifNil: [ WhiteCard new ]
]

{ #category : 'as yet unclassified' }
CardDeck >> initializeWithCards: aSelectionOfCards [

	allCards := false.
	cardDeck := OrderedCollection new.
	cardDeck := OrderedCollection newFrom: aSelectionOfCards.
	"If the deck has no pre-charged cards, then it has one of each (Real deck of cards)"
	aSelectionOfCards ifEmpty: [
		allCards := true.
		self allPosibleCardsShuffled ]
]

{ #category : 'testing' }
CardDeck >> isEmpty [

	^ allCards not and: [ cardDeck isEmpty ]
]

{ #category : 'as yet unclassified' }
CardDeck >> nextCard [

	allCards ifTrue: [ ^ self nextRealCard ].
	cardDeck isEmpty ifTrue: [ ^ nil ].
	^ cardDeck removeLast
]

{ #category : 'as yet unclassified' }
CardDeck >> nextRealCard [

	self shuffleTheCards.
	^ cardDeck first deepCopy
]

{ #category : 'removing' }
CardDeck >> removeLast [
	"If the deck is real then it shuffles it every time a card is picked "

	allCards ifTrue: [
		self shuffleTheCards.
		^ cardDeck first deepCopy ].

	^ cardDeck removeLast
]

{ #category : 'as yet unclassified' }
CardDeck >> shuffleTheCards [

	cardDeck shuffle
]
