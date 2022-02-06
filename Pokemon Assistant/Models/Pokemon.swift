//
//  Pokemon.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/16/21.
//

import Foundation

struct AllPokemon: Codable {
    var results: [Species]
}

struct Pokemon: Codable {
    
    var species: Species
    var types: [Types]
    var sprites: Sprites
    var stats: [Stat]
    var id: Int?

}

struct Species: Codable {
    var name: String
    var url: String
}

struct Sprites: Codable {
    var front_default: String
}

struct Stat: Codable {
    var base_stat: Int
    var stat: [String: String]
}
