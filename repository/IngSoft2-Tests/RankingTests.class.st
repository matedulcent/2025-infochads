Class {
	#name : 'RankingTests',
	#superclass : 'WinningConditionTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
RankingTests >> setUp [

	super setUp.
	aBoard := Board
		          withSize: 11
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (CardDeck withCards: {  })
		          andACellConfiguration: {  }
]

{ #category : 'tests' }
RankingTests >> testWhenGameIsNotOverThereIsNoRanking [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 3 }.

	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame getRanking equals: {  }
]

{ #category : 'tests' }
RankingTests >> testWhenGameIsOverAndShip1WinsAndShip2IsSecond [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 6. 9 }.

	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame isOver.
	self assert: aGame getRanking equals: { 1. 2 }
]

{ #category : 'tests' }
RankingTests >> testWhenGameIsOverAndShip1WinsAndShip3IsSecondAndShip2IsThird [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 3. 6 }.

	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame isOver.
	self assert: aGame getRanking equals: { 1. 3. 2 }
]

{ #category : 'tests' }
RankingTests >> testWhenGameIsOverAndSpaceShip2Wins [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 3. 9 }.

	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame isOver.
	self assert: aGame getRanking first equals: 2
]

{ #category : 'tests' }
RankingTests >> testWhenGameIsOverAndWinnerIsShip1 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 6 }.

	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame isOver.
	self assert: aGame getRanking first equals: 1
]

{ #category : 'tests' }
RankingTests >> testWhenGameIsOverInformsSpaceShipsPositionAndWhichLap [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 6 }.

	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame isOver.
	self assert: (aGame positionOf: 1) equals: 11.
	self assert: (aGame lapOf: 1) equals: 1.
	self assert: (aGame positionOf: 2) equals: 3.
	self assert: (aGame lapOf: 2) equals: 0
]

{ #category : 'tests' }
RankingTests >> testWhenGameThereAre4ShipsTheRankingShowsAllTheShips [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 3. 7. 7 }.

	aGame := Game
		         playedIn: aBoard
		         by: 4
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame isOver.
	self assert: aGame getRanking equals: { 1. 4. 3. 2 }
]
