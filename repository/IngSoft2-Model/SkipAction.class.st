Class {
	#name : 'SkipAction',
	#superclass : 'CardAction',
	#instVars : [
		'ship',
		'previousState'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
SkipAction class >> on: aShip [

	^ self new initializeOn: aShip
]

{ #category : 'private' }
SkipAction >> apply [

	ship changeSkippingStateTo: (SkipForSkipping withNext: NoSkip)
]

{ #category : 'initialization' }
SkipAction >> initializeOn: aShip [

	ship := aShip.
	^ self.
]

{ #category : 'accessing' }
SkipAction >> prototype [

	^ [ :newShip :aCardSystem :additional | self class on: newShip ]
]
