Class {
	#name : 'DiceSet',
	#superclass : 'Object',
	#instVars : [
		'sackOfDices',
		'maxValue'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
DiceSet class >> withDices: aSackOfDices [

	^ self new initializeWith: aSackOfDices
]

{ #category : 'as yet unclassified' }
DiceSet >> calcuateMaxValue [

	maxValue := sackOfDices sum: [ :dice | dice maxValue ]
]

{ #category : 'initialization' }
DiceSet >> initializeWith: aSackOfDices [
	
	sackOfDices := aSackOfDices.
	self calcuateMaxValue.
]

{ #category : 'accessing' }
DiceSet >> maxValue [

	^ maxValue
]

{ #category : 'as yet unclassified' }
DiceSet >> toss [
	
	^ sackOfDices sum: [ :dice | dice roll ]
]
