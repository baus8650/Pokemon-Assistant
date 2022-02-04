//
//  TypeViewModel.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 1/17/22.
//

import Foundation

public class TypeViewModel {
    
    let typeRequest: TypeRequest?
    
    var type: Box<Relations?> = Box(nil)
    var weakTo: Box<[PokemonType]?> = Box([])
    var strongAgainst: Box<[PokemonType]?> = Box([])
    var halfResistant: Box<[PokemonType]?> = Box([])
    var halfEffective: Box<[PokemonType]?> = Box([])
    var fullyResistant: Box<[PokemonType]?> = Box([])
    var noEffect: Box<[PokemonType]?> = Box([])
    var tableData: Box<[[PokemonType]]> = Box([[]])
    var sections: Box<[String]> = Box([])
    
    init(for typeSearch: String) {
        typeRequest = TypeRequest(for: typeSearch)
    }
    
    func getType(for typeSearch: String) {
        typeRequest?.fetchType(for: typeSearch, completion: { [weak self] (typeData, error) in
            guard let self = self, let typeData = typeData else { return }
            self.type.value = typeData
            self.weakTo.value = typeData.damage_relations.double_damage_from
            self.strongAgainst.value = typeData.damage_relations.double_damage_to
            self.halfResistant.value = typeData.damage_relations.half_damage_from
            self.halfEffective.value = typeData.damage_relations.half_damage_to
            self.fullyResistant.value = typeData.damage_relations.no_damage_from
            self.noEffect.value = typeData.damage_relations.no_damage_to
            self.tableData.value = [self.weakTo.value!, self.strongAgainst.value!,self.halfResistant.value!,self.halfEffective.value!, self.fullyResistant.value!, self.noEffect.value!]
            self.sections.value = ["Weak To", "Strong Against", "Half Resistant To", "Half Effective To", "Fully Resistant To", "No Effect"]
            
        })
    }
}
