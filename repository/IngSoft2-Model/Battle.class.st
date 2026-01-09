Class {
	#name : 'Battle',
	#superclass : 'Object',
	#instVars : [
		'spaceShip',
		'spaceShips',
		'positionManager',
		'board',
		'diceSet'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
Battle class >> between: aSpaceShip andOneOf: spaceShips with: positionManager on: board with: aDiceSet [

	^ self new
		  initializeBattleBetween: aSpaceShip
		  andOneOf: spaceShips
		  withPosition: positionManager
		  on: board
		  with: aDiceSet
]

{ #category : 'as yet unclassified' }
Battle >> battleBetween: aSpaceShip and: opponentShip [

	| throwSpaceShip throwOpponentShip |
	" In case of a draw, the defendant wins and the attacker gets loser penalties"
	throwOpponentShip := self mercenaryHelpTo: opponentShip.
	throwSpaceShip := self mercenaryHelpTo: aSpaceShip.

	throwSpaceShip <= throwOpponentShip 
		ifTrue: [ self lostBattle: aSpaceShip ]
		ifFalse: [ self lostBattle: opponentShip ]
]

{ #category : 'initialization' }
Battle >> initializeBattleBetween: aSpaceShip andOneOf: theSpaceShips withPosition: aPositionManager on: aBoard with: aDiceSet [

	spaceShip := aSpaceShip.
	spaceShips := theSpaceShips.
	positionManager := aPositionManager.
	board := aBoard.
	diceSet := aDiceSet.
	
	self lookForBattle: aSpaceShip
]

{ #category : 'as yet unclassified' }
Battle >> lookForBattle: aSpaceShip [

	| opponentShip |
	((positionManager at: aSpaceShip id) isPositionEqualTo:
		 (Position at: 1 withLaps: 0)) ifTrue: [ ^ self ].

	opponentShip := self obtainOponentShip: aSpaceShip.

	"(board manageCards the: opponentShip isMercenaryOf: aSpaceShip)
		ifTrue: [ ^ self ]."

	"opponentShip == aSpaceShip ifFalse: [
		self battleBetween: aSpaceShip and: opponentShip ]"
]

{ #category : 'as yet unclassified' }
Battle >> lostBattle: aSpaceShip [

	| mercenaries |
	self returnToBeguinning: aSpaceShip.

	aSpaceShip loseShield.

	mercenaries := board manageCards listOfMercenariesOf: aSpaceShip.
	
	self returnToBeguinningTheShips: mercenaries
]

{ #category : 'as yet unclassified' }
Battle >> mercenaryHelpTo: aSpaceShip [

	"| numberOfTosses throwSpaceShip |
	numberOfTosses := board manageCards numberOfMercenariesOf: aSpaceShip.

	throwSpaceShip := 0.
	1 to: numberOfTosses do: [ :mercenary |
	throwSpaceShip := throwSpaceShip + diceSet toss ].

	^ throwSpaceShip"
]

{ #category : 'as yet unclassified' }
Battle >> obtainOponentShip: aSpaceShip [

	| otherShips |
	otherShips := spaceShips reject: [ :ship | ship = aSpaceShip ].

	otherShips ifEmpty: [ ^ aSpaceShip ].

	^ otherShips
		  detect: [ :ship |
			  (( positionManager at: ship id) isPositionEqualTo:
				   (positionManager positions at: aSpaceShip id)) and: ship canBattle ]
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
		(spaceShips detect: [ :ship | ship id = shipId ]) loseShield ]
]
