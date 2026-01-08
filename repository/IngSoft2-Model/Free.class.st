Class {
	#name : 'Free',
	#superclass : 'ShipState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Free >> canBeFreed [
	"borrar"
	^ false
]

{ #category : 'testing' }
Free >> isFreeByTossing: aDiceRoll [
	"borrar"
	^ false"true"
]

{ #category : 'testing' }
Free >> isLockedUp [
	"borrar"
	^ false
]

{ #category : 'as yet unclassified' }
Free >> playTurnFor: aSpaceShip with: aDiceRoll in: aGame [

	aGame move: aSpaceShip after: aDiceRoll.
	"^self"
]
