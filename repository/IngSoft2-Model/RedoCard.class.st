Class {
	#name : 'RedoCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'targetID',
		'myType',
		'mimic'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
RedoCard class >> withFillOut: aSpaceShipID [ 
	^self new initializeWithTarget: aSpaceShipID
]

{ #category : 'as yet unclassified' }
RedoCard >> activateMercenaryOn [

	mimic putHelperAs: targetID.
	^ mimic activateMercenaryOn
]

{ #category : 'as yet unclassified' }
RedoCard >> cardObjective: aCard [

	^ mimic cardObjective: aCard
]

{ #category : 'as yet unclassified' }
RedoCard >> effect [

	^ (mimic effect)
]

{ #category : 'as yet unclassified' }
RedoCard >> effectAll [

	^ mimic effectAll 
]

{ #category : 'accessing' }
RedoCard >> helper [

	mimic class = MercenaryCard ifTrue: [ ^ targetID ].
	^ ''
]

{ #category : 'initialization' }
RedoCard >> initializeWithTarget: aSpaceShipID [

	super initializes.
	targetID := aSpaceShipID.
	mimic := WhiteCard new.
	myType := 'Instantaneous'
]

{ #category : 'class membership' }
RedoCard >> isMercenary [

	^ true
]

{ #category : 'testing' }
RedoCard >> isRedo [

	^ true
]

{ #category : 'as yet unclassified' }
RedoCard >> lastPowerUpPlayed: aCell [

	^ mimic lastPowerUpPlayed: aCell
]

{ #category : 'accessing' }
RedoCard >> mimic [

	^ mimic
]

{ #category : 'as yet unclassified' }
RedoCard >> mimic: aCard [

	(mimic class = WhiteCard) ifTrue: [
		mimic := aCard.
		^ true ].

	^ false
]

{ #category : 'as yet unclassified' }
RedoCard >> objective: aSpaceShipId [

	mimic class = CancelationCard ifTrue: [ ^ targetID ].
	^ ''
]

{ #category : 'as yet unclassified' }
RedoCard >> replicateCell [

	^ mimic replicateCell
]

{ #category : 'accessing' }
RedoCard >> target: aSpaceShipId [

	mimic class = RepeatCard ifTrue: [ ^ targetID ].
	^ ''
]

{ #category : 'accessing' }
RedoCard >> type [

	mimic class = WhiteCard ifTrue: [ ^ myType ].

	^ mimic type
]
