Class {
	#name : 'RiggedDice',
	#superclass : 'Object',
	#instVars : [
		'setOfMovements',
		'turn',
		'setMaxValue'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'initialization' }
RiggedDice >> initializeWith: aSetOfMovements [

	setOfMovements := aSetOfMovements.
	turn := 1.
	setMaxValue := 1
]

{ #category : 'testing' }
RiggedDice >> isEmpty [

	^ false
]

{ #category : 'accessing' }
RiggedDice >> maxValue [

	^ setMaxValue
]

{ #category : 'initialization' }
RiggedDice >> setMaximumValueAs: aValues [

	setMaxValue := aValues
]

{ #category : 'as yet unclassified' }
RiggedDice >> toss [

	| movement |
	turn <= setOfMovements size ifTrue: [
		movement := setOfMovements at: turn.
		turn := turn + 1.
		^ movement ].
	^ -1
]
