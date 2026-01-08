Class {
	#name : 'DoubleCard',
	#superclass : 'WhiteCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
DoubleCard >> doubleTurnTo: aShip [

	aShip changeSkippingStateTo: (PlayDouble withNext: NoSkip).
]
