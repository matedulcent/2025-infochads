Class {
	#name : 'AtomicBombEffect',
	#superclass : 'Effect',
	#classInstVars : [
		'shieldScrificed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AtomicBombEffect >> applyOn: aShip in: aCellSystem [
	
	aCellSystem returnEveryShipToTheBeguining.
	aCellSystem deductAShieldFromEveryShip.
]

{ #category : 'accessing' }
AtomicBombEffect >> prototype [

	^ [ self class new ]
]
