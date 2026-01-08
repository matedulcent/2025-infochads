Class {
	#name : 'SpaceShip',
	#superclass : 'Object',
	#instVars : [
		'shield',
		'spaceShipID',
		'loseTurn',
		'cards',
		'helperOf',
		'pendingCards',
		'helpingOthers',
		'state',
		'skipState'
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

{ #category : 'cards' }
SpaceShip >> a: pickedCardFromCards isTheSameAs: pickedCardFromPending [

	pickedCardFromCards == pickedCardFromPending ifTrue: [
		Error signal: 'The card is not in the ships deck' ]
]

{ #category : 'cards' }
SpaceShip >> addA: card [

	cards add: card
]

{ #category : 'shield' }
SpaceShip >> canBattle [
	
	^ shield > 0 and: loseTurn = 0
]

{ #category : 'as yet unclassified' }
SpaceShip >> changeSkippingStateTo: nextSkipState [

	skipState := nextSkipState 
]

{ #category : 'states' }
SpaceShip >> changeStateToFree [

	state := Free new
]

{ #category : 'states' }
SpaceShip >> changeStateToFreeByCard [

	state := state setFreeByCard.
]

{ #category : 'states' }
SpaceShip >> changeStateToLockedUpAndNeeds: aValueToEscape [

	state := LockedUp withValue: aValueToEscape
]

{ #category : 'states' }
SpaceShip >> changeStateToRetainedAndNeeds: aValueToEscape [

	state := Retained withValue: aValueToEscape
]

{ #category : 'mercenary' }
SpaceShip >> deMercenarize [

	helperOf := spaceShipID.
	helpingOthers := false
]

{ #category : 'shield' }
SpaceShip >> getShield [

	^ shield
]

{ #category : 'cards' }
SpaceShip >> has: aCard [

	| pickedCardFromCards pickedCardFromPending |
	pickedCardFromPending := self remove: aCard from: pendingCards.

	pickedCardFromCards := self remove: aCard from: cards.
	
	self a: pickedCardFromCards isTheSameAs: pickedCardFromPending.

	^ aCard
]

{ #category : 'getters' }
SpaceShip >> id [

	^ spaceShipID
]

{ #category : 'testing' }
SpaceShip >> if0WasTossed: aDiceRoll [

	aDiceRoll = 0 ifTrue: [
		self changeSkippingStateTo: (SkipForShields withNext: NoSkip) ]
]

{ #category : 'initialization' }
SpaceShip >> initializeWith: aShield indentifiedBy: anId andHolding: aCard and: anotherCard [

	spaceShipID := anId.
	shield := aShield.
	loseTurn := 0.
	cards := OrderedCollection withAll: {
			         aCard.
			         anotherCard }.
	pendingCards := OrderedCollection new.
	helperOf := spaceShipID.
	helpingOthers := false.
	state := Free new.
	skipState := NoSkip withNext: NoSkip
]

{ #category : 'mercenary' }
SpaceShip >> isHelpingOthers [

	(helpingOthers = false) ifTrue: [
		helpingOthers := true.
		^ false ].
	^ true
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
		self changeSkippingStateTo:
			(SkipForShields withNext: SkipForSkipping) ]
]

{ #category : 'cards' }
SpaceShip >> pending: aCard [

	pendingCards add: aCard
]

{ #category : 'cards' }
SpaceShip >> pendingCard [

	^ pendingCards
]

{ #category : 'shield' }
SpaceShip >> rechargeShields [

	shield = 3 ifTrue: [
		Error signal: 'The Shield is already full, it cant be recharged.' ].
	shield := 3
]

{ #category : 'cards' }
SpaceShip >> remove: aCard from: aDeck [

	| pickedCard |
	pickedCard := aDeck
		              detect: [ :card | card class = aCard class ]
		              ifNone: [ ^ aCard ].

	aDeck remove: pickedCard.

	^ pickedCard
]

{ #category : 'mercenary' }
SpaceShip >> setAsHelperOf: aSpaceShip [

	helperOf = spaceShipID ifFalse: [
		Error signal: 'A mercenary cant help multiple ships.' ].

	helperOf := aSpaceShip id.
	aSpaceShip addMercenary: spaceShipID
]

{ #category : 'skiping' }
SpaceShip >> skipATurn: aDiceRoll [
	"borrar"
	| doSkip |
	self rechargableShield: aDiceRoll.

	doSkip := false.
	aDiceRoll = 0 ifTrue: [
		shield := 3.
		doSkip := true ].

	^ doSkip
]

{ #category : 'skiping' }
SpaceShip >> skipTurns [
	"borrar"
	loseTurn ~= 0
		ifTrue: [
			loseTurn := loseTurn - 1.
			^ true ]
		ifFalse: [ ^ false ]
]

{ #category : 'as yet unclassified' }
SpaceShip >> willPlayByTossing: aDiceRoll on: aGame [

	self if0WasTossed: aDiceRoll.
	skipState will: self skipAfter: aDiceRoll on: aGame
]
