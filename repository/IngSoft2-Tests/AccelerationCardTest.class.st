Class {
	#name : 'AccelerationCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
AccelerationCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
	
]

{ #category : 'tests' }
AccelerationCardTest >> testWhenTheIncrementInTheDiceTossIsNegativeThenCreationFails [

	self
		should: [ AccelerationCard with: -1 ]
		raise: Error
		withMessageText: 'The increment in the dice toss must be one.'
]

{ #category : 'tests' }
AccelerationCardTest >> testWhenTheIncrementInTheDiceTossIsNot1ThenCreationFails [

	self
		should: [ AccelerationCard with: 10 ]
		raise: Error
		withMessageText: 'The increment in the dice toss must be one.'
]

{ #category : 'tests' }
AccelerationCardTest >> testWhenTheIncrementInTheDiceTossIsNotAnIntThenCreationFails [

	self
		should: [ AccelerationCard with: 'a' ]
		raise: Error
		withMessageText: 'The increment in the dice toss must be one.'
]
