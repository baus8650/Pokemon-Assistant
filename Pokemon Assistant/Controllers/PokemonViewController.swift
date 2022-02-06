//
//  PokemonViewController.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/21/21.
//

import UIKit

class PokemonViewController: UITableViewController {

    var type: String?
    var attackPokemon = [AttackPokemon]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false

        navigationController?.navigationBar.prefersLargeTitles = false
        title = "\(type!.capitalized) Type Pokemon"

        performSelector(inBackground: #selector(fetchJSON), with: nil)
        self.clearsSelectionOnViewWillAppear = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(goHome))
    }

    @objc func goHome() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func fetchJSON() {
        let urlString: String
        urlString = "https://pokeapi.co/api/v2/type/\(type!)"
        
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
        
        if let jsonType = try? decoder.decode(PokemonStrategy.self, from: json) {
            
            attackPokemon = jsonType.pokemon
            

            DispatchQueue.main.async { [self] in
                tableView.reloadData()
            }
        }
        
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the data; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
    
    
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return attackPokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokeName = attackPokemon[indexPath.row]
        cell.textLabel?.text = pokeName.pokemon.name?.capitalized

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailView") as? DetailViewController
        let name = attackPokemon[indexPath.row]
        
        vc!.pokeSearch = name.pokemon.name?.lowercased()

        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
