Class {
	#name : 'WhiteCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
WhiteCard class >> create [

	^self new initializes
]

{ #category : 'as yet unclassified' }
WhiteCard >> activateMercenaryOn [

	^ false
]

{ #category : 'as yet unclassified' }
WhiteCard >> cardObjective: aCard [

	^ aCard class
]

{ #category : 'as yet unclassified' }
WhiteCard >> effect [

	^ Position at: 0 withLaps: 0
]

{ #category : 'as yet unclassified' }
WhiteCard >> effectAll [

	^ Position at: 0 withLaps: 0
]

{ #category : 'instance creation' }
WhiteCard >> free: aSpaceShip [

	^ self
]

{ #category : 'accessing' }
WhiteCard >> helper [

	^ false
]

{ #category : 'as yet unclassified' }
WhiteCard >> initializes [

]

{ #category : 'as yet unclassified' }
WhiteCard >> invertOrder: step [

	^ step
]

{ #category : 'testing' }
WhiteCard >> isMercenary [

	^ false
]

{ #category : 'testing' }
WhiteCard >> isPermanent [

	^ false
]

{ #category : 'testing' }
WhiteCard >> isRedo [

	^ false
]

{ #category : 'accessing' }
WhiteCard >> lastPowerUpPlayed: aCell [

	^ self
]

{ #category : 'as yet unclassified' }
WhiteCard >> mimic: aCard [

	^ false
]

{ #category : 'as yet unclassified' }
WhiteCard >> objective: aSpaceShipId [

	^ ''
]

{ #category : 'as yet unclassified' }
WhiteCard >> playTwice: stepOfNextSpaceShipToMove [

	^ stepOfNextSpaceShipToMove
]

{ #category : 'as yet unclassified' }
WhiteCard >> putHelperAs: aSpaceShipID [

	^ true
]

{ #category : 'as yet unclassified' }
WhiteCard >> replicateCell [

	^ Cell has: NoEffect new
]

{ #category : 'asserting' }
WhiteCard >> skip [

	^ false
]

{ #category : 'accessing' }
WhiteCard >> target: aSpaceShipId [

	^ ''
]
