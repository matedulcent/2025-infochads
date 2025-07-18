Class {
	#name : 'ReverseCard',
	#superclass : 'WhiteCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
ReverseCard >> invertOrder: step [

	^ -1 * step
]
