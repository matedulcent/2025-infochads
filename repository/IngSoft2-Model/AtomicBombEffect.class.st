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
AtomicBombEffect >> applyOn: aShip in: aGame [
	
	aGame returnEveryShipToTheBeguining.
	aGame deductAShieldFromEveryShip.
]

{ #category : 'accessing' }
AtomicBombEffect >> prototype [

	^ [ :ship :game | self class new ]
]
