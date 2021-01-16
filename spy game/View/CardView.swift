//
//  CardView.swift
//  spy game
//
//  Created by Елисей on 08.01.2021.
//

import SwiftUI

struct CardView: View, Identifiable {
    var id = UUID()
    
    @State var isFlipped = false
    @State var player: Player
    
    var playerNumber: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(!isFlipped ? .black : .red)
                .padding()
                .onTapGesture {
                    self.isFlipped.toggle()
                }
            
            VStack {
                if isFlipped {
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
                } else {
                    Text("Player №\(playerNumber)")
                        .font(.title)
                        .bold()
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                }
                
            }
            .foregroundColor(.white)
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
