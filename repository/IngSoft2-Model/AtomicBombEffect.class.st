Class {
	#name : 'AtomicBombEffect',
	#superclass : 'Effect',
	#instVars : [
		'desplacement'
	],
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

{ #category : 'as yet unclassified' }
AtomicBombEffect >> applyToAllSpaceShips: aPosition [

	^ Position at: 0 withLaps: 0
]

{ #category : 'as yet unclassified' }
AtomicBombEffect >> applyToSpaceShip: aPosition [

	^ Position at: 0 withLaps: 0
]

{ #category : 'as yet unclassified' }
AtomicBombEffect >> damageAllShields [

	^ true
]

{ #category : 'accessing' }
AtomicBombEffect >> prototype [

	^ [ :ship :game | self class new ]
]
