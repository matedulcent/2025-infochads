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

{ #category : 'tests' }
FreedomCardTest >> testWhenShipPlaysFreedomAndAndAnotherShipPlaysFreedomWhenBeingInJailThenItIsSetFree [

	| aGame aDiceSet aBoard aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 10. 11. 1. 1. }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 0. 100. 0. 100. 0. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }.
	aConfigureDiceSet setMaximumValueAs: 10.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           WhiteCard new.
					           RedoCard new.
					           FreedomCard new.
					           WhiteCard new })
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.
	
	aGame start.
	aGame use: (FreedomCard new) on: 1.
	aGame use: (RedoCard withFillOut: 1) on: 2.

	self assert: (aGame positionOf: 1) equals: 11.
	self assert: (aGame positionOf: 2) equals: 12.
	self deny: (aGame isLockedUp: 2).
]
