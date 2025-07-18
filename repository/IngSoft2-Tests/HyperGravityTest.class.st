Class {
	#name : 'HyperGravityTest',
	#superclass : 'PowerCellInteractionTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperGravityTest >> testWhenShipMovesToHyperGravityCellAndDoesntRollTheRightNumberToEscapeThenItDoesntMove [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 10. 10 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 0. 0. 100. 1. 100. 0. 1. 30.
		                     1. 0. 3 }. "3"
	aConfigureDiceSet setMaximumValueAs: 10.

	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection with: WhiteCard new)
		          andACellConfiguration: aConfigureDiceSet.

	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 11.
	self assert: (aGame isLockedUpInCell: 1)
]
