//
//  Cardify.swift
//  Assigment-4-Animated-Set
//
//  Created by Kevin Martinez on 7/23/23.
//


import SwiftUI

struct Cardify: ViewModifier, Animatable {
  
    var rotation: Double // in degrees
    var isChosen: Bool
    var isMatched: Bool
    var isUnmatched: Bool
    
    var animatableData: Double {
        get { rotation}
        set { rotation = newValue}
    }
    
    init(isFaceUp: Bool, isChoosen: Bool, isMatched: Bool, isUnmatched: Bool) {
        rotation = isFaceUp ? 0 : 180
        self.isChosen = isChoosen
        self.isMatched = isMatched
        self.isUnmatched = isUnmatched
        
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornersRadious)
            
            if  rotation < 90 {
                
                if !isUnmatched {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(isChosen ? .yellow : .accentColor)
                } else {
                    shape.fill().foregroundColor(.red).opacity(0.1)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(.red)
                }
                
                if isMatched {
                    shape.fill().foregroundColor(.green).opacity(0.1)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(.green)
                }
                
                
                
                
            } else {
                
                Image(DrawingConstants.cardBack)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
        
    }
    
    
    private struct DrawingConstants {

        static let cornersRadious: CGFloat = 10
        static let lineWidth: CGFloat = 4
        static let cardBack = "CardBack"
    }
}

extension View {
    func cardify(isFaceUP: Bool, isChossen: Bool, isMatched: Bool, isUnMatched: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUP, isChoosen: isChossen, isMatched: isMatched, isUnmatched: isUnMatched ))
    }
}

