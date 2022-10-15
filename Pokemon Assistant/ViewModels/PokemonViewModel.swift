//
//  PokemonViewModel.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 1/17/22.
//

import Foundation
import UIKit.UIImage
import Charts

public class PokemonViewModel {
    
    let pokemon: Box<Pokemon?> = Box(nil)
    let allPokemon: Box<AllPokemon?> = Box(nil)
    let pokeRequest: PokemonRequest?
    let title = Box("")
    
    let nextID: Box<Int?> = Box(nil)
    let prevID: Box<Int?> = Box(nil)
    let stats: Box<BarChartDataSet> = Box(BarChartDataSet())
    let types: Box<[String]> = Box([])
    let numberLabel = Box("")
    
    let image: Box<UIImage?> = Box(nil)
    
    init(for pokeSearch: String) {
        pokeRequest = PokemonRequest(for: pokeSearch)
    }
    
    func getAllPokemon() {
        pokeRequest?.fetchAllPokemon(completion: { [weak self]  (pokemonData) in
//            guard let self = self, let pokemonData = pokemonData else { return }
            self?.allPokemon.value = pokemonData
//            print("FROM VIEW MODEL ALL: \(pokemonData)")
        })
    }
    
    func getPokemon(for pokeSearch: String) {
        pokeRequest?.fetchPokemon(for: pokeSearch, completion: { [weak self] (pokemonData, error) in
            guard let self = self, let pokemonData = pokemonData else { return }
            self.pokemon.value = pokemonData
            self.numberLabel.value = String("#\(pokemonData.id!)")
            let localImageURL = URL(string: pokemonData.sprites.front_default)
            let imageData = try? Data(contentsOf: localImageURL!)
            
            self.image.value = UIImage(data: imageData!)
            self.title.value = pokemonData.species.name.capitalized
            self.types.value = pokemonData.types.map { $0.type.name }
            var dataEntries = [BarChartDataEntry]()
            let reverseIndex = [5,4,3,2,1,0]
            for i in 0..<reverseIndex.count {
                dataEntries.append(BarChartDataEntry(x: Double(i), y: Double(pokemonData.stats[reverseIndex[i]].base_stat)))
            }
            self.stats.value = BarChartDataSet(entries: dataEntries, label: "")
            if pokemonData.id! == 1 {
                self.nextID.value = pokemonData.id! + 1
                self.prevID.value = pokemonData.id!
            } else {
                self.nextID.value = pokemonData.id! + 1
                self.prevID.value = pokemonData.id! - 1
            }
            
        })
    }
    
}
