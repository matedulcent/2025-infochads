Class {
	#name : 'ReverseCard',
	#superclass : 'WhiteCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
ReverseCard >> playOn: aShip in: aCardSystem [

	aCardSystem assertTheGameIsNotOver ifTrue: [ ^ self ].
	aCardSystem addActive: (WhiteCard new) to: aShip.
	aCardSystem registerLastCardAction: (ReverseAction in: aCardSystem)
]
