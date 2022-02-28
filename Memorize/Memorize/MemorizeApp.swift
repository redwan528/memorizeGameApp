//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Redwan Khan on 25/08/2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
   private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
           EmojiMemoryGameView(game: game)
          
        }
    }
} 
