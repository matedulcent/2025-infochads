Class {
	#name : 'MercenaryCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'helper'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
MercenaryCard class >> withHelpOf: aSpaceShipID [

	^ self new initializeWithHelpOf: aSpaceShipID
]

{ #category : 'initialization' }
MercenaryCard >> initializeWithHelpOf: aHelper [

	super initializes.
	helper := aHelper.
]

{ #category : 'as yet unclassified' }
MercenaryCard >> playOn: aShip in: aGame [

	aGame addActive: self to: aShip.
	aGame assertMercenaryIsNotHelpingAnotherShip: helper.
	aGame stablish: helper on: aShip
]
