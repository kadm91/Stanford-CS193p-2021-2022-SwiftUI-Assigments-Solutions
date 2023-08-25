//
//  Memorize_Assigment_2App.swift
//  Memorize-Assigment-2
//
//  Created by Kevin Martinez on 12/23/22.
//

import SwiftUI

@main
struct Memorize_Assigment_1App: App {
    let game = GameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
