Class {
	#name : 'DoubleCard',
	#superclass : 'WhiteCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
DoubleCard >> playOn: aShip in: aGame [

	aGame assertTheGameIsNotOver ifTrue: [ ^ self ].
	"gameRules assertTheGameIsNotOver ifTrue: [ ^ self ]."
	aGame applyAction: (DoubleTurnAction on: aShip in: aGame)
]
