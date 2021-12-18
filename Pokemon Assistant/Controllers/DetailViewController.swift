//
//  DetailViewController.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/16/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pokemon: Pokemon?
    var species: Species?
    var types: [Types]?
    var sprites: Sprites?
    var pokeSearch: String?
    
    var typeArray = [String]()
    
    @IBOutlet weak var typeTable: UITableView!
    
    @IBOutlet weak var frontImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeTable.delegate = self
        typeTable.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        let urlString: String
        urlString = "https://pokeapi.co/api/v2/pokemon/\(pokeSearch ?? "charmander")"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPokemon = try? decoder.decode(Pokemon.self, from: json) {
            species = jsonPokemon.species
            types = jsonPokemon.types
            sprites = jsonPokemon.sprites
            
            pokemon = Pokemon(species: species!, types: types!, sprites: sprites!)
            guard let urlFront = URL(string: (self.pokemon?.sprites.front_default)!) else {
                return
            }
            if let frontData = try? Data(contentsOf: urlFront) {
                DispatchQueue.main.async { [self] in
                    frontImage.image = UIImage(data: frontData)
                }
            }
            
            for i in 0..<types!.count {
                typeArray.append(types![i].type.name)
            }
            DispatchQueue.main.async {
                self.title = self.pokemon!.species.name.capitalized
                self.typeTable.reloadData()
            }
            DispatchQueue.main.async { [self] in
                typeTable.reloadData()
                
            }
        }
        
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the data; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "DetailToType" {
            guard let vc = segue.destination as? TypesViewController,
                  let index = typeTable.indexPathForSelectedRow?.row
            else {
                return
            }
            vc.type = typeArray[index]
        }
    }
    
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
        let type = typeArray[indexPath.row]
        cell.textLabel?.text = type.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TypesController") as? TypesViewController
        vc!.type = typeArray[indexPath.row]
//        vc!.view.backgroundColor = .black
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
