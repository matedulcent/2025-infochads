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

{ #category : 'as yet unclassified' }
MercenaryCard >> helper [

	^ helper
]

{ #category : 'initialization' }
MercenaryCard >> initializeWithHelpOf: aHelper [

	helper := aHelper.
	^ self
]

{ #category : 'as yet unclassified' }
MercenaryCard >> playOn: aShip in: aCardSystem [

	aCardSystem assertItsTurnToPlayOf: aShip.
	aCardSystem addActive: self to: aShip.
	aCardSystem registerLastCardAction:
		(MercenaryAction helper: helper on: aShip in: aCardSystem)
]

{ #category : 'as yet unclassified' }
MercenaryCard >> unplayOn: aShip in: aCardSystem [

	aCardSystem unStablish: helper on: aShip
]
