//
//  AdaptiveStack.swift
//  Set-Game-Assigment-3
//
//  Created by Kevin Martinez on 7/15/23.
//

import SwiftUI

struct AdaptiveStack<Item, ItemView>:View where ItemView: View, Item: Identifiable {
    
    var game: GameViewModel
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(game: GameViewModel ,items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
        self.game = game
    }
    
    var body: some View {
        Group {
            if game.cardsInPlay.count <= 12 {
                
                AspectVGrid(items: items, aspectRatio: aspectRatio, content: content)
                
            } else {
                
                GeometryReader { geometry in
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 73.25 ))]) {
                            ForEach (items) { item in
                                content(item)
                                    .aspectRatio(2/3, contentMode: .fit)
                                    .padding(-4)
                            }
                        }
                    }
                 
                }
            }
        }
    }
    
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        
        var columnCount = 1
        var rowCount = itemCount
        
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        
        if columnCount > itemCount {
            columnCount = itemCount
        }
        
        return floor(size.width / CGFloat(columnCount))
        
    }
}
