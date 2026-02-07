Class {
	#name : 'RedoCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'targetId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
RedoCard class >> withFillOut: aSpaceShipID [

	^ self new initializeWithTarget: aSpaceShipID
]

{ #category : 'initialization' }
RedoCard >> initializeWithTarget: aSpaceShipID [

	targetId := aSpaceShipID.
]

{ #category : 'as yet unclassified' }
RedoCard >> playOn: aShip in: aCardSystem [

	aCardSystem assertTheGameIsNotOver ifTrue: [ ^ self ].
	aCardSystem redoLastActionOn: aShip withAdditional: targetId
]
