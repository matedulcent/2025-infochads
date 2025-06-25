Class {
	#name : 'CardEffect',
	#superclass : 'NoEffect',
	#instVars : [
		'setOfCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardEffect class >> with: aSetOfCards [

	^ self new initializeWith: aSetOfCards
]

{ #category : 'as yet unclassified' }
CardEffect >> grabCard [

	^ setOfCards removeLast
]

{ #category : 'initialization' }
CardEffect >> initializeWith: aSetOfCards [

	setOfCards := aSetOfCards
]
