Class {
	#name : 'SkipCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SkipCardTest >> testWhenThereAre3SpaceShipsAndOneSkipAndOneRedoArePlayedThenTheNextTwoPlayersLoseItsTurns [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           SkipCard new.
					           RedoCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 1 })
		         wonAfter: 1.

	aGame use: SkipCard new on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 2.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 1) equals: 1
]

{ #category : 'tests' }
SkipCardTest >> testWhenThereAre3SpaceShipsAndSkipCardIsPlayedThenTheNextSpaceShipToPlayIsSkipped [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: { SkipCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 1. 2. })
		         wonAfter: 1.

	aGame use: SkipCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 3.
	self assert: (aGame positionOf: 2) equals: 2.
	self assert: (aGame positionOf: 1) equals: 1.
]

{ #category : 'tests' }
SkipCardTest >> testWhenThereAre3SpaceShipsAndTwoSkipCardsArePlayedThenTheNext2SpaceShipToPlayIsSkipped [

	| aGame aBoard |
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           SkipCard new.
					           SkipCard new })
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: (RiggedDice new initializeWith: { 1. })
		         wonAfter: 1.

	aGame use: SkipCard new on: 1.
	aGame use: SkipCard new on: 1.
	aGame start.

	self assert: (aGame positionOf: 3) equals: 2.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 1) equals: 1
]
