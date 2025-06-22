Class {
	#name : 'CellPlacement',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'rawCellDistribution'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
CellPlacement >> addNormalCellAtBeguiningAndEndOfBoard: netCellDistibution [

	| safeCell |
	safeCell := Cell has: NoEffect new.
	netCellDistibution at: 1 put: safeCell.
	netCellDistibution at: boardSize put: safeCell.
	^ netCellDistibution
]

{ #category : 'creation' }
CellPlacement >> atomicBombCellsWithProbabilities: aProbability and: aDesplacement [

	| newCells |
	newCells := (1 to: aProbability) collect: [ :cell |
		            Cell has:
			            (AtomicBombEffect with: aDesplacement) ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> blackHoleCellsWithProbabilities: aProbability andDesplacemets: aDesplacement [

	| newCells |
	newCells := (1 to: aProbability) collect: [ :cell |
		            Cell has:
			            (BlackHoleEffect withBackTrack: aDesplacement) ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'as yet unclassified' }
CellPlacement >> calculateRelationBetween: aParsecValue and: aLightYearValue [

	| result |
	result := aParsecValue + aLightYearValue.

	(result = aParsecValue or: result = aLightYearValue) ifTrue: [
		^ result // boardSize ].

	aLightYearValue // aParsecValue = 3 ifFalse: [
		Error signal:
			'The ratio 1 parsec = 3 light years is not being respected' ].

	^ aParsecValue // boardSize
]

{ #category : 'as yet unclassified' }
CellPlacement >> cardCellsWithProbabilities: aProbability picking: aConfigDice from: aDeckOfCards [

	| newCells numberOfCards cards |
	numberOfCards := aConfigDice toss.

	cards := OrderedCollection new.
	1 to: numberOfCards do: [ :card |
		card
			ifNil: [ WhiteCard create ]
			ifNotNil: [ cards addFirst: aDeckOfCards removeLast ] ].

	newCells := (1 to: aProbability) collect: [ :cell |
		            Cell has: (CardEffect with: cards deepCopy) ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'as yet unclassified' }
CellPlacement >> createBoardWith: aConfigDice withComplementary: aDeckOfCards And: aBoardSize [

	boardSize := aBoardSize.
	rawCellDistribution := OrderedCollection new.
	aConfigDice isEmpty ifTrue: [ ^ rawCellDistribution ].
	self generateUniverseWith: aConfigDice andA: aDeckOfCards.
	^ self extractSample
]

{ #category : 'as yet unclassified' }
CellPlacement >> extractSample [

	| netCellDistibution |
	
	netCellDistibution := self randomCellPicking.

	^ self addNormalCellAtBeguiningAndEndOfBoard: netCellDistibution
]

{ #category : 'as yet unclassified' }
CellPlacement >> generateUniverseWith: aConfigDice andA: aDeckOfCards [

	| probabilities |
	probabilities := self obtainProbabilities: aConfigDice.
	self theProbabilitiesMustSum100: probabilities.
	self
		cardCellsWithProbabilities: (probabilities at: 7)
		picking: aConfigDice from: aDeckOfCards.
	self normalCellsWithProbabilitites: (probabilities at: 1).
	self
		blackHoleCellsWithProbabilities: (probabilities at: 2)
		andDesplacemets: 4.
	self
		hyperSpaceJumpCellsWithProbabilities: (probabilities at: 3)
		andDesplacements: 4.
	self
		hyperJumpCellsWithProbabilites: (probabilities at: 4)
		andParsecValue: aConfigDice toss
		andLightYearValue: aConfigDice toss
		andJumpList: aConfigDice.
	self atomicBombCellsWithProbabilities: (probabilities at: 5) and: 0.
	self
		moonWalkCellsWithProbabilites: (probabilities at: 6)
		andDisplacements: aConfigDice
]

{ #category : 'creation' }
CellPlacement >> hyperJumpCellsWithProbabilites: aProbability andParsecValue: aParsecValue andLightYearValue: aLightYearValue andJumpList: aConfigDice [

	| jumps amountOfJumps newCells relation |
	amountOfJumps := aConfigDice toss.
	jumps := OrderedCollection new: amountOfJumps.
	
	relation := self calculateRelationBetween: aParsecValue and: aLightYearValue.

	1 to: amountOfJumps do: [ :jump | jumps add: aConfigDice toss ].


	newCells := (1 to: aProbability) collect: [ :cell |
		            Cell has:
			            (HyperJumpEffect
				             with: relation
				             andParsec: jumps) ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> hyperSpaceJumpCellsWithProbabilities: aProbability andDesplacements: aDesplacement [ 

	| newCells |
	newCells := (1 to: aProbability) collect: [ :cell |
		            Cell has: (HyperSpaceJumpEffect
				             with: aDesplacement) ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> moonWalkCellsWithProbabilites: aProbability andDisplacements: aConfigDice [

	| newCells stepBackwards allDisplacements repeat |
	stepBackwards := self obtainNextDisplacement: aConfigDice.
	repeat := boardSize.

	allDisplacements := Array streamContents: [ :particular |
		                    repeat timesRepeat: [
			                    particular nextPutAll: stepBackwards ] ].

	newCells := (1 to: aProbability) collect: [ :particular |
		            Cell has:
			            (MoonWalkEffect with: (allDisplacements at: particular)) ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> normalCellsWithProbabilitites: aProbability [

	1 to: aProbability do: [ :cell |
	rawCellDistribution add: (Cell has: NoEffect new) ]
]

{ #category : 'as yet unclassified' }
CellPlacement >> obtainNextDisplacement: aConfigDice [

	| results throw |
	results := OrderedCollection new.
	throw := aConfigDice toss.
	[ throw = 0 or: (throw = -1) ] whileFalse: [
		results add: throw.
		throw := aConfigDice toss ].

	^ results
]

{ #category : 'as yet unclassified' }
CellPlacement >> obtainProbabilities: aConfigureDice [

	^ (1 to: 7) collect: [ :effect | aConfigureDice toss ]
]

{ #category : 'as yet unclassified' }
CellPlacement >> randomCellPicking [

    ^ (1 to: boardSize) collect: [ :cell |
          rawCellDistribution at: ((1 to: 100) atRandom) ]
]

{ #category : 'as yet unclassified' }
CellPlacement >> theProbabilitiesMustSum100: aProbability [

	(aProbability sum: [ :proba | proba ]) = 100 ifFalse: [
		Error signal: 'The probabilites dont sum 100.' ]
]
