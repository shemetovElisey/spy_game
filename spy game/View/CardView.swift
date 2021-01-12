//
//  CardView.swift
//  spy game
//
//  Created by Елисей on 08.01.2021.
//

import SwiftUI

struct CardView: View {
    @State var isFlipped = false
    @State var player: Player

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(!isFlipped ? .black : .red)
                .padding()
                .onTapGesture {
                    self.isFlipped.toggle()
                }
            
            VStack {
                if player.isSpy {
                    Text("You are a Spy!!!")
                        .font(.title)
                        .bold()
                } else {
                    Text(player.location)
                        .font(.title)
                        .bold()
                    
                    Text(player.role)
                        .font(.title2)
                }
                
            }
            // FIXME: - make text flip animation more smooth
            .foregroundColor(!isFlipped ? .init(CGColor(gray: 0, alpha: 0)) : .white)
            .animation(.easeInOut)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
        .rotation3DEffect(self.isFlipped ? Angle(degrees: 180) : Angle(degrees: 0),
                          axis: (x: CGFloat(0),
                                 y: CGFloat(10),
                                 z: CGFloat(0)
                          )
        )
        .animation(.default)
        
    }
}
