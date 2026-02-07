Class {
	#name : 'Battle',
	#superclass : 'Object',
	#instVars : [
		'positionManager',
		'board',
		'diceSet',
		'turnManager',
		'game',
		'relations'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
Battle class >> between: aSpaceShip andOneOf: spaceShips with: positionManager on: board with: aDiceSet andIts: relationshipsWithMercenaries [

	^ self new
		  initializeBattleBetween: aSpaceShip
		  andOneOf: spaceShips
		  withPosition: positionManager
		  on: board
		  with: aDiceSet
		  andIts: relationshipsWithMercenaries
]

{ #category : 'comparing' }
Battle class >> in: aGame and: aTurnManager with: aPositionManager on: aBoard with: aDiceSet [

	^ self new
		  initializeIn: aGame
		  and: aTurnManager
		  with: aPositionManager
		  on: aBoard
		  with: aDiceSet
]

{ #category : 'as yet unclassified' }
Battle >> battleBetween: aSpaceShip and: anOpponentShip [

	| throwSpaceShip throwOpponentShip |
	" In case of a draw, the defendant wins and the attacker gets loser penalties"
	throwOpponentShip := self mercenaryHelpTo: anOpponentShip.
	throwSpaceShip := self mercenaryHelpTo: aSpaceShip.

	throwSpaceShip <= throwOpponentShip
		ifTrue: [ self lostBattle: aSpaceShip ]
		ifFalse: [ self lostBattle: anOpponentShip ].

	^ self
]

{ #category : 'as yet unclassified' }
Battle >> checkForCamaraderieBetween: aSpaceShip and: anOpponentShip [

	| mercenariesFromAShip mercenariesFromTheOpponentShip |
	mercenariesFromAShip := relations at: aSpaceShip id.
	mercenariesFromTheOpponentShip := relations at: anOpponentShip id.

	^ (mercenariesFromAShip includes: anOpponentShip id) or: [
		  mercenariesFromTheOpponentShip includes: aSpaceShip id ]
]

{ #category : 'initialization' }
Battle >> initializeIn: aGame and: aTurnManager with: aPositionManager on: aBoard with: aDiceSet [

	turnManager := aTurnManager.
	positionManager := aPositionManager.
	board := aBoard.
	diceSet := aDiceSet.
	game := aGame.
	relations := game obtainRelationsWithMercenaries.

	self lookForBattle: turnManager currentShipPlaying.
	^ self
]

{ #category : 'as yet unclassified' }
Battle >> lookForBattle: aSpaceShip [

	| anOpponentShip |
	((positionManager at: aSpaceShip id) isPositionEqualTo:
		 (Position at: 1 withLaps: 0)) ifTrue: [ ^ self ].
	anOpponentShip := self obtainOpponentShip: aSpaceShip .

	aSpaceShip = anOpponentShip ifTrue: [ ^ self ].

	(self checkForCamaraderieBetween: aSpaceShip and: anOpponentShip)
		ifTrue: [ ^ self ].

	self battleBetween: aSpaceShip and: anOpponentShip
]

{ #category : 'as yet unclassified' }
Battle >> lostBattle: aSpaceShip [

	self returnToBeguinning: aSpaceShip.

	aSpaceShip loseShield.

	self returnToBeguinningTheShips:
		(relations at: aSpaceShip id)
]

{ #category : 'as yet unclassified' }
Battle >> mercenaryHelpTo: aShip [

	| howManyExtraTosses totalToss |
	totalToss := 0.
	howManyExtraTosses := (relations at: aShip id) size.

	1 to: howManyExtraTosses + 1 do: [ :i |
	totalToss := totalToss + diceSet toss ].

	^ totalToss
]

{ #category : 'as yet unclassified' }
Battle >> obtainOpponentShip: aSpaceShip [

	| otherShips |
	otherShips := turnManager allShips reject: [ :ship |
		              ship = aSpaceShip ].

	otherShips ifEmpty: [ ^ aSpaceShip ].

	^ otherShips
		  detect: [ :ship |
			  ((positionManager at: ship id) isPositionEqualTo:
				   (positionManager positions at: aSpaceShip id)) and:
				  ship canBattle ]
		  ifNone: [ aSpaceShip ]
]

{ #category : 'as yet unclassified' }
Battle >> returnToBeguinning: aSpaceShip [

	positionManager sumAt: aSpaceShip id with: (Position
			 at:
			 (positionManager positions at: aSpaceShip id) position negated + 1
			 withLaps: 0)
]

{ #category : 'as yet unclassified' }
Battle >> returnToBeguinningTheShips: mercenaries [

	mercenaries do: [ :shipId |
		positionManager sumAt: shipId with: (Position
				 at: (positionManager positions at: shipId) position negated + 1
				 withLaps: 0).
		(turnManager allShips detect: [ :ship | ship id = shipId ])
			loseShield ]
]
