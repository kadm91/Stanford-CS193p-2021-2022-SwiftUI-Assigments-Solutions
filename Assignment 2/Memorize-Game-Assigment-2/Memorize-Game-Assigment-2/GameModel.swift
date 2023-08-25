//
//  GameModel.swift
//  Memorize-Assigment-2
//
//  Created by Kevin Martinez on 12/23/22.
//

import Foundation

struct GameModel<CardContent> where CardContent: Equatable {
   
    //MARK: - Properties
    
    private(set) var cards: Array<Card>
    private var indexOfFaceUpCard: Int?
    private(set) var score = 0
    
    //MARK: - Methods
    
    mutating func choose (_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            
            if let potentianMatchIndex = indexOfFaceUpCard {
                if cards[chosenIndex].content == cards[potentianMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentianMatchIndex].isMatched = true
                    score += 2
                } else if cards[chosenIndex].content != cards[potentianMatchIndex].content, cards[chosenIndex].cardHaveBeenSeen == true || cards[potentianMatchIndex].cardHaveBeenSeen == true {
                    score -= 1
                } else {
                    cards[chosenIndex].cardHaveBeenSeen = true
                    cards[potentianMatchIndex].cardHaveBeenSeen = true
                }
                
                
                
                indexOfFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
               
                indexOfFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    //MARK: - Init
    
    init(numberOfPairsCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
  
    }
    
    //MARK: - Card Struct
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var cardHaveBeenSeen = false
        var content: CardContent
        var id: Int
    }
}

