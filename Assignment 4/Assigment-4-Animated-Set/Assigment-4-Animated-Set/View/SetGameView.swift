//
// SetGameView.swift
//  Assigment-4-Animated-Set
//
//  Created by Kevin Martinez on 7/23/23.
//

import SwiftUI

struct SetGameView: View {
    
    typealias Card = SetGameModel<SetCardContent>.Card
    
    @ObservedObject var game: GameViewModel
    
    @Namespace private var dealingNameSpace
    
    @Namespace private var discartPile
    
    @State private var gameStarted = false
    
    @State private var dealt = Set<Int>()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                gameProgression.padding(.vertical)
                    .frame(height: 90)
                
                Divider()
                
                gameBody.padding(.horizontal)
                
                
             decksContainer
                
            }
            
            
            
            .toolbar() {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("New Game") {
                        game.newGame()
                        dealt = []
                        gameStarted = false
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Shuffle") {
                        
                        
                        game.shuffleCards()
                        dealt = []
                        gameStarted = false
                        
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .fontWeight(.bold)
            .padding(.top)
        }
    }
    
    
   
    
    
    private func deal(_ card: Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt (_ card: Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: Card) -> Animation {
        var delay = 0.0
        
        if let index = game.cardsInPlay.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (0.5 / Double(game.cardsInPlay.count))
        }
        
        return Animation.easeInOut(duration: 0.5).delay(delay)
    }
    
    
    private func delayFlip(for card: Card) -> Animation {
        var delay = 0.0
        
        if let index = game.cardsInPlay.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (1 / Double(game.cardsInPlay.count))
        }
        
        return Animation.easeInOut(duration: 0.5).delay(delay)
    }
    
    
    private func zIndex(_ array: [Card], of card: Card) -> Double {
        -Double(array.firstIndex(where: { $0.id == card.id}) ?? 0)
    }
    
  
    
    var decksContainer: some View {
        HStack {
            Spacer()
            decksBody
            Spacer()
            discartDeck
            Spacer()
        }
    }
    
    
    var gameBody: some View {
        
       
            AdaptiveStack(game: game, items: game.cardsInPlay, aspectRatio: 2/3) { card in
                if isUndealt(card) {
                    Color.clear
                } else {
                    
                    CardView(card: card)
                        
                        .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                        .matchedGeometryEffect(id: card.id, in: discartPile)
                        .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                        .padding(4)
                        .zIndex(zIndex(game.cardsInPlay, of: card))
                        .onTapGesture {
                            
                            withAnimation (Animation.easeInOut) {
                                game.choose(card)
                                
                            }
                            
                        }
                        .onAppear {
                            
                            withAnimation(delayFlip(for: card)) {
                                game.flipCard(card)
                            }
                            
                        }
                }
            }
    }
    
    
    
    
    
    var decksBody: some View {
        
        ZStack {
            ForEach(game.cardsInPlay.filter(isUndealt)) { card in
                
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(game.cardsInPlay, of: card))
                    
            }
        }
 
        .frame(
            width: CardConstants.undealWidth,
            height: CardConstants.undealHeight)
        
        .onTapGesture {
            
            if !gameStarted {
                for card in game.cardsInPlay {
                    withAnimation(dealAnimation(for: card)) {
                        
                        deal(card)
                        
                    }
                }
                
                game.deal3Cards()
                gameStarted = true
                
            } else {
                
                for card in game.cardsInPlay.suffix(3) {
                    withAnimation(dealAnimation(for: card)) {
                        deal(card)
                    }
                }
                
                game.deal3Cards()
            }
        }
    }
    
    
    
    var discartDeck: some View {
        
        ZStack {
            ForEach(game.matchedCards) { card in
                
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: discartPile)
                    .zIndex(zIndex(game.matchedCards, of: card))
            }
        }
        .frame(
            width: CardConstants.undealWidth,
            height: CardConstants.undealHeight)
    }
    
    
    
    var gameProgression: some View {
        
        Group {
            VStack(alignment: .center) {
                
                HStack {
                    
                    
                    VStack(spacing: 10) {
                        Text("Score: ")
                        Text("\(game.playerPoints)")
                            .animation(Animation.easeInOut, value: game.playerPoints)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        Text("Sets: ")
                        Text("\(game.numberOFCardSetsFounded) / 27")
                            .animation(Animation.easeIn, value: game.numberOFCardSetsFounded)
                        
                    }
                    
                    Spacer()
                    
                    ProgressView(value: game.numberOfMatchedCards, total: 81)
                        .progressViewStyle(CircularProgressViewStyle())
                        .animation(Animation.easeInOut, value: game.numberOfMatchedCards)
                    
                }
                .fontWeight(.bold)
                .padding(.horizontal)
            }
            .padding()
            
        }
        
    }
    
    
    
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration : Double = 2
        static let undealHeight: CGFloat = 135
        static let undealWidth = undealHeight * aspectRatio
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
