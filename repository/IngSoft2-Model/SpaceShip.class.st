Class {
	#name : 'SpaceShip',
	#superclass : 'Object',
	#instVars : [
		'shield',
		'spaceShipID',
		'loseTurn',
		'cards',
		'helper',
		'helperOf',
		'pendingCards',
		'helpingOthers'
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
SpaceShip >> addMercenary: aMercenary [

	"helper add: aMercenary"
]

{ #category : 'testing' }
SpaceShip >> canBattle [

	^ shield > 0 and: loseTurn = 0
]

{ #category : 'as yet unclassified' }
SpaceShip >> deMercenarize [

	helperOf := spaceShipID.
	helpingOthers := false
]

{ #category : 'getters' }
SpaceShip >> getShield [

	^ shield
]

{ #category : 'testing' }
SpaceShip >> has: aCard [

	| pickedCardFromCards pickedCardFromPending |
	pickedCardFromPending := self remove: aCard from: pendingCards.

	pickedCardFromCards := self remove: aCard from: cards.

	pickedCardFromCards == pickedCardFromPending ifTrue: [
		Error signal: 'The card is not in the ships deck' ].

	"^ pickedCardFromCards"
	pickedCardFromPending == aCard ifFalse: [ ^ pickedCardFromPending ].

	^ pickedCardFromCards
]

{ #category : 'getters' }
SpaceShip >> id [

	^ spaceShipID
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
	helpingOthers := false
]

{ #category : 'testing' }
SpaceShip >> isHelping [

	^ helperOf
]

{ #category : 'testing' }
SpaceShip >> isHelpingOthers [

	(helpingOthers = false) ifTrue: [
		helpingOthers := true.
		^ false ].
	^ true
]

{ #category : 'shield' }
SpaceShip >> loseShield [

	shield := shield - 1.
	shield = 0 ifTrue: [ loseTurn := 2 ]
]

{ #category : 'as yet unclassified' }
SpaceShip >> mercenaries [

	"^ helper"
]

{ #category : 'as yet unclassified' }
SpaceShip >> pending: aCard [

	pendingCards add: aCard 
]

{ #category : 'as yet unclassified' }
SpaceShip >> pendingCard [

	^ pendingCards
]

{ #category : 'shield' }
SpaceShip >> rechargableShield: aDiceRoll [

	(shield = 3 and: aDiceRoll = 0) ifTrue: [
		Error signal: 
			'The Shield is already full, it cant be recharged.' ]
]

{ #category : 'removing' }
SpaceShip >> remove: aCard from: aDeck [

	| pickedCard |
	pickedCard := aDeck
		              detect: [ :card | card class = aCard class ]
		              ifNone: [ ^ aCard ].

	aDeck remove: pickedCard.

	^ pickedCard
]

{ #category : 'initialization' }
SpaceShip >> setAsHelperOf: aSpaceShip [
	"testear error "
	helperOf = spaceShipID ifFalse: [
		Error signal: 'A mercenary cant help multiple ships.' ].

	"aSpaceShip == self ifTrue: [ ^ self ]."
	
	helperOf := aSpaceShip id.
	aSpaceShip addMercenary: spaceShipID
]

{ #category : 'accessing' }
SpaceShip >> skipATurn: aDiceRoll [

	| doSkip |
	self rechargableShield: aDiceRoll.

	doSkip := false.
	aDiceRoll = 0 ifTrue: [
		shield := 3.
		doSkip := true ].

	^ doSkip
]

{ #category : 'accessing' }
SpaceShip >> skipTurns [

	loseTurn ~= 0
		ifTrue: [
			loseTurn := loseTurn - 1.
			^ true ]
		ifFalse: [ ^ false ]
]
