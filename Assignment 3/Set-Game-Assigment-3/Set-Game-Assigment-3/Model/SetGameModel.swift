//
//  SetGame.swift
//  Set-Game-Assigment-3
//
//  Created by Kevin Martinez on 7/11/23.
//

import Foundation

struct SetGameModel<CardContent> where CardContent: Equatable {
    
    
    private (set) var cards: Array<Card>
    private (set) var cardsInPlay: Array<Card> = []
    private (set) var selectedCards: Array<Card> = []
    private (set) var matchedCards: Array<Card> = []
    private (set) var playerPoints = 0
  
    
    
// add this in model for logic and in to be show in top of the screen for presenting it to the user.
    
    // can add an array that hole the matched cards compare their count to 81 and have a progress bard that show the porcentje of card matches
    
    // add point system depending if cards where a match or mismatch.
    
    
    init(initialNumberOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []

        
        for index in 0..<initialNumberOfCards {
            let content = createCardContent(index)
            cards.append(Card(contnet: content ))
        }
        cards.shuffle()
        
        initPlayingCards(12)
        
    }
    
    
    mutating func initPlayingCards (_ amount: Int) {
        for index in 0..<amount {
            cardsInPlay.append(cards[index])
            cards.remove(at: index)
        }
    }
    
    
    mutating func deal3Cards() {
        
        let cardsToMove = min(3, cards.count)
        let movedCards = cards.prefix(cardsToMove)
        
        cards.removeFirst(cardsToMove)
        cardsInPlay.append(contentsOf: movedCards)
        
    }
    
    mutating func shuffleCards() {
        
        let cardsInScrecreen = cardsInPlay.count
        
        if !selectedCards.isEmpty {
            cardsInPlay.indices.forEach({cardsInPlay[$0].isChoosen = false})
            selectedCards = []
        }
        
        cards.append(contentsOf: cardsInPlay)
        cardsInPlay = []
        cards.shuffle()
        
        initPlayingCards(cardsInScrecreen)
    
    }
    
    
    mutating func choose(_ card: Card) {

        guard let choosenCardIndex = cardsInPlay.firstIndex(where: {$0.id == card.id}) else {return}
        
        if selectedCards.contains(where: {$0.id == cardsInPlay[choosenCardIndex].id}) {

            cardsInPlay[choosenCardIndex].isChoosen = false
            
            guard let selectedCardIndex = selectedCards.firstIndex(where: {$0.id == cardsInPlay[choosenCardIndex].id}) else {return}
                
                selectedCards.remove(at: selectedCardIndex)
                
        } else  {
            
            cardsInPlay[choosenCardIndex].isChoosen = true
            selectedCards.append(cardsInPlay[choosenCardIndex])
               
        }
        
    }
    
    mutating func setCardMatch (_ match: Bool) {
        
        if selectedCards.count == 3 {
            
            switch match {
                
            case true:
               
                    selectedCards.forEach { card in
                        if let matchedIndex = cardsInPlay.firstIndex(where: {$0.id == card.id}) {
                            cardsInPlay.remove(at: matchedIndex)
                        
                    }
                }
                
                deal3Cards()
                playerPoints += 37
                matchedCards += selectedCards
                selectedCards = []
                
                
                
            case false:
                
                
                selectedCards = []
                cardsInPlay.indices.forEach({cardsInPlay[$0].isChoosen = false})
                
            playerPoints -= 17
            }
        }
    }
    
    
    struct Card: Identifiable  {
        
        let id = UUID()
        var isChoosen = false
        let contnet: CardContent
        
    }
}
