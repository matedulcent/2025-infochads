Class {
	#name : 'CardHolderGlobal',
	#superclass : 'Object',
	#instVars : [
		'activeCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardHolderGlobal class >> withPlayers: arg1 [

	^ self new initializeWithPlayers: arg1
]

{ #category : 'adding' }
CardHolderGlobal >> addActive: aCard to: aShip [
	"no se porque me salta en amarillo"
	(activeCards at: aShip id) add: aCard
]

{ #category : 'initialization' }
CardHolderGlobal >> createCardPositionsOf: spaceShips [

	spaceShips do: [ :ship |
		activeCards at: ship id put: OrderedCollection new ]
]

{ #category : 'initialization' }
CardHolderGlobal >> initializeWithPlayers: spaceShips [

	activeCards := Dictionary new.
	
	self createCardPositionsOf: spaceShips
]
