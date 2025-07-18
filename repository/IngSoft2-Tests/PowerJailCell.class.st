Class {
	#name : 'PowerJailCell',
	#superclass : 'PowerCellInteractionTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PowerJailCell >> testWhenShipMovesToJailCellAndDoesntRollTheMaximumValueThenItDoesntMove [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 10. 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 0. 100. 0. 100. 0. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }.
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
]

{ #category : 'tests' }
PowerJailCell >> testWhenShipMovesToJailCellAndRollsTheMaximumValueThenItMoves [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 10. 10 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 0. 100. 0. 100. 0. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }.
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
	self assert: (aGame positionOf: 1) equals: 21.
]
