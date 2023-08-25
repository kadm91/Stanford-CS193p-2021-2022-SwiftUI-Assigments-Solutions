//
//  ContentView.swift
//  Memorize-Assigment-2
//
//  Created by Kevin Martinez on 12/23/22.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var viewModel: GameViewModel
    
    
    var body: some View {
        
        VStack {
            
            Text(viewModel.themeTitle)
                .font(.largeTitle)
                .fontWeight(.bold)
                Spacer()
            
            HStack {
                Text("Score: \(viewModel.score) ")
                    .font(.title)
                    .fontWeight(.medium)
                Spacer()
                
                newGameButton
            }
            .padding()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) {card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
    
                ThemesView(viewModel: viewModel)
            
        }
        .padding()
        .foregroundColor(viewModel.themeColor)
      
        }
    
    // can add this to its own view using @Bidding to bing the values and make the buttom work
    var newGameButton: some View {
        Button {
            viewModel.theme(Themes.themes[Int.random(in: 0..<Themes.themes.count)])
        } label: {
            Text("New Game")
                .foregroundColor(.blue)
                .fontWeight(.bold)
        }

    }

    }


    // move this to his own view
struct ThemesView: View {
    @ObservedObject var viewModel: GameViewModel
    var body: some View {
        
        HStack {
            
            Button {
                viewModel.theme(Themes.themes[0])

            } label: {
                Image(systemName: "car.fill")
                    .foregroundColor(.red)
                
            }
            
            
            
            Button {
                viewModel.theme(Themes.themes[1])
            } label: {
                
                Image(systemName: "leaf.fill")
                    .foregroundColor(.green)
            }
            .padding(.horizontal)
            
            Button {
                viewModel.theme(Themes.themes[2])
            } label: {
                Image(systemName: "flag.fill")
                    .foregroundColor(.purple)
            }
           
          
            
            Button {
                viewModel.theme(Themes.themes[3])

            } label: {
                Image(systemName: "figure.skiing.downhill")
                    .foregroundColor(.teal)
                
            }
            .padding(.horizontal)
            
            
            Button {
                viewModel.theme(Themes.themes[4])

            } label: {
              Image(systemName: "sun.dust.fill")
                    .foregroundColor(.brown)
            }
            .padding(.horizontal)
            
            Button {
                viewModel.theme(Themes.themes[5])

            } label: {
                Image(systemName: "face.smiling.inverse")
                    .foregroundColor(.yellow)
            }
   
          
        }
        .padding(.horizontal)
        .font(.title)
     
        
       
        

    }
}
    
    
// move card to his own view
    struct CardView: View{
        
        let card: GameModel<String>.Card
        
        var body: some View {
            ZStack{
                let shape = RoundedRectangle(cornerRadius: 20)
                if card.isFaceUp {
                    shape.fill(.white)
                    shape.strokeBorder(lineWidth: 3)
                    Text(card.content).font(.largeTitle)
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let game = GameViewModel()
            ContentView(viewModel: game)
        }
    }

