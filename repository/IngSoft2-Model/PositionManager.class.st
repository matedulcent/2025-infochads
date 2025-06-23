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
