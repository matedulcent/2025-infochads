Class {
	#name : 'Free',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Free >> canBeFreed [

	^ false
]

{ #category : 'testing' }
Free >> isFreeByTossing: aDiceRoll [

	^ true
]

{ #category : 'testing' }
Free >> isLockedUp [

	^ false
]
