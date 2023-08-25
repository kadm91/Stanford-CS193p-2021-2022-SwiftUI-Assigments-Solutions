//
//  Assigment_4_Animated_SetApp.swift
//  Assigment-4-Animated-Set
//
//  Created by Kevin Martinez on 7/23/23.
//

import SwiftUI

@main
struct Assigment_4_Animated_SetApp: App {
    
    private let game = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
