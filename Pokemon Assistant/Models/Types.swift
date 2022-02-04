//
//  Types.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/16/21.
//

import Foundation

struct Types: Codable {
    var type: PokemonType
}

struct PokemonType: Codable {
    var name: String
    var url: String
}

struct Effects: Codable {
    var double_damage_from: [PokemonType]
    var double_damage_to: [PokemonType]
    var half_damage_from: [PokemonType]
    var half_damage_to: [PokemonType]
    var no_damage_from: [PokemonType]
    var no_damage_to: [PokemonType]
}

struct Relations: Codable {
    var damage_relations: Effects
}
