Class {
	#name : 'SkipState',
	#superclass : 'Object',
	#instVars : [
		'nextSkipState'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SkipState >> initializeWithNext: aSkipState [

	nextSkipState := aSkipState
]

{ #category : 'accessing' }
SkipState >> next [

	"^ nextSkipState"
]

{ #category : 'as yet unclassified' }
SkipState >> playTurnFor: aShip with: aDiceRoll in: aGame [

	self subclassResponsibility
]
