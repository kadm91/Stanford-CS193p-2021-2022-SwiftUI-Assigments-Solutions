//
//  SetGameView.swift
//  Set-Game-Assigment-3
//
//  Created by Kevin Martinez on 7/10/23.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: GameViewModel
    
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                Spacer()
                
                gameProgression.padding(.vertical)
                
                Divider()
                
                gameBody
                
                dealButtom
            }
            
           
                
                .toolbar() {
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Shuffle") {
                            game.shuffleCards()
                        }
                        .fontWeight(.bold)
                        .padding(.top)
                        
                    }
                }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("New Game") {
                            game.newGame()
                        }
                        
                        .fontWeight(.bold)
                        .padding(.top)
                    }
                }
            
        }
  }
    
    
    
    
    
    
    var gameBody: some View {
            AdaptiveStack(game: game, items: game.cardsInPlay, aspectRatio: 2/3) { card in
                CardView(card: card).padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
            .padding()
    }
    
    // to put this in a diferent file view we will need to shange from using StateObject to use enviromental object.
 
    var gameProgression: some View {
        
        Group {
            VStack(alignment: .center, spacing: 15) {
                
                HStack {
                    
                 
                    VStack(spacing: 10) {
                        Text("Score: ")
                        Text("\(game.playerPoints)")
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        Text("Sets: ")
                        Text("\(game.numberOFCardSetsFounded) / 27")
                        
                    }
                    
                    Spacer()
                    
                    ProgressView(value: game.numberOfMatchedCards, total: 81)
                        .progressViewStyle(CircularProgressViewStyle())
                    
                }
                .fontWeight(.bold)
                .padding(.horizontal)
            }
            .padding()
           
        }
     
    }
    
    var dealButtom: some View {
        
        Button {
            game.deal3Cards()
        } label: {
            Text("Deal")
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
        .buttonStyle(.borderedProminent)
        .font(.largeTitle)
        .fontWeight(.semibold)
        .disabled(game.cards.isEmpty)

    }
    

    
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel()
        NavigationStack {
            SetGameView(game: game)
        }
    }
}
