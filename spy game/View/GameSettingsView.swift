//
//  GameSettingsview.swift
//  spy game
//
//  Created by Елисей on 06.01.2021.
//

import SwiftUI

struct GameSettingsView: View {
    @ObservedObject var viewModel = ViewModel()
    
    init() {
        viewModel = ViewModel()
        viewModel.setupGame()
    }
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Stepper("Number of players", value: $viewModel.numberOfPlayers, in: 3...10)
                        .padding()
                        .onChange(of: viewModel.numberOfPlayers, perform: { _ in
                            viewModel.makeCardsToShowEmpty()
                            viewModel.setupGame() // look very inefficient
                        })
                    
                    Text("\(viewModel.numberOfPlayers)")
                }
                
                HStack {
                    Stepper("Number of spies", value: $viewModel.numberOfSpies, in: 1...2)
                        .disabled(isSpyStepperDisabled())
                        .padding()
                        .onChange(of: viewModel.numberOfSpies, perform: { _ in
                            viewModel.makeCardsToShowEmpty()
                            viewModel.setupGame()  // look very inefficient
                        })
                    
                    Text("\(viewModel.numberOfSpies)")
                }
            }
            
            Spacer()
            
            // FIXME: - make new game on tap nav link
            NavigationLink("Start Game",
                           destination: GameView(viewModel: viewModel))
        }
        
    }
    
    private func reduceSpies() {
        if viewModel.numberOfPlayers < 6 && viewModel.numberOfSpies == 2 {
            viewModel.numberOfSpies = 1
        }
    }
    
    private func isSpyStepperDisabled() -> Bool {
        reduceSpies()
        return viewModel.numberOfPlayers < 6
    }
}

struct GameSettingsview_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingsView()
    }
}
