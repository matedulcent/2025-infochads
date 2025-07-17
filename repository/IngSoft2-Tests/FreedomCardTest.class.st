Class {
	#name : 'FreedomCardTest',
	#superclass : 'SpeedCardTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
FreedomCardTest >> testWhenASpaceShipIsImprisionedAndDoesntPlayFreedomThenItStaysLockedUp [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 10. 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 0. 100. 1. 10. 0. 1. 1 }.
	aConfigureDiceSet setMaximumValueAs: 10.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           FreedomCard new.
					           WhiteCard new })
		          andACellConfiguration: aConfigureDiceSet.

	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 11.
	self assert: (aGame isLockedUp: 1)
]

{ #category : 'as yet unclassified' }
FreedomCardTest >> testWhenASpaceShipIsImprisionedThenTheFreedomCardFreesIt [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 10. 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 0. 100. 1. 10. 0. 1. 1 }.
	aConfigureDiceSet setMaximumValueAs: 10.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           FreedomCard new.
					           WhiteCard new })
		          andACellConfiguration: aConfigureDiceSet.

	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	aGame use: (FreedomCard new) on: 1.
	self assert: (aGame positionOf: 1) equals: 11.
	self deny: (aGame isLockedUp: 1)
]

{ #category : 'as yet unclassified' }
FreedomCardTest >> testWhenASpaceShipIsNotImprisionedAndPlayFreedomThenNothingHappens [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 10. 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 0. 0. 0. 0. 0. 0. 0. 1. 10. 0. 1. 1 }.
	aConfigureDiceSet setMaximumValueAs: 10.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           FreedomCard new.
					           WhiteCard new })
		          andACellConfiguration: aConfigureDiceSet.

	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	aGame use: (FreedomCard new) on: 1.
	self assert: (aGame positionOf: 1) equals: 12.
	self deny: (aGame isLockedUp: 1)
]
