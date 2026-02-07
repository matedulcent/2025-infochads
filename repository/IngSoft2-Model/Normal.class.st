Class {
	#name : 'Normal',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Normal >> applyOn: aShip in: aCellSystem [
	"   _   -   "
	"\_(0 - 0)_/"
]

{ #category : 'accessing' }
Normal >> prototype [

	^ [ self class new ]
]
