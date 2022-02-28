//
//  Cardify.swift
//  Memorize
//
//  Created by Redwan Khan on 11/11/2021.
//

import Foundation
import SwiftUI

struct Cardify : AnimatableModifier {
    var rotation: Double // rotation in degrees
    
    var animatableData: Double {
        get{
            rotation
        }
        set{
            rotation = newValue
        }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            
            
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            }
            else {
                RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                    .fill()
            }
            content
                .opacity(rotation<90 ? 1 : 0)

        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1.0, z: 0))
        
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10.0 //need to specify CGFloat otherwise it will think its a double
        static let lineWidth: CGFloat = 3
   
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
