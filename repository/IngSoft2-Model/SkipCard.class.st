Class {
	#name : 'SkipCard',
	#superclass : 'WhiteCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
SkipCard >> skip [
	"borrar"
	^ true
]

{ #category : 'accessing' }
SkipCard >> skip: aSpaceShip [

	aSpaceShip changeSkippingStateTo:
		(SkipForSkipping withNext: NoSkip new)
]
