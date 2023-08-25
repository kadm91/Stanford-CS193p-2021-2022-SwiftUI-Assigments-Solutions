//
//  CardView.swift
//  Set-Game-Assigment-3
//
//  Created by Kevin Martinez on 7/14/23.
//

import SwiftUI

struct CardView: View {
    
   let card: SetGameModel<SetCardContent>.Card

    
    
    var body: some View {
        
        let shape =  RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 4).foregroundColor(card.isChoosen ? .orange : .accentColor)
           
        
        ZStack {
            shape
            CreateCardContentView(card: card)
        }
   

    }
    
    
    
    
    
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = GameViewModel().cardsInPlay[0]
        CardView(card: card)
    
    }
}
