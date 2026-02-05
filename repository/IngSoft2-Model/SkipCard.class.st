Class {
	#name : 'SkipCard',
	#superclass : 'WhiteCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SkipCard >> playOn: aShip in: aCardSystem [

	aCardSystem assertTheGameIsNotOver ifTrue: [ ^ self ].
	aCardSystem addActive: (WhiteCard new) to: aShip.
	aCardSystem registerLastCardAction: (SkipAction on: aShip)
]
