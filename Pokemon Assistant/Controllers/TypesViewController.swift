//
//  TypesViewController.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/16/21.
//

import UIKit

class TypesViewController: UIViewController {
    
    private var typeViewModel: TypeViewModel!
    
    var type: String?
    var pokemonType: Relations?
    var tableData = [[PokemonType]]()
    var sendType: String?
    var sections = [String]()

    
    @IBOutlet weak var effectTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        effectTable.dataSource = self
        effectTable.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = false
        title = type!.capitalized
        
        typeViewModel = TypeViewModel(for: type ?? "normal")
        
        typeViewModel.getType(for: type ?? "normal")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(goHome))
        
        setUp()
        
    }
    
    func setUp() {
        typeViewModel.type.bind { [weak self] type in
            self?.pokemonType = type
        }
        
        typeViewModel.sections.bind { [weak self] sections in
            self?.sections = sections
            self?.effectTable.reloadData()
        }
        
        typeViewModel.tableData.bind { [weak self] tableData in
            self?.tableData = tableData
        }
        
        
    }
    
    
    @objc func goHome() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the data; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TypeToPokemon" {
            
            guard let vc = segue.destination as? PokemonViewController
            else {
                return
            }
            vc.type = sendType!
        }
    }
    
}

extension TypesViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Relations", for: indexPath)
        let typeName = tableData[indexPath.section][indexPath.row]
        cell.textLabel?.text = typeName.name.capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendType = tableData[indexPath.section][indexPath.row].name
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "StrategyPokemon") as? PokemonViewController
        vc!.type = sendType
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
