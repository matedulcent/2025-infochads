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

{ #category : 'initialization' }
Cell >> initializeWith: anEffectPrototype [

	effectPrototype := anEffectPrototype
]

{ #category : 'as yet unclassified' }
Cell >> percieveAction [

	^ effectPrototype
]
