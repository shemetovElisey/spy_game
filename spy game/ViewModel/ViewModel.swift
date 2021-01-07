//
//  ViewModel.swift
//  spy game
//
//  Created by Елисей on 06.01.2021.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var players = [CardView]()
    @Published var numberOfPlayers = 3
    @Published var numberOfSpies = 1
    @Published private(set) var currentLocation = Location()
    
    init(numOfPlayers: Int, andSpies spies: Int) {
        numberOfPlayers = numOfPlayers
        numberOfSpies = spies
        setupGame()
    }
    
    init() {}
    
    let locations = [
        Location("Theater", roles: ["actor", "producer", "music director", "lighting designer", "composer",  "choreographer", "visitor", "cleaner", "director"]),
        Location("University", roles: ["student", "teacher", "lecture", "professor", "researher", "admin", "expelled student", "excellent student", "cleaner"])
    ]
    
    public func setupGame() {
        players = []
        currentLocation = locations.randomElement()!
        var roles = currentLocation.roles.shuffled()
        
        for _ in 0..<numberOfPlayers-1 {
            players.append(CardView(player: Player(location: currentLocation.name,
                                                   role:     roles.popLast()!)))
        }
        players.append(CardView(player: Player(isSpy: true)))
        players.shuffle()
    }
}
