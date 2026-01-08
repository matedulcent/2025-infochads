Class {
	#name : 'SkipForSkipping',
	#superclass : 'SkipStates',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SkipForSkipping >> will: aSpaceShip skipAfter: aDiceRoll on: aGame [

	(self the: aSpaceShip hasTossed0On: aDiceRoll) ifTrue: [ ^ self ].
	aSpaceShip changeSkippingStateTo: (nextSkipState withNext: NoSkip)
]
