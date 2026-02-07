Class {
	#name : 'PowerCellUnitTest',
	#superclass : 'PowerCellInteractionTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
PowerCellUnitTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

    self
        should: anErrorBlock
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: (error messageText) equals:
                errorMessage ]
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenBlackHoleDoesntReceiveADesplacementNotAsIntegerThenCreationFails [

	self
		should: [ BlackHoleEffect withBackTrack: '10' .]
		raise: Error
		withMessageText: 'The desplacement must be 4.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenBlackHoleReceiveADesplacementOtherThan4ThenCreationFails [

	self
		should: [ BlackHoleEffect withBackTrack: 10 ]
		raise: Error
		withMessageText: 'The desplacement must be 4.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenHyperGravityCellHasANegativeJailOutValueThenCreationFails [

	self
		should: [ HyperGravityEffect with: -1 ]
		raise: Error
		withMessageText: 'The Value to escape de Hyper Gravity cell must be positive '
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenHyperGravityCellHasAZeroJailOutValueThenCreationFails [

	self
		should: [ HyperGravityEffect with: 0 ]
		raise: Error
		withMessageText: 'The Value to escape de Hyper Gravity cell must be positive '
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenHyperJumpDoesntReceiveAtLeastOneJumpValueThenCreationFails [

	self
		should: [ HyperJumpEffect with: 100 andParsec: #( ) ]
		raise: Error
		withMessageText: 'The Jump list must have at least one value.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenHyperSpaceJumpDoesntReceiveADesplacementNotAsIntegerThenCreationFails [

	self
		should: [ HyperSpaceJumpEffect withForwardTrack: 'a' ]
		raise: Error
		withMessageText: 'The desplacement must be 4.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenHyperSpaceJumpReceiveADesplacementOtherThan4ThenCreationFails [

	self
		should: [ HyperSpaceJumpEffect withForwardTrack: 10 ]
		raise: Error
		withMessageText: 'The desplacement must be 4.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenJailCellHasANegativeJailOutValueThenCreationFails [

	self
		should: [ JailEffect with: -1 ]
		raise: Error
		withMessageText: 'The Jail-Out dice toss must be positive.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenJailCellHasAZeroJailOutValueThenCreationFails [

	self
		should: [ JailEffect with: 0 ]
		raise: Error
		withMessageText: 'The Jail-Out dice toss must be positive.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenMoonWalkReceiveADesplacementOf0ThenCreationFails [

	self
		should: [ MoonWalkEffect withBackTrack: 0 ]
		raise: Error
		withMessageText: 'The desplacement must be a number different from 0.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenMoonWalkReceiveADesplacementOfNotAnIntegerThenCreationFails [

	self
		should: [ MoonWalkEffect withBackTrack: 'a' ]
		raise: Error
		withMessageText: 'The desplacement must be a number different from 0.'
]
