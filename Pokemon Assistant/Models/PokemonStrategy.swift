//
//  PokemonStrategy.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/21/21.
//

import Foundation

struct PokemonStrategy: Codable {
    var pokemon: [AttackPokemon]
}

struct AttackPokemon: Codable {
    var pokemon: SpecificPokemon
}

struct SpecificPokemon: Codable {
    var name: String?
    var url: String?
}
