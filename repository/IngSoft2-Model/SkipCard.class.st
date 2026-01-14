Class {
	#name : 'SkipCard',
	#superclass : 'WhiteCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SkipCard >> playOn: aShip in: aGame [
	"no instantaneous when the game is over"

	aGame assertTheGameIsNotOver ifTrue: [ ^ self ].
	aGame applyAction: (SkipAction on: aShip)
]
