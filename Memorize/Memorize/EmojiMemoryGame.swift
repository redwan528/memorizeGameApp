//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Redwan Khan on 13/09/2021.
//

import SwiftUI

 

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card 
 
    private static var emojis = faces
   private static var faces = ["ð", "ð", "ðĨ°", "ðĪŠ", "ðķâðŦïļ", "ðķ", "ðĪŽ", "ðĪŊ", "ðĢ", "ð", "ð","ð"]
    private static var halloween = ["ðŧ", "ð", "â ïļ", "ð―", "ð","ð", "ðļ","ð·"]
    private static var animal = ["ðĶ","ðķ","ðĶ","ð°","ðą","ðŊ","ðŧ","ðž","ðŧââïļ", "ðĶ"]
    private static var cars = ["ð","ð", "ð", "ð", "ð", "ð", "ð", "ð","ð","ð"]
    private static var deserts = ["ð","ðĐ", "ð§", "ð°","ðŠ","ðŦ", "ðĶ","ð­","ðĻ","ðŽ"]
    private static var food = [ "ð", "ð", "ðĪ", "ð", "ðŪ", "ðŋ", "ð­","ðĨĐ","ðĨĻ","ðĨŠ"]
    //static here means its the same for all instances of EmojiMemoryGame, not for anybody else.
   
    
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    
     static var allThemes = [EmojiMemoryGame.faces, EmojiMemoryGame.halloween, EmojiMemoryGame.animal, EmojiMemoryGame.cars, EmojiMemoryGame.deserts, EmojiMemoryGame.food]
    
    private static var allColors = [Color.red,Color.orange,Color.green,Color.purple,Color.pink,Color.yellow]
    
     static var allNames = ["faces","halloween", "animal","cars","deserts","food"]
    
    private static var allNums = [12,8,8,10,10,10]
    
    
   //static var score = 0
    //static var matched = false
    //static var score = 0
    
   static var currentTheme = 0
    
    static var currentThemeName = 0
    
     static func getThemeColor() -> Color {
        return EmojiMemoryGame.allColors[EmojiMemoryGame.currentTheme]
    }
    
    static func getThemeName() -> String {
        return EmojiMemoryGame.allNames[EmojiMemoryGame.currentThemeName]
    }
    
    //static func getScore() -> Int {
     //   return score
    //}
    

    private static func createMemoryGame() -> MemoryGame<String> {
        
        EmojiMemoryGame.currentTheme = Int.random(in: 0..<(EmojiMemoryGame.allThemes.count))
        
        
        if currentTheme == 0 {
            
            currentThemeName = 0
            
            //Text("Memorize!").font(.title).fontWeight(.medium).foregroundColor(.red)
            faces.shuffle()
            return MemoryGame<String>(numberOfPairsOfCards: EmojiMemoryGame.allNums[EmojiMemoryGame.currentTheme]) { pairIndex in EmojiMemoryGame.faces[pairIndex]} //creates one type of card
        }
        
       else if currentTheme == 1 {
        // error message: pairIndex = (Int) 8
        halloween.shuffle()
        return  MemoryGame<String>(numberOfPairsOfCards: EmojiMemoryGame.allNums[EmojiMemoryGame.currentTheme]) { pairIndex in EmojiMemoryGame.halloween[pairIndex]} //creates one type of card
        }
       else if currentTheme == 2 {
        animal.shuffle()
          return  MemoryGame<String>(numberOfPairsOfCards: EmojiMemoryGame.allNums[EmojiMemoryGame.currentTheme]) { pairIndex in EmojiMemoryGame.animal[pairIndex]} //creates one type of card
        }
        
       else if currentTheme == 3 {
        cars.shuffle()
          return  MemoryGame<String>(numberOfPairsOfCards: EmojiMemoryGame.allNums[EmojiMemoryGame.currentTheme]) { pairIndex in EmojiMemoryGame.cars[pairIndex]} //creates one type of card
        }
        
        
        if currentTheme == 4 {
            deserts.shuffle()
          return  MemoryGame<String>(numberOfPairsOfCards: EmojiMemoryGame.allNums[EmojiMemoryGame.currentTheme]) { pairIndex in EmojiMemoryGame.deserts[pairIndex]} //creates one type of card
        }
        if currentTheme == 5 {
            //err message: pairIndex = (Int) 10
            food.shuffle()
          return  MemoryGame<String>(numberOfPairsOfCards: EmojiMemoryGame.allNums[EmojiMemoryGame.currentTheme]) { pairIndex in EmojiMemoryGame.food[pairIndex]} //creates one type of card
        }
        else{
            return MemoryGame<String>(numberOfPairsOfCards: EmojiMemoryGame.allNums[EmojiMemoryGame.currentTheme]) { pairIndex in EmojiMemoryGame.emojis[pairIndex]} //creates one type of card
        }
        
    }

   // private static func score () -> MemoryGame<Int> {
     
        
       // return MemoryGame<Int>.
        
   // }
  
 
    var cards: [Card]{
        return model.cards //returns back the copy of the cards
    }
    
  
    
    //var score edit
    var score: Int {
        return model.score
    }
    //job of the view model is to create a set of functions
    //MARK: - Intent(s)
    
    func choose(_ card: Card){
        model.choose(card)
        
   
    }
    
    func newGame(){
        model = EmojiMemoryGame.createMemoryGame() //resets game
        //EmojiMemoryGame.allThemes
    }
 
    // func score(){
     //   if EmojiMemoryGame.matched {
     //       EmojiMemoryGame.getScore()
     //   }
   // }
    
    
    func clearAllCards(){
        
        model.clear()
    
    }
 
     func shuffle(){
        model.shuffle()
       
        
       
        
    }
    
    
}
