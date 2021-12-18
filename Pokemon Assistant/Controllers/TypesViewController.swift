//
//  TypesViewController.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/16/21.
//

import UIKit

class TypesViewController: UIViewController {
    
    var type: String?
    var weakTo: [PokemonType]?
    var strongAgainst: [PokemonType]?
    var halfResistant: [PokemonType]?
    var halfEffective: [PokemonType]?
    var fullyResistant: [PokemonType]?
    var noEffect: [PokemonType]?
    var tableData = [[PokemonType]]()

    var sections = [String]() 
    
    @IBOutlet weak var effectTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        effectTable.dataSource = self
        effectTable.delegate = self
        
        title = type!.capitalized
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        let urlString: String
        urlString = "https://pokeapi.co/api/v2/type/\(type ?? "normal")"
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
        
        if let jsonType = try? decoder.decode(Relations.self, from: json) {
            weakTo = jsonType.damage_relations.double_damage_from
            strongAgainst = jsonType.damage_relations.double_damage_to
            halfResistant = jsonType.damage_relations.half_damage_from
            halfEffective = jsonType.damage_relations.half_damage_to
            fullyResistant = jsonType.damage_relations.no_damage_from
            noEffect = jsonType.damage_relations.no_damage_to
            tableData = [weakTo!, strongAgainst!, halfResistant!, halfEffective!, fullyResistant!, noEffect!]
            sections = ["Weak To", "Strong Against", "Half Resistant To", "Half Effective To", "Fully Resistant To", "No Effect"]
            DispatchQueue.main.async { [self] in

                effectTable.reloadData()

            }
        }
        
        
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the data; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }

}

extension TypesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Relations", for: indexPath)
        var typeName = tableData[indexPath.section][indexPath.row]
        cell.textLabel?.text = typeName.name.capitalized
        
        return cell
    }
    
    
}