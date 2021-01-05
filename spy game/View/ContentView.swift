//
//  ContentView.swift
//  spy game
//
//  Created by Елисей on 06.01.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink("Start Game", destination: GameSettingsView())
                .foregroundColor(.white)
                .font(.title)
                .padding()
                .background(Color.green)
                .cornerRadius(40)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
