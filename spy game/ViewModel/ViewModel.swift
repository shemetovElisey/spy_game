//
//  ViewModel.swift
//  spy game
//
//  Created by Елисей on 06.01.2021.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    var players = [CardView]()
    private(set) var currentLocation = Location()
    
    @Published var numberOfPlayers = 3
    @Published var numberOfSpies = 1
    @Published var cardsToShow = [CardView]()
    
    var lastShownCardIndex = 1
    
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
        var lplayers: [Player] = []
        players = []
        currentLocation = locations.randomElement()!
        var roles = currentLocation.roles.shuffled()
        
        for _ in 0..<numberOfPlayers-numberOfSpies {
            lplayers.append(Player(location: currentLocation.name, role: roles.popLast()!))
        }
        
        for _ in 0..<numberOfSpies {
            lplayers.append(Player(isSpy: true))
        }
        
        lplayers.shuffle()
        
        for num in 0..<numberOfPlayers {
            players.append(CardView(player: lplayers[num], playerNumber: num+1))
        }
        
        cardsToShow.append(players[0])
        cardsToShow.append(players[1])
    }
    
    public func changeCard() {
        lastShownCardIndex += 1
        
        if lastShownCardIndex < players.count {
            cardsToShow.removeFirst()
            players[lastShownCardIndex].isFlipped.toggle()
            cardsToShow.append(players[lastShownCardIndex])
        } else {
            lastShownCardIndex = 0
            cardsToShow.removeFirst()
            players[lastShownCardIndex].isFlipped.toggle()
            cardsToShow.append(players[lastShownCardIndex])
        }
    }
    
    public func makeCardsToShowEmpty() {
        cardsToShow = []
    }
}
