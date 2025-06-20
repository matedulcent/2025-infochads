Class {
	#name : 'WhiteCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
WhiteCard class >> create [

	^self new initialize
]

{ #category : 'class initialization' }
WhiteCard class >> initialize [
]

{ #category : 'as yet unclassified' }
WhiteCard >> effect [

	^ Position at: 0 withLaps: 0
]

{ #category : 'as yet unclassified' }
WhiteCard >> effectAll [

	^ Position at: 0 withLaps: 0
]

{ #category : 'activation' }
WhiteCard >> initialize [

]
