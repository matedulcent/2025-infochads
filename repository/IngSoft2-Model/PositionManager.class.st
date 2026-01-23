Class {
	#name : 'PositionManager',
	#superclass : 'Object',
	#instVars : [
		'positions'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
PositionManager class >> of: spaceShips [

	^ self new initializeWith: spaceShips
]

{ #category : 'as yet unclassified' }
PositionManager >> adjustAllPositionsOn: aBoard totalLaps: laps [

	positions keysDo: [ :shipId |
		self
			sumAt: shipId
			with:
			(aBoard limitAdjustment: (positions at: shipId) withTotalLaps: laps) ]
]

{ #category : 'as yet unclassified' }
PositionManager >> applyBoardEffectsOn: aShipId using: aBoard totalLaps: laps [

	self
		at: aShipId
		replacePositionWith:
		(aBoard applySpecialTilesTo: (positions at: aShipId)).

	self adjustAllPositionsOn: aBoard totalLaps: laps
]

{ #category : 'accessing' }
PositionManager >> at: spaceShipID [

	^ (positions at: spaceShipID) deepCopy
]

{ #category : 'accessing' }
PositionManager >> at: aSpaceShipID replacePositionWith: aPosition [

	positions
		at: aSpaceShipID
		put: ((positions at: aSpaceShipID) replacePositionWith: aPosition)
]

{ #category : 'initialization' }
PositionManager >> initializeWith: spaceShips [

	positions := OrderedDictionary new.

	spaceShips do: [ :ship |
		positions at: ship id put: (Position at: 1 withLaps: 0) ]
]

{ #category : 'as yet unclassified' }
PositionManager >> move: aShipId by: aDiceRoll on: aBoard totalLaps: laps [

	self sumAt: aShipId with: (Position at: aDiceRoll withLaps: 0).
	self adjustAllPositionsOn: aBoard totalLaps: laps
]

{ #category : 'accessing' }
PositionManager >> positions [

	^ positions 
]

{ #category : 'accessing' }
PositionManager >> positionsAt: id put: aPosition [

	positions at: id put: aPosition.

	
]

{ #category : 'accessing' }
PositionManager >> sumAt: aSpaceShipID with: aPosition [

	positions
		at: aSpaceShipID
		put: ((positions at: aSpaceShipID) sumTo: aPosition)
]
