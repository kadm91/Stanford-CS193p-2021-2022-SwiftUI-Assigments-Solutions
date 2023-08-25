//
//  CreateCardContentView.swift
//  Set-Game-Assigment-3
//
//  Created by Kevin Martinez on 7/11/23.
//

import SwiftUI

struct CreateCardContentView: View {
    
    let card: GameViewModel.Card
    
    
    var body: some View {
        
                VStack(alignment: .center) {
                    
                    ForEach(0..<card.contnet.numberOfSymbold.getInt(), id: \.self) { _ in
                        
                            createSymbol(for: card)
                        
                    }
                    
                }
                .padding()
    }
    
    
  
    
    //color: card.contnet.color.getColor()
    @ViewBuilder
    func createSymbol(for card: GameViewModel.Card ) -> some View {
        switch card.contnet.symbol {
            
        case .oval:
            createsymbolShade(of: card.contnet,
                              shape: OvalShape())
        case .squiggle:
            createsymbolShade(of: card.contnet,
                              shape: SquiggleShape())
        case .diamon:
            createsymbolShade(of: card.contnet,
                              shape: DiamonShape())
        }
        
    }
    
    
    @ViewBuilder
    func createsymbolShade<SymbolShape> (of symbol: SetCardContent, shape: SymbolShape) -> some View where SymbolShape: Shape {
       
        switch symbol.shade {
            
        case .fill:
            shape.fill().foregroundColor(symbol.color.getColor())
                .aspectRatio(DrawingConstants.symbolAspectRatio, contentMode: .fit)
            
            
        case .empty:
            shape.stroke(lineWidth: DrawingConstants.defaultLineWidth).foregroundColor(symbol.color.getColor())
               .aspectRatio(DrawingConstants.symbolAspectRatio, contentMode: .fit)
            
        case .lines:
           StripesShade(shape: shape, color: symbol.color.getColor())
                .aspectRatio(DrawingConstants.symbolAspectRatio, contentMode: .fit)
            
        }
    }
    
    
    struct DrawingConstants {
            static let symbolAspectRatio: CGFloat = 2/1
            static let defaultLineWidth: CGFloat = 2
         
        }
    
    
}

struct CreateCardContentView_Previews: PreviewProvider {
    static var previews: some View {

        let card = GameViewModel().cardsInPlay
        CreateCardContentView(card: card[0])
    }
}
