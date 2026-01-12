Class {
	#name : 'Battle',
	#superclass : 'Object',
	#instVars : [
		'spaceShip',
		'spaceShips',
		'positionManager',
		'board',
		'diceSet',
		'relationWithMercenaries'
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

{ #category : 'as yet unclassified' }
Battle >> battleBetween: aSpaceShip and: anOpponentShip [

	| throwSpaceShip throwOpponentShip |
	" In case of a draw, the defendant wins and the attacker gets loser penalties"
	throwOpponentShip := self mercenaryHelpTo: anOpponentShip.
	throwSpaceShip := self mercenaryHelpTo: aSpaceShip.

	throwSpaceShip <= throwOpponentShip 
		ifTrue: [ self lostBattle: aSpaceShip ]
		ifFalse: [ self lostBattle: anOpponentShip ]
]

{ #category : 'as yet unclassified' }
Battle >> checkForCamaraderieBetween: aSpaceShip and: anOpponentShip [

	| mercenariesFromAShip mercenariesFromTheOpponentShip |
	mercenariesFromAShip := relationWithMercenaries at: aSpaceShip id.
	mercenariesFromTheOpponentShip := relationWithMercenaries at:
		                                  anOpponentShip id.

	^ (mercenariesFromAShip includes: anOpponentShip id) or: [
		  mercenariesFromTheOpponentShip includes: aSpaceShip id ]
]

{ #category : 'initialization' }
Battle >> initializeBattleBetween: aSpaceShip andOneOf: theSpaceShips withPosition: aPositionManager on: aBoard with: aDiceSet andIts: relationshipsWothMercenaries [

	spaceShip := aSpaceShip.
	spaceShips := theSpaceShips.
	positionManager := aPositionManager.
	board := aBoard.
	diceSet := aDiceSet.
	relationWithMercenaries := relationshipsWothMercenaries.
	
	self lookForBattle: aSpaceShip
]

{ #category : 'as yet unclassified' }
Battle >> lookForBattle: aSpaceShip [

	| anOpponentShip |
	((positionManager at: aSpaceShip id) isPositionEqualTo:
		 (Position at: 1 withLaps: 0)) ifTrue: [ ^ self ].
	anOpponentShip := self obtainOpponentShip: aSpaceShip.
	"correct"
	aSpaceShip = anOpponentShip ifTrue: [ ^ self ].
	"the oponent ship musnt be mercenary"
	(self checkForCamaraderieBetween: aSpaceShip and: anOpponentShip)
		ifTrue: [ ^ self ].
	""
	self battleBetween: aSpaceShip and: anOpponentShip
]

{ #category : 'as yet unclassified' }
Battle >> lostBattle: aSpaceShip [
	"| mercenaries |"

	self returnToBeguinning: aSpaceShip.

	aSpaceShip loseShield.

	"mercenaries := board manageCards listOfMercenariesOf: aSpaceShip."

	self returnToBeguinningTheShips:
		(relationWithMercenaries at: aSpaceShip id)
]

{ #category : 'as yet unclassified' }
Battle >> mercenaryHelpTo: aShip [

	| howManyExtraTosses totalToss |
	totalToss := 0.
	howManyExtraTosses := (relationWithMercenaries at: aShip id) size.

	1 to: howManyExtraTosses + 1 do: [ :i |
	totalToss := totalToss + diceSet toss ].

	^ totalToss
]

{ #category : 'as yet unclassified' }
Battle >> obtainOpponentShip: aSpaceShip [

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
