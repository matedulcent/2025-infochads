Class {
	#name : 'DoubleCard',
	#superclass : 'WhiteCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
DoubleCard >> playOn: aShip in: aCardSystem [

	aCardSystem assertTheGameIsNotOver ifTrue: [ ^ self ].
	aCardSystem addActive: (WhiteCard new) to: aShip.
	aCardSystem registerLastCardAction:
		(DoubleTurnAction on: aShip in: aCardSystem)
]
