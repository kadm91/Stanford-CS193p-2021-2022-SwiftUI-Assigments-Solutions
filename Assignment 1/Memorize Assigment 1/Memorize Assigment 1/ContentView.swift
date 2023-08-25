//
//  ContentView.swift
//  Memorize Assigment 1
//
//  Created by Kevin Martinez on 6/29/23.
//

import SwiftUI

struct ContentView: View {
    
    static let themes = [
        ["🇺🇸", "🏴‍☠️", "🏁", "🇻🇪", "🇬🇧", "🇹🇷", "🇧🇷", "🇩🇪", "🇳🇮", "🇦🇷"],
        ["✈️", "🚀", "🚗", "🚙", "🛵", "🚌", "🚜", "🛴", "🚲", "🏎️"],
        ["🌡️", "☁️", "☀️", "🌤️", "☔️", "❄️", "🌪️", "🌊", "💨", "💧"]
    ]
    static let themesTitle = ["FLAGS", "VEHICLES", "WEATHER"]
    
    static let themeColor = [Color.green, Color.red, Color.cyan]
    
    static let randomTheme = Int.random(in: 0...2)
    
    static let randomNumberOfCards = Int.random(in: 0..<10)
    
    @State var content: [String] = themes[randomTheme].shuffled()
    @State var title: String = themesTitle[randomTheme]
    @State var titleColor = themeColor[randomTheme]
    @State var numberOfCards = randomNumberOfCards
    
    
    var body: some View {
        
        
        VStack {
            Text("\(title)")
               .padding(.bottom)
               .foregroundColor(titleColor)
               .font(.largeTitle)
               .bold()
               .underline()
               .padding(.vertical)
               
           
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]){
                    ForEach(0...numberOfCards, id: \.self) {emoji in
                        Card(content: content[emoji], color: titleColor)
                    }
                }
            }
            
            themeButtonsView
            
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    
    
    
    var themeButtonsView: some View {
        HStack {
            
            Button{
                title = ContentView.themesTitle[0]
                titleColor = ContentView.themeColor[0]
                content = ContentView.themes[0].shuffled()
                numberOfCards = Int.random(in: 0..<10)
                
            } label: {
                VStack {
                    Image(systemName: "flag").font(.largeTitle)
                    Text ("Flags")
                }
                
            }
            .foregroundColor(ContentView.themeColor[0])
            
            Spacer()
            
            Button{
                title = ContentView.themesTitle[1]
                titleColor = ContentView.themeColor[1]
                content = ContentView.themes[1].shuffled()
                numberOfCards = Int.random(in: 0..<10)
            } label: {
                VStack {
                    Image(systemName: "car").font(.largeTitle)
                    Text ("Vehicles")
                }
                
            }
            .foregroundColor(ContentView.themeColor[1])
            
            Spacer()
            
            Button{
                title = ContentView.themesTitle[2]
                titleColor = ContentView.themeColor[2]
                content = ContentView.themes[2].shuffled()
                numberOfCards = Int.random(in: 0..<10)
                
            } label: {
                VStack {
                    Image(systemName: "sun.max").font(.largeTitle)
                    Text ("Weather")
                }
            }
            .foregroundColor(ContentView.themeColor[2])
        }
        .padding(.horizontal)
    }
    
}













struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
