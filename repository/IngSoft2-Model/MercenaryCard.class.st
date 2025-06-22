Class {
	#name : 'MercenaryCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'helper',
		'type',
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
MercenaryCard >> activateMercenaryOn [

	fixHelper ifFalse: [
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
	fixHelper := false.
	type := 'Permanent'
]

{ #category : 'testing' }
MercenaryCard >> isMercenary [

	^ true
]

{ #category : 'testing' }
MercenaryCard >> isPermanent [

	^ true
]

{ #category : 'as yet unclassified' }
MercenaryCard >> putHelperAs: targetID [

	helper := targetID.
	fixHelper := false
]

{ #category : 'accessing' }
MercenaryCard >> type [

	^ type
]
