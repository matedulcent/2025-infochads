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
MercenaryCard class >> withHelpOf: aHelperId [

	^ self new initializeWithHelpOf: aHelperId
]

{ #category : 'initialization' }
MercenaryCard >> initializeWithHelpOf: aHelper [

	helper := aHelper.
	^ self
]

{ #category : 'as yet unclassified' }
MercenaryCard >> playOn: aShip in: aGame [

	aGame addActive: self to: aShip.
	aGame applyAction:
		(MercenaryAction helper: helper on: aShip in: aGame)
]
