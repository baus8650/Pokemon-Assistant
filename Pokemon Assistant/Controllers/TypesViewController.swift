//
//  TypesViewController.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/16/21.
//

import UIKit
import ColorKit

class TypesViewController: UIViewController {
    
    private var typeViewModel: TypeViewModel!
    
    var type: String?
    var pokemonType: Relations?
    var tableData = [[PokemonType]]()
    var sendType: String?
    var sections = [String]()
    
    var color: UIColor?

    
    @IBOutlet weak var effectTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        effectTable.dataSource = self
        effectTable.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = false
        title = type!.capitalized
//        effectTable.backgroundColor = color
//        view.backgroundColor = color
        
//        pokemonType = Bundle.main.decode(for: type!, searchType: .type)
//        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
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
//            self?.effectTable.reloadData()
        }
        
        
    }
    
    
    @objc func goHome() {
        navigationController?.popToRootViewController(animated: true)
    }
    
//    @objc func fetchJSON() {
//        let urlString: String
//        urlString = "https://pokeapi.co/api/v2/type/\(type ?? "normal")"
//        if let url = URL(string: urlString) {
//            if let data = try? Data(contentsOf: url) {
//                parse(json: data)
//
//                return
//            }
//        }
//        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
//    }
//
//    func parse(json: Data) {
//        let decoder = JSONDecoder()
//
//        if let jsonType = try? decoder.decode(Relations.self, from: json) {
//            weakTo = jsonType.damage_relations.double_damage_from
//            strongAgainst = jsonType.damage_relations.double_damage_to
//            halfResistant = jsonType.damage_relations.half_damage_from
//            halfEffective = jsonType.damage_relations.half_damage_to
//            fullyResistant = jsonType.damage_relations.no_damage_from
//            noEffect = jsonType.damage_relations.no_damage_to
//            tableData = [weakTo!, strongAgainst!, halfResistant!, halfEffective!, fullyResistant!, noEffect!]
//            sections = ["Weak To", "Strong Against", "Half Resistant To", "Half Effective To", "Fully Resistant To", "No Effect"]
//
//            DispatchQueue.main.async { [self] in
//
//                let appearance = UINavigationBarAppearance()
//                effectTable.reloadData()
//                appearance.titleTextAttributes = [.foregroundColor: color?.complementaryColor as Any]
//                appearance.largeTitleTextAttributes = [.foregroundColor: color?.complementaryColor as Any]
//                self.navigationController?.navigationBar.tintColor = color?.complementaryColor
//                navigationItem.standardAppearance = appearance
//            }
//        }
//
//    }
    
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
//        header.contentView.backgroundColor = color
        
//        switch color?.contrastRatio(with: (UIColor(named: "Color")!)) {
//        case .acceptable:
//            header.textLabel?.textColor = UIColor(named: "Color")
//        case .acceptableForLargeText:
//            header.textLabel?.textColor = UIColor(named: "Color")
//        case .low:
//            header.textLabel?.textColor = color?.complementaryColor
//
//        default:
//            header.textLabel?.textColor = UIColor(named: "default")
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Relations", for: indexPath)
        let typeName = tableData[indexPath.section][indexPath.row]
        cell.textLabel?.text = typeName.name.capitalized
        
//        switch color?.contrastRatio(with: (UIColor(named: "Color")!)) {
//        case .acceptable:
//            cell.textLabel?.textColor = UIColor(named: "Color")
//        case .acceptableForLargeText:
//            cell.textLabel?.textColor = UIColor(named: "Color")
//        case .low:
//            cell.textLabel?.textColor = color?.complementaryColor
//            tableView.separatorColor = color?.complementaryColor
//
//        default:
//            cell.textLabel?.textColor = UIColor(named: "default")
//        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendType = tableData[indexPath.section][indexPath.row].name
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "StrategyPokemon") as? PokemonViewController
        vc!.type = sendType
        
//        vc!.color = color
//        vc!.view.backgroundColor = color
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
