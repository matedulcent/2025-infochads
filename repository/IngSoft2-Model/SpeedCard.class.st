Class {
	#name : 'SpeedCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'increment',
		'holder'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpeedCard >> playOn: aShip in: aGame [

	"check si es el turno de la nave" "-> Rehacer"
	aGame addActive: self to: aShip.
	
	aGame applyAction:
        (SpeedAction on: aShip in: aGame)
	
]

{ #category : 'as yet unclassified' }
SpeedCard >> unPlay [

	"para el canecel"
]
