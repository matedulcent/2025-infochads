Class {
	#name : 'Normal',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Normal >> applyOn: aShip in: aGame [
	
	"nada"
]

{ #category : 'accessing' }
Normal >> prototype [

	^ [ :ship :game | self class new ]
]
