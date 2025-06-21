Class {
	#name : 'MercenaryCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'helper',
		'type',
		'helperOf',
		'fixHelper'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
MercenaryCard class >> withHelpOf: aSpaceShipID [

	^ self new initializeWithHelpOf: aSpaceShipID
]

{ #category : 'as yet unclassified' }
MercenaryCard >> activateMercenaryOn: aSpaceShipID [

	fixHelper ifFalse: [
		helperOf := aSpaceShipID.
		fixHelper := true.
		^ true ].

	^ false
]

{ #category : 'accessing' }
MercenaryCard >> helper [

	^ helper
]

{ #category : 'initialization' }
MercenaryCard >> initializeWithHelpOf: aHelper [

	super initializes.
	helper := aHelper.
	helperOf := aHelper.
	fixHelper := false.
	type := 'Permanent'
]

{ #category : 'accessing' }
MercenaryCard >> type [

	^ type
]
