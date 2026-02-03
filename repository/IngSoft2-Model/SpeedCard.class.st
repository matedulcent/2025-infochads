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
SpeedCard >> playOn: aShip in: aCardSystem [

	aCardSystem assertItsTurnToPlayOf: aShip.
	aCardSystem addActive: self to: aShip.

	aCardSystem registerLastCardAction: (SpeedAction on: aShip in: aCardSystem)
]

{ #category : 'as yet unclassified' }
SpeedCard >> unplayOn: aShip in: aCardSystem [

	aShip decrementBooster
]
