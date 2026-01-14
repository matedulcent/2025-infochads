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

{ #category : 'initialization' }
AccelerationCard >> initializeWith: aTossIncrement [

	super initializes.
	increment := aTossIncrement.
]

{ #category : 'as yet unclassified' }
AccelerationCard >> playOn: aShip in: aGame [

	aGame addActive: self to: aShip.
	aGame applyAction: (AccelerationAction on: aShip in: aGame)
]
