Class {
	#name : 'DoubleCard',
	#superclass : 'WhiteCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
DoubleCard >> playTwice: listOfAlteredSteps [

	| result |
	result := listOfAlteredSteps asOrderedCollection copy.
	result add: 0.
	result add: 0.
	^ result
]
