Class {
	#name : 'ProbabilityCounter',
	#superclass : 'Object',
	#instVars : [
		'gameBoard',
		'numberOfCellsOfCertainType',
		'effectToCount'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
ProbabilityCounter >> count [

	| dummyShip dummyGame |
	dummyShip := Object new.
	dummyGame := Object new.

	gameBoard do: [ :cell |
		(cell percieveAction value: dummyShip value: dummyGame) class
		= effectToCount class ifTrue: [
			numberOfCellsOfCertainType := numberOfCellsOfCertainType + 1 ] ]
]

{ #category : 'initialization' }
ProbabilityCounter >> initializeToCountFrom: aGameBoard theCellsThatHave: anEffect [

	gameBoard := aGameBoard.
	numberOfCellsOfCertainType := 0.
	effectToCount := anEffect.
	self removeFirstAndLast.
	self count.
	^ numberOfCellsOfCertainType
]

{ #category : 'removing' }
ProbabilityCounter >> removeFirstAndLast [

	gameBoard removeFirst.
	gameBoard removeLast
]
