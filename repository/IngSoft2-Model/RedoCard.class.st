Class {
	#name : 'RedoCard',
	#superclass : 'WhiteCard',
	#instVars : [
		'targetID',
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
RedoCard >> playOn: aShip in: aGame [

	aGame redoLastActionOn: aShip
]
