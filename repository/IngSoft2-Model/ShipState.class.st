Class {
	#name : 'ShipState',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
ShipState >> isLockedUp [

	^ true
]

{ #category : 'as yet unclassified' }
ShipState >> playTurnFor: aSpaceShip with: aDiceRoll in: aGame [

	aGame move: aSpaceShip after: aDiceRoll.
	"^self"
]

{ #category : 'initialization' }
ShipState >> setFreeByCard [

	^ self
]
