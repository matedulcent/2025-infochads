Class {
	#name : 'MercenaryCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'helper',
		'type'
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
	type := 'Permanent'
]

{ #category : 'as yet unclassified' }
MercenaryCard >> mercenary: aSpaceShipID [

	used := true.
	^ helper
]

{ #category : 'accessing' }
MercenaryCard >> type [

	^ type
]
