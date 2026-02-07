Class {
	#name : 'PowerJailCell',
	#superclass : 'PowerCellInteractionTest',
	#instVars : [
		'game'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
PowerJailCell >> gameAndBoardWithDice: aDice [

	| aConfigureDiceSet |
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 0. 100. 0. 100. 0. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }.
	aConfigureDiceSet setMaximumValueAs: 10.
	board := Board
		         withSize: 100
		         composedOf: (WormHole startingAt: 1 endingAt: 1)
		         playedWith: (CardDeck withCards: {  })
		         andACellConfiguration: aConfigureDiceSet.
	game := Game
		        playedIn: board
		        by: 1
		        throwing: aDice
		        wonAfter: 1
]

{ #category : 'tests' }
PowerJailCell >> testWhenShipMovesToJailCellAndDoesntRollTheMaximumValueThenItDoesntMove [

	self gameAndBoardWithDice: (RiggedDice new initializeWith: { 10. 1 }).

	game start.
	self assert: (game positionOf: 1) equals: 11
]

{ #category : 'tests' }
PowerJailCell >> testWhenShipMovesToJailCellAndRollsTheMaximumValueThenItMoves [

	self gameAndBoardWithDice:
		(RiggedDice new initializeWith: { 10. 10 }).

	game start.
	self assert: (game positionOf: 1) equals: 21
]
