//
//  Pokemon.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/16/21.
//

import Foundation

struct Pokemon: Codable {
    
    var species: Species
    var types: [Types]
    var sprites: Sprites
//    var sprites: Sprites
}
