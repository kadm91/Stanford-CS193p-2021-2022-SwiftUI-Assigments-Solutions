//
//  CardView.swift
//  Assigment-4-Animated-Set
//
//  Created by Kevin Martinez on 7/23/23.
//

import SwiftUI

struct CardView: View {
    
   let card: SetGameModel<SetCardContent>.Card

    
    
    var body: some View {
           
        GeometryReader { geometry in
            
        
        ZStack {
            CreateCardContentView(card: card)
        }
        
        .cardify(isFaceUP: card.isFaceUp, isChossen: card.isChoosen, isMatched: card.isMatched, isUnMatched: card.isUnMatched)
        }
        .rotationEffect( card.isUnMatched ? .degrees(8) : .degrees(0))
        .rotationEffect( card.isMatched ? .degrees(720) : .degrees(0))
        
        
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = GameViewModel().cards[0]
        CardView(card: card)
    
    }
}
