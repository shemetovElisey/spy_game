//
//  LocationModel.swift
//  spy game
//
//  Created by Елисей on 06.01.2021.
//

import Foundation

struct Location: Identifiable {
    let id = UUID()
    
    let name: String
    var roles: [String]
    
    init() {
        name = ""
        roles = []
    }
    
    init(_ name: String, roles: [String]) {
        self.name  = name
        self.roles = roles
    }
}
