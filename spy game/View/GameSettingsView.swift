//
//  GameSettingsview.swift
//  spy game
//
//  Created by Елисей on 06.01.2021.
//

import SwiftUI

struct GameSettingsView: View {
    @State var numberOfPlayers = 3
    @State var numberOfSpies = 1
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Stepper("Number of players", value: $numberOfPlayers, in: 3...10)
                        .padding()
                    
                    Text("\(numberOfPlayers)")
                }
                
                HStack {
                    Stepper("Number of spies", value: $numberOfSpies, in: 1...2)
                        .padding()
                    
                    Text("\(numberOfSpies)")
                }
            }
            
            Spacer()
            
            NavigationLink("Start Game", destination: GameView(viewModel: ViewModel(numOfPlayers: numberOfPlayers)))
        }
        
    }
}

struct GameSettingsview_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingsView()
    }
}
