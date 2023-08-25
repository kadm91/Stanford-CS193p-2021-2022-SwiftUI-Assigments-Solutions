//
//  SetGameModel.swift
//  Assigment-4-Animated-Set
//
//  Created by Kevin Martinez on 7/23/23.
//

import Foundation

struct SetGameModel<CardContent> where CardContent: Equatable {
    
    
    private (set) var cards: Array<Card>
    private (set) var cardsInPlay: Array<Card> = []
    private (set) var selectedCards: Array<Card> = []
    private (set) var matchedCards: Array<Card> = []
    private (set) var playerPoints = 0
    private  var unmathcedindexes: Array<Int> = []
    private  var matchedIndexes: Array<Int> = []
    
    init(initialNumberOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []

        
        for index in 0..<initialNumberOfCards {
            let content = createCardContent(index)
            cards.append(Card(id: index * 2, contnet: content ))
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
        
        let cardsInScrecreen = (cardsInPlay.count - 3)
        
        if !selectedCards.isEmpty {
            cardsInPlay.indices.forEach({cardsInPlay[$0].isChoosen = false})
            selectedCards = []
        }
        
        cardsInPlay.indices.forEach({cardsInPlay[$0].isFaceUp = false})
        
        cards.append(contentsOf: cardsInPlay)
        cardsInPlay = []
        cards.shuffle()
        
        initPlayingCards(cardsInScrecreen)
    
    }
    
    mutating func choose(_ card: Card) {
        
        
        
        if unmathcedindexes.count == 3 {
            unmathcedindexes.forEach({cardsInPlay[$0].isUnMatched = false})
            unmathcedindexes = []
            
        }
        
        
        if matchedIndexes.count == 3 {
            
             selectedCards.forEach { card in
                 if let matchedIndex = cardsInPlay.firstIndex(where: {$0.id == card.id}) {
                     
                     cardsInPlay.remove(at: matchedIndex)
                     
                 }
             }
            
            matchedCards.insert(contentsOf: selectedCards, at: 0)
            selectedCards = []
            matchedIndexes = []
        }

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
                            cardsInPlay[matchedIndex].isMatched = true
                            matchedIndexes.append(matchedIndex)
                        }
                    }
                
                    playerPoints += 37
                
            case false:
                
                selectedCards.forEach { card in
                    if let matchedIndex = cardsInPlay.firstIndex(where: {$0.id == card.id}) {
                        cardsInPlay[matchedIndex].isUnMatched = true
                        unmathcedindexes.append(matchedIndex)
                    }
                }
                
                cardsInPlay.indices.forEach({cardsInPlay[$0].isChoosen = false})
                
            playerPoints -= 17
            selectedCards = []
                
            }
        }
    }
    
    mutating func faceCardUp (_ card: Card) {
      guard let index = cardsInPlay.firstIndex(where: {$0.id == card.id}) else {return}
   
        cardsInPlay[index].isFaceUp = true
    }
    
    
    
    
    
    struct Card: Identifiable, Equatable {
        
        let id: Int
        var isFaceUp = false
        var isChoosen = false
        var isMatched = false
        var isUnMatched = false
        let contnet: CardContent
        
    }
}
