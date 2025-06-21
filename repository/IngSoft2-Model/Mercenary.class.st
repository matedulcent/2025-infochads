Class {
	#name : 'Mercenary',
	#superclass : 'WhiteCard',
	#instVars : [
		'helper',
		'type'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Mercenary class >> withHelpOf: aSpaceShipID [

	^ self new initializeWithHelpOf: aSpaceShipID
]

{ #category : 'initialization' }
Mercenary >> initializeWithHelpOf: aHelper [

	super initializes.
	helper := aHelper.
	type := 'Instantaneous'
]

{ #category : 'as yet unclassified' }
Mercenary >> mercenary: aSpaceShipID [

	used := true.
	^ helper
]

{ #category : 'accessing' }
Mercenary >> type [

	^ type
]
