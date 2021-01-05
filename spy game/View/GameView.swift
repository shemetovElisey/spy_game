//
//  GameView.swift
//  spy game
//
//  Created by Елисей on 06.01.2021.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        List {
            ForEach(viewModel.players) { player in
                HStack {
                    if !player.isSpy {
                        Text("\(player.location), \(player.role)")
                    } else {
                        Text("You are a spy!")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: ViewModel(numOfPlayers: 3))
    }
}
