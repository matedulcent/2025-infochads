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
RedoCard class >> withTarget: aSpaceShipID [ 
	^self new initializeWithTarget: aSpaceShipID
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

{ #category : 'initialization' }
RedoCard >> initializeWithTarget: aSpaceShipID [

	super initializes.
	targetID := aSpaceShipID.
	mimic := WhiteCard new.
	myType := 'Instantaneous'
]

{ #category : 'as yet unclassified' }
RedoCard >> lastPowerUpPlayed: aCell [

	^ mimic lastPowerUpPlayed: aCell
]

{ #category : 'as yet unclassified' }
RedoCard >> mimic: aCard [
	"Mimic otro redo verrrr"

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
