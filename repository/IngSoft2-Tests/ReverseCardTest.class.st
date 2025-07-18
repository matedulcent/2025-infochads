Class {
	#name : 'ReverseCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ReverseCardTest >> testWhenThereAre3SpaceShipsAndOneReverseAndOneRedoArePlayedThenTheyPlayInTheCorrectTurnOrder [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           ReverseCard new.
					           RedoCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.

	aGame use: ReverseCard new on: 1.
	aGame use:(RedoCard withFillOut: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 1) equals: 6
]

{ #category : 'tests' }
ReverseCardTest >> testWhenThereAre3SpaceShipsAndReverseCardIsPlayedThenTheyPlayInTheInverseTurnOrder [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: { ReverseCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.

	aGame use: ReverseCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 6.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 1) equals: 1.
]

{ #category : 'tests' }
ReverseCardTest >> testWhenThereAre3SpaceShipsAndTwoReverseCardArePlayedThenTheyPlayInTheCorrectTurnOrder [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           ReverseCard new.
					           ReverseCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 5 })
		         wonAfter: 1.

	aGame use: ReverseCard new on: 1.
	aGame use: ReverseCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 1) equals: 6
]
