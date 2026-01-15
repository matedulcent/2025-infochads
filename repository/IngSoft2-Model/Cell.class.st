Class {
	#name : 'Cell',
	#superclass : 'Object',
	#instVars : [
		'effect',
		'effectPrototype'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Cell class >> has: anEffectPrototype [

	^ self new initializeWith: anEffectPrototype
]

{ #category : 'as yet unclassified' }
Cell >> affectOnly: aSpaceShip thatIsPlacedIn: spaceShipPositions [
	"borrar"
	spaceShipPositions
		at: aSpaceShip id
		put: ((spaceShipPositions at: aSpaceShip id) replacePositionWith:
				 (effect applyToSpaceShip:
					  (spaceShipPositions at: aSpaceShip id) position))
]

{ #category : 'as yet unclassified' }
Cell >> affectTheShieldOf: aSpaceShip [
	"borrar"
	effect damageShield ifTrue: [ aSpaceShip loseShield ]
]

{ #category : 'as yet unclassified' }
Cell >> affectTheShieldOfAll: spaceShips [
	"borrar"
	effect damageAllShields ifTrue: [
		spaceShips do: [ :ship | ship loseShield ] ]
]

{ #category : 'as yet unclassified' }
Cell >> applyTo: aShip in: aGame [

	| anEffect |
	anEffect := effectPrototype value: aShip value: aGame.
	
	anEffect applyOn: aShip in: aGame
]

{ #category : 'as yet unclassified' }
Cell >> dontAffect: aSpaceShip butInstedAffectAll: spaceShips thatArePlacedIn: spaceShipPositions [
	"borrar"
	spaceShips do: [ :ship |
		ship == aSpaceShip ifFalse: [
			spaceShipPositions
				at: ship id
				put: ((spaceShipPositions at: ship id) replacePositionWith:
						 (effect applyToAllSpaceShips:
							  (spaceShipPositions at: ship id) position)) ] ]
]

{ #category : 'accessing' }
Cell >> effect [
	"borrar"
	^ effect 
]

{ #category : 'as yet unclassified' }
Cell >> giveCardsTo: aSpaceShip [
	"borrar"
	| card |
	card := effect grabCard.

	(card class = WhiteCard new class) ifFalse: [ aSpaceShip addA: card ]
]

{ #category : 'as yet unclassified' }
Cell >> imprison: aSpaceShip [
	"borrar"
	"Jail"
	effect imprison: aSpaceShip.

	"HyperGravity"
	effect lock: aSpaceShip
]

{ #category : 'initialization' }
Cell >> initializeWith: anEffectPrototype [
	
	effectPrototype := anEffectPrototype
]

{ #category : 'as yet unclassified' }
Cell >> takeActionOver: aSpaceShip or: spaceShips thatArePlaced: spaceShipPositions [
	"refactorizar y borrar"
	self affectOnly: aSpaceShip thatIsPlacedIn: spaceShipPositions.

	self
		dontAffect: aSpaceShip
		butInstedAffectAll: spaceShips
		thatArePlacedIn: spaceShipPositions.

	self affectTheShieldOf: aSpaceShip.

	self affectTheShieldOfAll: spaceShips.

	self giveCardsTo: aSpaceShip.

	self imprison: aSpaceShip
]
