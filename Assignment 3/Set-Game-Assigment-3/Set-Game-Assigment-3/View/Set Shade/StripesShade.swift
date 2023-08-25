//
//  StripesShade.swift
//  Set-Game-Assigment-3
//
//  Created by Kevin Martinez on 7/11/23.
//

import SwiftUI

struct StripesShade<SymbolShape>: View where SymbolShape: Shape {
    
    
    
    let lines = 0..<8
    let borderLineWidth: CGFloat = 1.3
    
    let shape: SymbolShape
    let color: Color
    let spacingColor = Color.white
    
    var body: some View {
        
        VStack(spacing: 0.5) {
            ForEach (lines, id: \.self) { _ in
                spacingColor
                color
            }
            spacingColor
        }
        .mask(shape)
        .overlay(shape.stroke(color, lineWidth: borderLineWidth))
        
        
    }
    
//    private struct StripeShadeConstants {
//        let numberOfLines:  Range<Int> = 0..<40
//    }
    
    
    
    
}


struct StripesShade_Previews: PreviewProvider {
    static var previews: some View {
        StripesShade<DiamonShape>(shape: DiamonShape(), color: .red)
    }
}
