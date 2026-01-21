Class {
	#name : 'NoSkip',
	#superclass : 'SkipState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
NoSkip class >> withNext: aSkipState [

	^ self new initializeWithNext: aSkipState.
]

{ #category : 'initialization' }
NoSkip >> initialize [

	nextSkipState := self
]

{ #category : 'as yet unclassified' }
NoSkip >> playTurnFor: aShip with: aDiceRoll in: aGame [

	aShip state playTurnFor: aShip with: aDiceRoll in: aGame
]

{ #category : 'as yet unclassified' }
NoSkip >> will: aSpaceShip skipAfter: aDiceRoll on: aGame [

	"aSpaceShip isImprisionedByTossing: aDiceRoll on: aGame"
]
