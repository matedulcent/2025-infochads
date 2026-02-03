Class {
	#name : 'AccelerationCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'increment',
		'holder'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AccelerationCard >> playOn: aShip in: aCardSystem [

	aCardSystem assertItsTurnToPlayOf: aShip.
	aCardSystem addActive: self to: aShip.
	aCardSystem registerLastCardAction:
		(AccelerationAction on: aShip in: aCardSystem)
]

{ #category : 'as yet unclassified' }
AccelerationCard >> unplayOn: aShip in: aCardSystem [

	aCardSystem decrementAllBoosters
]
