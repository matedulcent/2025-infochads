Class {
	#name : 'FreedomCard',
	#superclass : 'WhiteCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
FreedomCard >> playOn: aShip in: aGame [

	aGame assertTheGameIsNotOver ifTrue: [ ^ self ].
	aGame applyAction: (FreedomAction on: aShip)
]
