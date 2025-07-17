Class {
	#name : 'LightYearsTests',
	#superclass : 'PowerCellInteractionTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LightYearsTests >> testWhenTheDistanceIsExpresedInLightYearsThenTheJumpsAreExpresedInLightYears [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 0. 0. 0. 0. 300. 3. 90. 60. 30.
		                     6. 4. 2. 5. 7 }. "15 10 5"
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection with: WhiteCard new)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 17.

]

{ #category : 'tests' }
LightYearsTests >> testWhenTheDistanceIsExpresedInParsecsAndLightYearsAndDontRelateWithRatio1ParsecEquals3LightYearsThenIsInvalid [

	| aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 0. 0. 100. 200. 3. 30. 20.
		                     10. 6. 4. 2. 5. 7 }. "15 10 5"

	self
		should: [
			Board
				withSize: 50
				composedOf: (WormHole startingAt: 1 endingAt: 1)
				playedWith: (OrderedCollection with: WhiteCard new)
				andACellConfiguration: aConfigureDiceSet ]
		raise: Error
		withMessageText:
		'The ratio 1 parsec = 3 light years is not being respected'
]

{ #category : 'tests' }
LightYearsTests >> testWhenTheDistanceIsExpresedInParsercsThenTheJumpsExpresedInParsecs [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 0. 0. 0. 100. 0. 3. 30. 20. 10.
		                     6. 4. 2. 5. 7 }. "15 10 5"
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection with: WhiteCard new)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 17.

]

{ #category : 'tests' }
LightYearsTests >> testWhenTheDistanceNeitherInParsecsOrLightYearsThenIsInvalid [

	| aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 0. 0. 0. 0. 0. 3. 30. 20. 10.
		                     6. 4. 2. 5. 7 }.

	self
		should: [
			Board
				withSize: 50
				composedOf: (WormHole startingAt: 1 endingAt: 1)
				playedWith: (OrderedCollection with: WhiteCard new)
				andACellConfiguration: aConfigureDiceSet ]
		raise: Error
		withMessageText:
		'The ratio 1 parsec = 3 light years is not being respected'
]

{ #category : 'tests' }
LightYearsTests >> testWhenTheDistanceOfTheGameIsExpresedInLightYearsAndParsecsThenTheJumpsAreExpresedInParsecs [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 0. 0. 0. 100. 300. 3. 30. 20. 10.
		                     6. 4. 2. 5. 7 }. "15 10 5"
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          playedWith: (OrderedCollection with: WhiteCard new)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 17.

]
