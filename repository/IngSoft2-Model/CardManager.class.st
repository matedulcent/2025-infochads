Class {
	#name : 'CardManager',
	#superclass : 'Object',
	#instVars : [
		'deckOfCards',
		'activeCards',
		'lastCardPlayed',
		'lastCellPlayed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardManager class >> createWith: aDeckOfCards [

	^self new initializeWith: aDeckOfCards 
]

{ #category : 'as yet unclassified' }
CardManager >> activatePermanent: aCard on: aShip [

	aCard isPermanent ifTrue: [
		lastCardPlayed := aShip has: aCard.
		(activeCards at: aShip id) add: lastCardPlayed.
		^ true ].
	^ false
]

{ #category : 'accessing' }
CardManager >> activeCards [

	^ activeCards deepCopy
]

{ #category : 'adding' }
CardManager >> addNew: spaceShipID [

	activeCards at: spaceShipID put: OrderedCollection new.
]

{ #category : 'as yet unclassified' }
CardManager >> applyCardEffectsOver: aSpaceShip or: spaceShips dependingOn: positionManager [

	self playSpeedOn: aSpaceShip basedOn: positionManager.

	self
		playAccelerationOn: aSpaceShip
		thatMayBeIn: spaceShips
		basedOn: positionManager.

	self playMercenaryOn: aSpaceShip andCheckForHelping: spaceShips
]

{ #category : 'as yet unclassified' }
CardManager >> grabTopCard [

	deckOfCards isEmpty ifFalse: [ ^ deckOfCards removeLast ].
	^ WhiteCard new
]

{ #category : 'initialization' }
CardManager >> initializeWith: aDeckOfCards [ 

	deckOfCards := aDeckOfCards.
	activeCards := OrderedDictionary new.
	lastCardPlayed := WhiteCard new.
	lastCellPlayed := Cell has: NoEffect new
]

{ #category : 'accessing' }
CardManager >> lastCardPlayed: aCard [

	lastCardPlayed := aCard
]

{ #category : 'accessing' }
CardManager >> lastCellPlayed: aCell [

	lastCellPlayed := aCell 
]

{ #category : 'as yet unclassified' }
CardManager >> listOfMercenariesOf: aShip [

	^(activeCards at: aShip id) collect: [ :card | card helper ]
]

{ #category : 'as yet unclassified' }
CardManager >> numberOfMercenariesOf: aShip [

	^ ((activeCards at: aShip id) select: [ :card | card isMercenary ])
		  size + 1
]

{ #category : 'as yet unclassified' }
CardManager >> play: aCard on: aShip thatIsIn: spaceShips with: nextSpaceShipToMove and: spaceShipPositions [

	self playRedo: aCard on: aShip.
	(aShip id ~= nextSpaceShipToMove and: aCard isPermanent) ifTrue: [
		aShip pending: aCard.
		^ self ].
	(self activatePermanent: aCard on: aShip) ifTrue: [ ^ self ].

	self playCancelation: aCard on: aShip.

	self
		playRepeat: aCard
		on: aShip
		and: spaceShips
		dependingOn: spaceShipPositions.

	self lastCardPlayed: (aShip has: aCard)
]

{ #category : 'as yet unclassified' }
CardManager >> playAccelerationOn: aSpaceShip thatMayBeIn: spaceShips basedOn: positionManager [

	 activeCards associationsDo: [ :shipCards |
		shipCards value do: [ :card |
			positionManager sumAt: aSpaceShip id with: card effectAll ] ]
]

{ #category : 'as yet unclassified' }
CardManager >> playCancelation: aCard on: aShip [

	| card |
	(aCard objective: aShip id) = '' ifTrue: [ ^ self ].
	card := (activeCards at: (aCard objective: aShip id))
		        detect: [ :cardOfShip |
		        cardOfShip class = (aCard cardObjective: aCard) class ]
		        ifNone: [
			        Error signal:
				        'This card cant be played if the card to be canceled is not active.' ].
	(activeCards at: (aCard objective: aShip id)) remove: card.
	aShip deMercenarize
]

{ #category : 'as yet unclassified' }
CardManager >> playMercenaryOn: aSpaceShip andCheckForHelping: spaceShips [

	(activeCards at: aSpaceShip id) do: [ :card |
		card activateMercenaryOn ifTrue: [
			self the: card mercenaryIsHelpingOther: spaceShips ] ]
]

{ #category : 'as yet unclassified' }
CardManager >> playRedo: aCard on: aShip [

	lastCardPlayed isRedo ifFalse: [
		aCard mimic: lastCardPlayed deepCopy.
		^ self ].

	aCard isRedo ifTrue: [
		aCard mimic: lastCardPlayed mimic deepCopy ]
]

{ #category : 'as yet unclassified' }
CardManager >> playRepeat: aCard on: aShip and: spaceShips dependingOn: spaceShipPositions [

	| cell objectiveShip |
	
	aCard lastPowerUpPlayed: lastCellPlayed .
	((aCard target: aShip id) = '') ifTrue: [ ^self ].
	cell := aCard replicateCell.
	objectiveShip := spaceShips detect: [ :ship |
		                 ship id = (aCard target: aShip id) ].
	
	cell
		takeActionOver: objectiveShip
		or: spaceShips
		thatArePlaced: spaceShipPositions.
]

{ #category : 'as yet unclassified' }
CardManager >> playSpeedOn: aSpaceShip basedOn: positionManager [

	(activeCards at: aSpaceShip id) do: [ :card |
		positionManager sumAt: aSpaceShip id with: card effect ]
]

{ #category : 'as yet unclassified' }
CardManager >> the: opponentShip isMercenaryOf: aSpaceShip [

	^ ((activeCards at: aSpaceShip id) anySatisfy: [ :card |
		   aSpaceShip id = card helper ]) or:
		  ((activeCards at: opponentShip id) anySatisfy: [ :card |
			   aSpaceShip id = card helper ])
]

{ #category : 'as yet unclassified' }
CardManager >> the: card mercenaryIsHelpingOther: spaceShips [

	| mercenary |
	mercenary := spaceShips detect: [ :ship | ship id = card helper ].

	mercenary isHelpingOthers ifTrue: [
		Error signal: 'A mercenary cant help multiple ships.' ]
]
