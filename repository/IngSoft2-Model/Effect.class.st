Class {
	#name : 'Effect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Effect >> applyOn: aShip in: aGame [

	self subclassResponsibility
]

{ #category : 'accessing' }
Effect >> prototype [

	self subclassResponsibility
]
