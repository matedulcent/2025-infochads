Class {
	#name : 'PlayDouble',
	#superclass : 'NoSkip',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
PlayDouble >> will: aSpaceShip skipAfter: aDiceRoll on: aGame [

	super will: aSpaceShip skipAfter: aDiceRoll on: aGame.
	super will: aSpaceShip skipAfter: aDiceRoll on: aGame.
	aSpaceShip changeSkippingStateTo: (nextSkipState withNext: NoSkip)
]
