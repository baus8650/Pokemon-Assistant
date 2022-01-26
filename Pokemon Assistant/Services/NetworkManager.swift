//
//  NetworkManager.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 1/17/22.
//

import Foundation

//extension Bundle {
//
//    enum searchType {
//        case pokemon
//        case type
//    }
//
//    func decode<T: Decodable>(for search: String?, searchType: searchType) -> T {
//
//        var urlString: String
//        switch searchType {
//        case .pokemon:
//            let pokemonViewModel = PokemonViewModel(for: search ?? "charmander")
//            urlString = "https://pokeapi.co/api/v2/pokemon/\(search ?? "charmander")"
//            let url = URL(string: urlString)!
//
//            guard let data = try? Data(contentsOf: url) else {
//                fatalError("Failed to load projects.json in app bundle.")
//            }
//
//            let decoder = JSONDecoder()
//
//            guard let loaded = try? decoder.decode(T.self, from: data) else {
//                fatalError("Failed to decode projects.json from app bundle.")
//            }
//
//            pokemonViewModel.pokemon?.value = loaded as! Pokemon
//            return loaded
//        case .type:
//            let typeViewModel = TypeViewModel()
//            urlString = "https://pokeapi.co/api/v2/type/\(search ?? "normal")"
//            let url = URL(string: urlString)!
//
//            guard let data = try? Data(contentsOf: url) else {
//                fatalError("Failed to load projects.json in app bundle.")
//            }
//
//            let decoder = JSONDecoder()
//
//            guard let loaded = try? decoder.decode(T.self, from: data) else {
//                fatalError("Failed to decode projects.json from app bundle.")
//            }
//
//            typeViewModel.type?.value = loaded as! Relations
//
//            return loaded
//        }
//
//    }
//}

class PokemonRequest:  NSObject {
    
    private var pokeSearch: String
    private let url: URL
    
    enum PokemonFetchError: Error {
        case invalidResponse
        case noData
        case failedRequest
        case invalidData
    }
    
    
    init(for pokemon: String?) {
        self.pokeSearch = pokemon ?? "charmander"
        self.url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(self.pokeSearch)")!
    }
    
    func fetchPokemon(for pokeSearch: String, completion: @escaping (Pokemon?, PokemonFetchError?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    print("Failed to fetch Pokémon: \(error!.localizedDescription)")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No data returned from pokeAPI")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                  print("Unable to process Pokémon response")
                  completion(nil, .invalidResponse)
                  return
                }
                
                guard response.statusCode == 200 else {
                  print("Failure response from pokeAPI: \(response.statusCode)")
                  completion(nil, .failedRequest)
                  return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let pokemonData: Pokemon = try decoder.decode(Pokemon.self, from: data)
                    completion(pokemonData, nil)
                } catch {
                    print("Unable to decode Pokémon response: \(error.localizedDescription)")
                    completion(nil, .invalidData)
                }
            }
        }.resume()
    }
    
}

class TypeRequest:  NSObject {
    
    private var typeSearch: String
    private let url: URL
    
    enum TypeRequestError: Error {
        case invalidResponse
        case noData
        case failedRequest
        case invalidData
    }
    
    
    init(for type: String?) {
        self.typeSearch = type ?? "normal"
        self.url = URL(string: "https://pokeapi.co/api/v2/type/\(self.typeSearch)")!
    }
    
    func fetchType(for typeSearch: String, completion: @escaping (Relations?, TypeRequestError?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    print("Failed to fetch type: \(error!.localizedDescription)")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No data returned from pokeAPI")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                  print("Unable to process type response")
                  completion(nil, .invalidResponse)
                  return
                }
                
                guard response.statusCode == 200 else {
                  print("Failure response from pokeAPI: \(response.statusCode)")
                  completion(nil, .failedRequest)
                  return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let typeData: Relations = try decoder.decode(Relations.self, from: data)
                    completion(typeData, nil)
                } catch {
                    print("Unable to decode Pokémon response: \(error.localizedDescription)")
                    completion(nil, .invalidData)
                }
            }
        }.resume()
    }
    
}
