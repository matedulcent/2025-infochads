Class {
	#name : 'FreedomCard',
	#superclass : 'WhiteCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
FreedomCard >> playOn: aShip in: aCardSystem [

	aCardSystem assertTheGameIsNotOver ifTrue: [ ^ self ].
	aCardSystem registerPlayOf: self playedRepresentation by: aShip.
	aCardSystem registerLastCardAction: (FreedomAction on: aShip)
]
