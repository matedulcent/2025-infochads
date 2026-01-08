Class {
	#name : 'SkipForShields',
	#superclass : 'SkipForSkipping',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SkipForShields >> will: aSpaceShip skipAfter: aDiceRoll on: aGame [

	aSpaceShip rechargeShields.
	super will: aSpaceShip skipAfter: aDiceRoll on: aGame
]
