Class {
	#name : 'SpaceShip',
	#superclass : 'Object',
	#instVars : [
		'shield',
		'spaceShipID',
		'cards',
		'state',
		'skipState',
		'boost'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpaceShip class >> itMustHaveAnID: anId [

	(anId = '') ifTrue: [
		Error signal: 'The ship must be identifiable.' ]
]

{ #category : 'as yet unclassified' }
SpaceShip class >> itMustHaveThree: aShield [

	(aShield isInteger and: [ aShield = 3 ]) ifFalse: [
		Error signal: 'The ship must initialize with 3 shield.' ]
]

{ #category : 'as yet unclassified' }
SpaceShip class >> with: anId startingWith: aCard and: anotherCard with: aShield [

	self itMustHaveThree: aShield.
	self itMustHaveAnID: anId.

	^ self new initializeWith: aShield indentifiedBy: anId andHolding: aCard and: anotherCard
]

{ #category : 'adding' }
SpaceShip >> addA: aCard [

	cards add: aCard
]

{ #category : 'as yet unclassified' }
SpaceShip >> assertAndRemoveIfItHas: aCard [

	| someCard |
	someCard := cards
		            detect: [ :card | card class = aCard class ]
		            ifNone: [
		            Error signal: 'The card is not in the ships deck' ].

	cards remove: someCard
]

{ #category : 'shield' }
SpaceShip >> canBattle [

	^ state canBattleWithShield: shield
]

{ #category : 'states' }
SpaceShip >> changeStateToLockedUpAndNeeds: aValueToEscape [

	state := LockedUp withValue: aValueToEscape.
]

{ #category : 'states' }
SpaceShip >> changeStateToRetainedAndNeeds: aValueToEscape [

	state := Retained withValue: aValueToEscape.
]

{ #category : 'as yet unclassified' }
SpaceShip >> decrementBooster [

	boost := boost - 1
]

{ #category : 'shield' }
SpaceShip >> getShield [
	"needed for testing"
	^ shield
]

{ #category : 'getters' }
SpaceShip >> id [

	^ spaceShipID
]

{ #category : 'as yet unclassified' }
SpaceShip >> incrementBooster [

	boost := boost + 1
]

{ #category : 'initialization' }
SpaceShip >> initializeWith: aShield indentifiedBy: anId andHolding: aCard and: anotherCard [

	spaceShipID := anId.
	shield := 3.
	cards := OrderedCollection withAll: {
			         aCard.
			         anotherCard }.

	state := Free new.
	skipState := NoSkip withNext: NoSkip.
	boost := 0
]

{ #category : 'states' }
SpaceShip >> isImprisionedByTossing: aDiceRoll on: aGame [

	state playTurnFor: self with: aDiceRoll in: aGame
]

{ #category : 'states' }
SpaceShip >> isLockedUp [
	"needed for testing"
	^ state isLockedUp
]

{ #category : 'shield' }
SpaceShip >> loseShield [

	shield := shield - 1.
	shield = 0 ifTrue: [
		self skipState: (SkipForSkipping new initializeWithNext:
				 (SkipForShields new initializeWithNext: NoSkip new)) ]
]

{ #category : 'shield' }
SpaceShip >> rechargeShields [

	shield = 3 ifTrue: [
		Error signal: 'The Shield is already full, it cant be recharged.' ].
	shield := 3
]

{ #category : 'accessing' }
SpaceShip >> skipState: aSkipState [

	skipState := aSkipState
]

{ #category : 'accessing' }
SpaceShip >> state [

	^ state
]

{ #category : 'accessing' }
SpaceShip >> state: aState [

	state := aState
]

{ #category : 'as yet unclassified' }
SpaceShip >> willPlayByTossing: aDiceRoll on: aGame [

	| roll |
	roll := aDiceRoll + boost.

	aDiceRoll = 0 ifTrue: [
		self skipState: (SkipForShields new initializeWithNext: NoSkip new) ].

	skipState playTurnFor: self with: roll in: aGame
]
