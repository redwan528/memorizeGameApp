//
//  MemoryGame.swift
//  Memorize
//
//  Created by Redwan Khan on 13/09/2021.
//

import Foundation
import SwiftUI
//<CardContent> is a generic

struct MemoryGame<CardContent> where CardContent: Equatable {//generic
    
    private(set) var cards: Array<Card>
    private(set) var score = 0
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        
        get{
             cards.indices.filter({cards[$0].isFaceUp}).oneAndOnlyElementIndex //return is implied cuz its a get
            //  return faceUpIndices.oneAndOnlyElementIndex
            //this getter says "get the cards from array, get all indicies, filter from them, the cards that r face up, then return to me the oneAndOnlyElementIndex. otherwise say it's nil
        }
        
        set{
            cards.indices.forEach{cards[$0].isFaceUp = ($0 == newValue)} //closure
        
        }
    }
    
   mutating func choose(_ card: Card){
    if let chosenIndex = cards.firstIndex(where: {$0.id == card.id }), !cards[chosenIndex].isFaceUp,
        !cards[chosenIndex].isMatched{
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
            if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                score += 1 //edit
            }
           // indexOfTheOneAndOnlyFaceUpCard = nil
            cards[chosenIndex].isFaceUp=true
        } else{
            
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
      // cards[chosenIndex].isFaceUp.toggle()
      
    }
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    //mutating func randomize(){
    //    cards.shuffle()
   // }
    
   // mutating func randomizeTheme(){
     //   cards.shuffle()
   // }
    
    mutating func clear(){
        cards.removeAll()
         
    }
    
 
    
  
    init(numberOfPairsOfCards: Int, createCardContent: (Int)->CardContent){
        cards=Array<Card>()
        // add numberOfPairsOfCards * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards{ //numberOfPairsOfCards EmojiMemoryGame.allThemes.count
            let myContent: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: myContent, id: pairIndex*2))
            cards.append(Card(content: myContent, id: pairIndex*2+1))
            
        }
        cards.shuffle()
    
    }
    
   

    struct Card: Identifiable{

        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
        let id: Int
    }
    
   
}


extension Array{ //extensions can do things to arrays, like reverse it, add stuff in, etc
    var oneAndOnlyElementIndex: Element? { //cannot be stored variable within extension therefore we make this into a computed variable. '?' makes it optional variable
        if self.count == 1{
            return self.first
        } else{
            return nil
        }
    }
}
