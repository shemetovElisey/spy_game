//
//  ViewModel.swift
//  spy game
//
//  Created by Елисей on 06.01.2021.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var players = [Player]()
    @Published private(set) var numberOfPlayers = 3
    @Published private(set) var currentLocation = Location()
    
    init(numOfPlayers: Int) {
        numberOfPlayers = numOfPlayers
        setupGame()
    }
    
    init() {}
    
    let locations = [
        Location("Theater", roles: ["actor", "producer", "music director", "lighting designer", "composer",  "choreographer", "visitor", "cleaner", "director"]),
        Location("University", roles: ["student", "teacher", "lecture", "professor", "researher", "admin", "expelled student", "excellent student", "cleaner"])
    ]
    
    public func setupGame() {
        currentLocation = locations.randomElement()!
        var roles = currentLocation.roles.shuffled()
        
        for _ in 0..<numberOfPlayers-1 {
            players.append(Player(location: currentLocation.name,
                                  role:     roles.popLast()!))
        }
        players.append(Player(isSpy: true))
        players.shuffle()
    }
    
    public func setNumberOfPlayers(_ num: Int) {
        numberOfPlayers = num
    }
}
