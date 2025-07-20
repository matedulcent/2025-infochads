Class {
	#name : 'HyperGravityTest',
	#superclass : 'PowerCellInteractionTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
HyperGravityTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

    self
        should: anErrorBlock
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: (error messageText) equals:
                errorMessage ]
]

{ #category : 'tests' }
HyperGravityTest >> testWhenABoardIsCreatedThenItCanCreateAnUnlimitedNumberOfHyperGravityCellsWithIndividualNumbers [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 10 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 0. 0. 100. 1. 100. 0. 1. 30.
		                     1. 0. 3. 4. 6. 10. 3. 2. 4 }. " 3. 4. 6. 10. 3. 2. 4."
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
	self assert: (aGame positionOf: 1) equals: 11
]

{ #category : 'tests' }
HyperGravityTest >> testWhenASpaceShipIsLockedInHyperGravityAndUsesFreedomThenNothingHappens [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 10 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 0. 0. 100. 1. 10. 0. 1. 10. 1. 0. 2 }.
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
	aGame use: FreedomCard new on: 1.
	self assert: (aGame positionOf: 1) equals: 11.
	self assert: (aGame isLockedUpInCell: 1)
]

{ #category : 'tests' }
HyperGravityTest >> testWhenShipHasToRollADiceHigherThatTheMaximumProvidedByDiceThenCreationFails [

	| aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 10. 3 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 0. 0. 100. 1. 100. 0. 1. 30.
		                     1. 0. 11 }. "3"
	aConfigureDiceSet setMaximumValueAs: 10.

	self
		should: [
			Board
				withSize: 100
				composedOf: (WormHole startingAt: 1 endingAt: 1)
				playedWith: (OrderedCollection with: WhiteCard new)
				andACellConfiguration: aConfigureDiceSet ]
		raise: Error
		withMessageText:
		'The values to escape de Hyper Gravity Cell must be under the maximum tossing value'
]

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

{ #category : 'tests' }
HyperGravityTest >> testWhenShipMovesToHyperGravityCellAndRollsTheRightNumberToEscapeThenItEscapes [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 10. 3 }.
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
	self assert: (aGame positionOf: 1) equals: 14.
]

{ #category : 'tests' }
HyperGravityTest >> testWhenTheHyperGravityCellWasLastActivatedAndTheRepeatIsPlayedThenItTrapsTheShipInItsPlaceUntilItThrowsTheEscapeValue [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 49. 20 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 0. 0. 0. 100. 0. 100. 0. 1. 30.
		                     1. 0. 3. 3 }. "3"
	aConfigureDiceSet setMaximumValueAs: 10.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {
					           RepeatCard new.
					           WhiteCard new.
					           RepeatCard new })
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 2.

	aGame start.
	aGame use: (RepeatCard withObjective: 1) on: 2.

	self assert: (aGame positionOf: 1) equals: 50.
	self assert: (aGame isLockedUpInCell: 1)
]
