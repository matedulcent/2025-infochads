Class {
	#name : 'SkipForShields',
	#superclass : 'SkipState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SkipForShields >> initializeWithNext: aSkipState [

	nextSkipState := aSkipState
]

{ #category : 'as yet unclassified' }
SkipForShields >> playTurnFor: aShip with: aDiceRoll in: aGame [

	aShip rechargeShields.
	aShip skipState: nextSkipState.
	aGame rollTheDice
]

{ #category : 'as yet unclassified' }
SkipForShields >> will: aSpaceShip skipAfter: aDiceRoll on: aGame [

	"aSpaceShip rechargeShields.
	nextSkipState will: aSpaceShip skipAfter: aDiceRoll on: aGame.
	aGame rollTheDice"
]
