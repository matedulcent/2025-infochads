Class {
	#name : 'SkipForShields',
	#superclass : 'SkipStates',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SkipForShields >> will: aSpaceShip skipAfter: aDiceRoll on: aGame [
	aSpaceShip rechargeShields.
	aSpaceShip changeSkippingStateTo:
		(nextSkipState withNext: NoSkip new)
]
