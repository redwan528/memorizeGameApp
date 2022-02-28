//
//  ContentView.swift
//  Memorize
//
//  Created by Redwan Khan on 25/08/2021.
//sdffsdf
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @State private var newGameButton = false

    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNameSpace
   
    var body: some View {
        
        if EmojiMemoryGame.currentTheme == 0 {
            
            Text("Faces").font(.title).fontWeight(.medium).foregroundColor(.red)
        }
        
            if EmojiMemoryGame.currentTheme == 1 {
                Text("Halloween").font(.title).fontWeight(.medium).foregroundColor(.orange)
            }
            if EmojiMemoryGame.currentTheme == 2 {
                Text("Animals").font(.title).fontWeight(.medium).foregroundColor(.green)
            }
            if EmojiMemoryGame.currentTheme == 3 {
                Text("Cars").font(.title).fontWeight(.medium).foregroundColor(.purple)
            }
            if EmojiMemoryGame.currentTheme == 4 {
                Text("Deserts").font(.title).fontWeight(.medium).foregroundColor(.pink)
            }
            if EmojiMemoryGame.currentTheme == 5 {
                Text("Foods").font(.title).fontWeight(.medium).foregroundColor(.yellow)
            }
      
        VStack{
            gameBody
            deckBody
            shuffle
        }
        .padding()
       
   

                    Spacer()
        
            Button(action: {
               newGameButton.toggle()
                if newGameButton {
                   
                    game.newGame()
              
                    game.shuffle()
                    
            
                }
        
            }, label:{
              
                Text("New Game").fontWeight(.bold).foregroundColor(.red)
          
            })
        
       
 
            Spacer()
      
 
    }
    
    var gameBody: some View {
        
        AspectVGrid(items: game.cards, aspectRatio: DrawingConstants.aspectRatio) {card in
        cardView(for: card)
    }
    .foregroundColor(EmojiMemoryGame.getThemeColor())
.padding(.horizontal)

    }
    
    var deckBody: some View {
        ZStack{
            ForEach(game.cards.filter { isUndealt($0) }) { card in
                CardView(card)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)

            }
        }

        .frame(width: DrawingConstants.undealtWidth, height: DrawingConstants.undealtHeight)
        .foregroundColor(EmojiMemoryGame.getThemeColor())
        .onTapGesture{
        //"deal" the cards
            //withAnimation(.easeInOut(duration: 5)){
                for card in game.cards {
                    withAnimation(dealAnimation(for: card)){
                    deal(card)
                    }
                    
            }

        }
    }
    
    var shuffle: some View {
        Button("Shuffle"){
            withAnimation(.easeInOut(duration: 0.3)){
                game.shuffle()
            }
        }
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
            Color.clear
        }
        else {
            CardView(card)
                .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                
                .padding(4)
              
                .onTapGesture {
                    withAnimation{//}(.easeInOut(duration: 0.5)){
                        game.choose(card)
                    }
                    
                }
            
        }
        
   
    }
    
    @State private var dealt = Set<Int>() // recall set is like an array, if u have the same card mulitple times for example it will only show once
    
    
    private func deal(_ card: EmojiMemoryGame.Card){
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (DrawingConstants.dealDuration / Double(game.cards.count))
        }
        return Animation
            .easeInOut(duration: DrawingConstants.dealDuration)
            .delay(delay)
    }

}

private struct DrawingConstants {
    static let cornerRadius: CGFloat = 10.0 //need to specify CGFloat otherwise it will think its a double
    static let color = Color.red
    static let lineWidth: CGFloat = 3
    static let fontSize: CGFloat = 32
    static let aspectRatio: CGFloat = 2/3
    static let fontScale: CGFloat = 0.7
    static let circlePadding: CGFloat = 6
    static let circleOpacity: Double = 0.5
    static let undealtHeight: CGFloat = 90
    static let undealtWidth = undealtHeight * aspectRatio
    static let dealDuration: Double = 0.5
    static let totalDealDuration: Double = 2.0
}

        struct CardView: View {
         
            
            private let card: EmojiMemoryGame.Card //different instance,
            
            init(_ card: EmojiMemoryGame.Card){
                self.card = card
            }
    
            var body: some View{
                GeometryReader { geometry in
                    ZStack {
          
                            Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 20), clockwise: false) 
                                .padding(DrawingConstants.circlePadding).opacity(DrawingConstants.circleOpacity)
                            Text(card.content)
                                .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                                .animation(Animation.linear(duration: 2))
                                            //.repeatForever(autoreverses: false))
                                .font(Font.system(size: DrawingConstants.fontSize))
                                .scaleEffect(scale(thatFits: geometry.size))
                        
                    }
                    .cardify(isFaceUp: card.isFaceUp)
                }
          
            }
    
            
            private func scale(thatFits size: CGSize) -> CGFloat {
                min(size.width, size.height) / (DrawingConstants.fontSize/DrawingConstants.fontScale)
            }
            
     
            
        }
     
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
   
         EmojiMemoryGameView(game: game).preferredColorScheme(.dark)
        //EmojiMemoryGameView(game: game).preferredColorScheme(.light)
        //sfjvfjkfvjkndjkfnvdfjnkv

    }

 }

