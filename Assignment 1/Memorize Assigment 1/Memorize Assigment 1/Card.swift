//
//  Card.swift
//  Memorize Assigment 1
//
//  Created by Kevin Martinez on 6/29/23.
//

import SwiftUI

struct Card: View {
    @State var isFaceUP = true
    var content: String
    var color: Color
    
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
            if isFaceUP {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 4)
                Text("\(content)").font(.largeTitle)
            } else {
                shape.fill()
                Text(" ").font(.largeTitle)
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
        .foregroundColor(color)
        .onTapGesture {
            isFaceUP.toggle()
        }
    }
}

struct Card_Previews: PreviewProvider {
    
    static var previews: some View {
        Card(isFaceUP: true, content: "🦁", color: .red)
    }
}
