Class {
	#name : 'SkipCard',
	#superclass : 'WhiteCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SkipCard >> playOn: aShip in: aGame [

	aGame assertTheGameIsNotOver ifTrue: [ ^ self ].
	aGame applyAction: (SkipAction on: aShip)
]
