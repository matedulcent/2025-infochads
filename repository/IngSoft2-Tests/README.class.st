Class {
	#name : 'README',
	#superclass : 'Object',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
README >> readmeCardDistribution [
	"aDeckOfPosibleCards := CardDeck withCards: {
			                       SpeedCard new. 
			                       RepeatCard new}."
			
	"RULES FOR TESTING:
	The cards manage a stack distribution (The First card poped is the last card pushed).
	The cards are first assigned to the Card Cell. The Card Manager withdraws the asignated number of cards from the deck. 
	Two cards for every spaceShip are then picked using the same logic, starting with spaceShip 1 , then 2 , finishing with spaceShip N.
	In any circumstance, if the deck runs out of cards, it will start dealing an infinite number of WhiteCards (Polimorphic to other cards with Null behaviour).
	The ship can use the card only if it has the card on its deck
	 "

	
]

{ #category : 'as yet unclassified' }
README >> readmeTestingCellPlacementAndDistribution [
	"aConfigureDiceSet := RiggedDice new initializeWith:
		                     { %Normal. %BH. %HSJ. %HJ. %Atomic. %MoonW. %Card. %Jail. %HGrav. NumberOfCardsTakenFromDeck. DistanceInParsecs. DistanceInLightYears. LenghtOfArrayOfHJ. Jump1. Jump2. JumpN. MoonWDesplacement1. MoonWDesplacement2. MoonWDesplacementN. 0. HGravDisplacement1. HGravDisplacement2. HGravDisplacementN.}."
		
		"RULES FOR TESTING:
			% Must sum 100.
			If NumberOfCardsTakenFromDeck == 0 Then A complete Deck is shuffled and assigns random cards to every cell.
			Distance in Light years must fullfill the proportion with Distance in parsecs (3:1).
			If distance in parsecs == 0 Then the jumps are light years.
			If distance in years == 0 Then the jumps are in parsecs.
			If both distance != 0 Then the jumps are in parsecs
			MoonWalk values to cells are assigned till the program finds a 0 or -1 (Appears when no more values are find).
			The MoonWalk values are settled in an Array and the Array in multiplied by the boardsize and popidly assigned to each cell (in order).
			The HyperGravity Values must be behind a 0 in the configDice. 
			Has the same logic as MoonWalk Values
		"
		"Some of these rules were not tested because it could only be accessed by the developer.
		
		'The only way to keep your developer's job is to write legacy code' _nitche"

	
]
