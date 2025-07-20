Class {
	#name : 'DoubleTurnCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DoubleTurnCardTest >> testWhenThereAre3SpaceShipsAndOneDoubleTurnAndOneRedoCardArePlayedThenTheNextSpaceShipToMovePlaysFourTimes [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           DoubleCard new.
					           RedoCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 1. 1. 1. 1. 10 })
		         wonAfter: 1.

	aGame use: DoubleCard new on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame positionOf: 2) equals: 11.
	self assert: (aGame positionOf: 1) equals: 5
]

{ #category : 'tests' }
DoubleTurnCardTest >> testWhenThereAre3SpaceShipsAndOneDoubleTurnCardIsPlayedThenTheNextSpaceShipToMovePlaysTwice [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           DoubleCard new.
					           WhiteCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 1. 2 })
		         wonAfter: 1.

	aGame use: DoubleCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 1) equals: 4
]

{ #category : 'tests' }
DoubleTurnCardTest >> testWhenThereAre3SpaceShipsAndOneDoubleTurnCardIsPlayedThenTheNextSpaceShipToMovePlaysTwiceAndTheRestPlayAfter [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           DoubleCard new.
					           WhiteCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 1. 2. 10. 11. })
		         wonAfter: 1.

	aGame use: DoubleCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 12.
	self assert: (aGame positionOf: 2) equals: 11.
	self assert: (aGame positionOf: 1) equals: 4
]

{ #category : 'tests' }
DoubleTurnCardTest >> testWhenThereAre3SpaceShipsAndTwoDoubleTurnCardArePlayedThenTheNextSpaceShipToMovePlaysFourTimes [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           DoubleCard new.
					           DoubleCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 1. 1. 1. 1. 10 })
		         wonAfter: 1.

	aGame use: DoubleCard new on: 1.
	aGame use: DoubleCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 1.
	self assert: (aGame positionOf: 2) equals: 11.
	self assert: (aGame positionOf: 1) equals: 5
]
