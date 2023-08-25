//
//  GameViewModel.swift
//  Set-Game-Assigment-3
//
//  Created by Kevin Martinez on 7/14/23.
//

import Foundation



class GameViewModel: ObservableObject {
    
    
    typealias Card = SetGameModel<SetCardContent>.Card
    
    
    private static let contnet: [SetCardContent] = {
        let content = SetContent()
        return content.content
    }()
    
    
    private static func createSetGame() -> SetGameModel<SetCardContent> {
        SetGameModel(initialNumberOfCards: contnet.count) { contentIndex in
            contnet[contentIndex]
        }
    }
    
    
    @Published private var model = createSetGame()
    
    var cardsInPlay: Array<Card> {
        model.cardsInPlay
    }
    
    
    var cards: Array<Card> {
        model.cards
    }
    
    var playerPoints: Int {
        model.playerPoints
    }
    
    var numberOfMatchedCards: Double {
        Double(model.matchedCards.count)
    }
    
    var numberOFCardSetsFounded: Int {
        model.matchedCards.count / 3
    }
    
    //MARK: - Intentions
    
    func deal3Cards () {
        model.deal3Cards()
    }
    
    func choose(_ card: Card) {
        
        if model.selectedCards.count < 2 {
            
            model.choose(card)
            
        } else if model.selectedCards.count <= 3 {
            
            model.choose(card)
            
            if model.selectedCards.count == 3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    
                    self.model.setCardMatch(self.checkForMatches())
                    
                }
            }
        }
    }
    
    func shuffleCards() {
        model.shuffleCards()
    }
    
    func newGame() {
        model = GameViewModel.createSetGame()
    }
    
    
    
    //MARK: - Card Content Evaluation
    
    
    private func checkForMatches() -> Bool {
        
        let selectedCard1 = model.selectedCards[0]
        let selectedCard2 = model.selectedCards[1]
        let selectedCard3 = model.selectedCards[2]
        
                return setEvalution(
                    card1: selectedCard1,
                    card2: selectedCard2,
                    card3: selectedCard3
                )
        
      // NOTE: To test the game comment the return that is up of this commment and uncomment the return below this comment.
        
        //return true
        
    }
    
    private func setEvalution (card1: Card, card2: Card, card3: Card) -> Bool {
        
        let evaluateSymbol = matchSetRules(
            attribute1: card1.contnet.symbol.rawValue,
            attribute2: card2.contnet.symbol.rawValue,
            attribute3: card3.contnet.symbol.rawValue
        )
        
        let evaluateShade = matchSetRules(
            attribute1: card1.contnet.shade.rawValue,
            attribute2: card2.contnet.shade.rawValue,
            attribute3: card3.contnet.shade.rawValue
        )
        
        let evaluateNumber = matchSetRules(
            attribute1: card1.contnet.numberOfSymbold.rawValue,
            attribute2: card2.contnet.numberOfSymbold.rawValue,
            attribute3: card3.contnet.numberOfSymbold.rawValue
        )
        
        let evaluateColor = matchSetRules(
            attribute1: card1.contnet.color.rawValue,
            attribute2: card2.contnet.color.rawValue,
            attribute3: card3.contnet.color.rawValue
        )
        
        return (evaluateShade && evaluateSymbol) && (evaluateNumber && evaluateColor)
        
    }
    
    
    
    
    private func matchSetRules (attribute1: String, attribute2: String, attribute3: String) -> Bool {
        
        if attribute1 == attribute2 && attribute2 == attribute3 {
            return true
        } else if attribute1 != attribute2 && attribute2 != attribute3 {
            return true
        } else {
            return false
        }
        
    }
    
}






















