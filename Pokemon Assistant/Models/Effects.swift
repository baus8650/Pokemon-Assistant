//
//  Relations.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/16/21.
//

import Foundation

struct Effects: Codable {
    var double_damage_from: [PokemonType]
    var double_damage_to: [PokemonType]
    var half_damage_from: [PokemonType]
    var half_damage_to: [PokemonType]
    var no_damage_from: [PokemonType]
    var no_damage_to: [PokemonType]
}


// double_damage_from = weakness
// double_damage_to = strong against
// half_damage_from = half resistant to
// half_damage_to = weak against
// no_damage_from = fully resistant to
// no_damage_to = no effect
