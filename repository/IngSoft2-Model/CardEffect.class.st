Class {
	#name : 'CardEffect',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardEffect >> applyOn: aShip in: aCellSystem [

	aCellSystem giveACardTo: aShip
]

{ #category : 'accessing' }
CardEffect >> prototype [

	^ [ self class new ]
]
