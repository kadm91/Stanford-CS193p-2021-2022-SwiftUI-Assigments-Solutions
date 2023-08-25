//
//  Set_Game_Assigment_3App.swift
//  Set-Game-Assigment-3
//
//  Created by Kevin Martinez on 7/10/23.
//

import SwiftUI

@main
struct Set_Game_Assigment_3App: App {
    
    private let game = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
