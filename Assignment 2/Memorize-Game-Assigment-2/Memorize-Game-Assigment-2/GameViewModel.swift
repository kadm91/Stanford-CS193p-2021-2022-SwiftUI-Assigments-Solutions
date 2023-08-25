//
//  GameViewModel.swift
//  Memorize-Assigment-2
//
//  Created by Kevin Martinez on 12/23/22.
//

import SwiftUI

class GameViewModel: ObservableObject {
    
    //MARK: - Properties
    
    static var theme = Themes.themes[Int.random(in: 0..<Themes.themes.count)]
    var themeTitle = theme.title
    var themeColor = theme.themeColor
    
    
    static var emojis = theme.emojis
    
    @Published private var model = GameModel<String>(numberOfPairsCards: Int.random(in: 8..<emojis.count)) {pairIndex  in emojis[pairIndex]}
    
    
    
    var cards: Array<GameModel<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    //MARK: - Methods
    func choose(_ card: GameModel<String>.Card) {
        model.choose(card)
    }
    
    func theme(_ theme: Themes){
        GameViewModel.emojis = theme.emojis
        themeTitle = theme.title
        themeColor = theme.themeColor
        model = GameModel<String>(numberOfPairsCards: Int.random(in: 8..<GameViewModel.emojis.count)) {pairIndex  in GameViewModel.emojis[pairIndex]}
    }
}
