Class {
	#name : 'MercenaryCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'helper',
		'fixHelper',
		'helper2'
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
	"borrar"
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
	helper := aHelper. "borrar"
	helper2 := aHelper. "tomar el nombre de la var de arriba"
	fixHelper := false. "borrar"
]

{ #category : 'testing' }
MercenaryCard >> isMercenary [

	^ true
]

{ #category : 'testing' }
MercenaryCard >> isPermanent [
"borrar"
	^ true
]

{ #category : 'as yet unclassified' }
MercenaryCard >> playOn: aShip in: aGame [

	aGame addActive: self to: aShip.
	aGame noOneIsBeingHelpedBy: helper2.
	aGame stablish: helper on: aShip
]

{ #category : 'as yet unclassified' }
MercenaryCard >> putHelperAs: targetID [
	"borrar"
	helper := targetID.
	fixHelper := false
]
