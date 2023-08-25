//
//  SetCartContent.swift
//  Assigment-4-Animated-Set
//
//  Created by Kevin Martinez on 7/23/23.
//

import SwiftUI


struct SetContent: Equatable {
    
    private (set) var content = [SetCardContent]()
    
    init() {
        for symbol in SetCardContent.Symbol.allOptions {
            for number  in SetCardContent.NumberOfSymbols.allOptions {
                for shadding in SetCardContent.SymbolShading.allOptions {
                    for color in SetCardContent.SymbolColor.allOptions {
                        content.append(SetCardContent(
                            symbol: symbol,
                            numberOfSymbold: number,
                            shade: shadding,
                            color: color
                        ))
                    }
                }
            }
        }
    }
}


struct SetCardContent: Equatable {
    
    var symbol: Symbol
    var numberOfSymbold: NumberOfSymbols
    var shade: SymbolShading
    var color: SymbolColor
    
    
    enum Symbol: String, CaseIterable {
        
        case squiggle
        case oval
        case diamon
    
        
        static var allOptions: [Symbol] = [.oval, .squiggle, .diamon]
    }
    
    enum SymbolShading: String, CaseIterable {
        case empty
        case fill
        case lines
        
        private (set) static var allOptions: [SymbolShading] = [.fill, .empty, .lines]
    }
    
    enum NumberOfSymbols: String, CaseIterable {
        
        case one
        case two
        case three
        
        func getInt() -> Int {
            switch self {
                
            case .one: return 1
            case .two: return 2
            case .three: return 3
            }
        }
        
        private (set)  static var allOptions: [NumberOfSymbols] = [.one, .two, .three]
    }
    
    enum SymbolColor: String, CaseIterable  {
        case green
        case red
        case blue
        
        func getColor() -> Color {
            switch self {
                
            case .green: return Color.green
            case .red: return Color.red
            case .blue: return Color.blue
            }
        }
        
        private (set)  static var allOptions: [SymbolColor] = [.green, .red, .blue]
    }
    
}







