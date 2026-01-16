Class {
	#name : 'SkipForSkipping',
	#superclass : 'NoSkip',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SkipForSkipping >> will: aSpaceShip skipAfter: aDiceRoll on: aGame [

	aSpaceShip changeSkippingStateTo: (nextSkipState withNext: NoSkip)
]
