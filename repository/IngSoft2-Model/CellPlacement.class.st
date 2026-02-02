Class {
	#name : 'CellPlacement',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'rawCellDistribution',
		'sample'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
CellPlacement >> addNormalCellAtBeginningAndEndOfBoard: netCellDistribution [

	| mutable |
	mutable := netCellDistribution asOrderedCollection.

	mutable
		addFirst: (Cell has: [ Normal new ]);
		addLast: (Cell has: [ Normal new ]).

	^ mutable
]

{ #category : 'asserting' }
CellPlacement >> assertLightYears: aLightYearValue respectParsecs: aParsecValue [

	aLightYearValue ~= (aParsecValue * 3) ifTrue: [
		Error signal:
			'The ratio 1 parsec = 3 light years is not being respected' ]
]

{ #category : 'creation' }
CellPlacement >> atomicBombCellsWithProbabilities: aProbability [

	| newCells |
	newCells := (1 to: aProbability) collect: [ :cell |
		            Cell has: [ AtomicBombEffect new ] ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> blackHoleCellsWithProbabilities: aProbability andDesplacemets: aDesplacement [

	| newCells |
	newCells := (1 to: aProbability) collect: [ :cell |
		            Cell has: [
			            BlackHoleEffect withBackTrack: aDesplacement ] ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'as yet unclassified' }
CellPlacement >> calculateRelationBetween: aParsecValue and: aLightYearValue [

	| result |
	result := aParsecValue + aLightYearValue.

	self equal: aLightYearValue to: aParsecValue.

	(result = aParsecValue or: result = aLightYearValue) ifTrue: [
		^ result // boardSize ].

	self assertLightYears: aLightYearValue respectParsecs: aParsecValue.

	^ aParsecValue // boardSize
]

{ #category : 'as yet unclassified' }
CellPlacement >> cardCellsWithProbabilities: aProbability [

	| newCells |
	newCells := (1 to: aProbability) collect: [ :cell |
		            Cell has: [ CardEffect new ] ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'as yet unclassified' }
CellPlacement >> createBoardWith: aConfigDice withComplementary: aBoardSize [

	boardSize := aBoardSize - 2. "to fill the first and last cells with normal effect"
	rawCellDistribution := OrderedCollection new.

	aConfigDice isEmpty ifTrue: [ ^ rawCellDistribution ].

	self generateUniverseWith: aConfigDice.

	self extractSample.

	^ sample
]

{ #category : 'as yet unclassified' }
CellPlacement >> equal: aLightYearValue to: aParsecValue [

	aParsecValue = aLightYearValue ifTrue: [
		Error signal:
			'The ratio 1 parsec = 3 light years is not being respected' ]
]

{ #category : 'as yet unclassified' }
CellPlacement >> extractSample [

	| netCellDistibution |
	netCellDistibution := self randomCellPicking.

	sample := self addNormalCellAtBeginningAndEndOfBoard:
		          netCellDistibution
]

{ #category : 'as yet unclassified' }
CellPlacement >> generateUniverseWith: aConfigDice [

	| probabilities |
	probabilities := self obtainProbabilities: aConfigDice.
	self theProbabilitiesMustSum100: probabilities.
	self cardCellsWithProbabilities: (probabilities at: 7).
	self normalCellsWithProbabilitites: (probabilities at: 1).
	self
		blackHoleCellsWithProbabilities: (probabilities at: 2)
		andDesplacemets: -4.
	self
		hyperSpaceJumpCellsWithProbabilities: (probabilities at: 3)
		andDesplacements: 4.
	self
		hyperJumpCellsWithProbabilites: (probabilities at: 4)
		andParsecValue: aConfigDice toss
		andLightYearValue: aConfigDice toss
		andJumpList: aConfigDice.
	self atomicBombCellsWithProbabilities: (probabilities at: 5).
	self
		moonWalkCellsWithProbabilites: (probabilities at: 6)
		andDisplacements: aConfigDice.
	self
		jailCellsWithProbabilitites: (probabilities at: 8)
		and: aConfigDice maxValue.
	self
		hyperGravityCellsWithProbabilitites: (probabilities at: 9)
		andExitValues: aConfigDice
]

{ #category : 'as yet unclassified' }
CellPlacement >> hyperGravityCellsWithProbabilitites: aProbability andExitValues: aConfigDice [

	| newCells valuesToEscape allValuesToEscape repeat |
	valuesToEscape := self obtainFollowingDiceRolls: aConfigDice.
	self verify: valuesToEscape areUnder: aConfigDice maxValue.
	repeat := boardSize.

	allValuesToEscape := Array streamContents: [ :escapeValue |
		                     repeat timesRepeat: [
			                     escapeValue nextPutAll: valuesToEscape ] ].

	newCells := (1 to: aProbability) collect: [ :escapeValue |
		            Cell has: [ HyperGravityEffect with: (allValuesToEscape at: escapeValue) ] ].

	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> hyperJumpCellsWithProbabilites: aProbability andParsecValue: aParsecValue andLightYearValue: aLightYearValue andJumpList: aConfigDice [

	| jumps amountOfJumps newCells relation |
	amountOfJumps := aConfigDice toss.
	jumps := OrderedCollection new: amountOfJumps.

	relation := self
		            calculateRelationBetween: aParsecValue
		            and: aLightYearValue.

	1 to: amountOfJumps do: [ :jump | jumps add: aConfigDice toss ].


	newCells := (1 to: aProbability) collect: [ :cell |
		            Cell has: [
			            HyperJumpEffect with: relation andParsec: jumps ] ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> hyperSpaceJumpCellsWithProbabilities: aProbability andDesplacements: aDesplacement [

	| newCells |
	newCells := (1 to: aProbability) collect: [ :cell |
		            Cell has: [
			            HyperSpaceJumpEffect withForwardTrack: aDesplacement ] ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'as yet unclassified' }
CellPlacement >> jailCellsWithProbabilitites: aProbability and: anEscapeValue [

	| newCells |
	newCells := (1 to: aProbability) collect: [ :cell |
		            Cell has: [ 
			            JailEffect with: anEscapeValue ] ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> moonWalkCellsWithProbabilites: aProbability andDisplacements: aConfigDice [

	| newCells stepBackwards allDisplacements repeat |
	stepBackwards := self obtainFollowingDiceRolls: aConfigDice.
	repeat := boardSize.

	allDisplacements := Array streamContents: [ :particular |
		                    repeat timesRepeat: [
			                    particular nextPutAll: stepBackwards ] ].

	newCells := (1 to: aProbability) collect: [ :particular |
		            Cell has: [
			            MoonWalkEffect withBackTrack:
				            (allDisplacements at: particular) negated ] ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> normalCellsWithProbabilitites: aProbability [

	1 to: aProbability do: [ :cell |
	rawCellDistribution add: (Cell has: [ Normal new ]) ]
]

{ #category : 'as yet unclassified' }
CellPlacement >> obtainFollowingDiceRolls: aConfigDice [

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

	^ (1 to: 9) collect: [ :effect | aConfigureDice toss ]
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

{ #category : 'as yet unclassified' }
CellPlacement >> verify: valuesToEscape areUnder: limit [

	| valuesOverLimit |
	valuesOverLimit := valuesToEscape select: [ :value | value > limit ].

	valuesOverLimit ifNotEmpty: [
		Error signal:
			'The values to escape de Hyper Gravity Cell must be under the maximum tossing value' ]
]
