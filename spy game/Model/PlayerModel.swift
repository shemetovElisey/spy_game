//
//  PlayerModel.swift
//  spy game
//
//  Created by Елисей on 06.01.2021.
//

import Foundation

struct Player: Identifiable {
    var id = UUID()
    
    let location: String
    let role: String
    let isSpy: Bool
    
    init(isSpy: Bool) {
        self.isSpy = isSpy
        self.role = ""
        self.location = ""
    }
    
    init(location: String, role: String) {
        self.role = role
        self.isSpy = false
        self.location = location
    }
}
