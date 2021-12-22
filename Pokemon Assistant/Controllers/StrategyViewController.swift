//
//  StrategyViewController.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/21/21.
//

import UIKit

class StrategyViewController: UITableViewController {
    
    var type: [String]?
    var effectiveness1 = [String: Double]()
    var effectiveness2 = [String: Double]()
    var defTypes: [String: Double] = ["normal": 1,"fighting": 1, "flying": 1, "poison": 1, "ground": 1, "rock": 1, "bug": 1, "ghost": 1, "steel": 1, "fire": 1, "water": 1, "grass": 1, "electric": 1, "psychic": 1, "ice": 1, "dragon": 1, "dark": 1, "fairy": 1]
    
    var offTypes: [String: Double] = ["normal": 1,"fighting": 1, "flying": 1, "poison": 1, "ground": 1, "rock": 1, "bug": 1, "ghost": 1, "steel": 1, "fire": 1, "water": 1, "grass": 1, "electric": 1, "psychic": 1, "ice": 1, "dragon": 1, "dark": 1, "fairy": 1]
    
    var sendType: String?
    
    var tableSections = [String]()
    
    var defCalculated = [[String]]()
    
    let appearance = UINavigationBarAppearance()
    
    var weakTo1: [PokemonType]?
    var strongAgainst1: [PokemonType]?
    var halfResistant1: [PokemonType]?
    var halfEffective1: [PokemonType]?
    var fullyResistant1: [PokemonType]?
    var noEffect1: [PokemonType]?
    var tableData1 = [[PokemonType]]()
    
    var weakTo2: [PokemonType]?
    var strongAgainst2: [PokemonType]?
    var halfResistant2: [PokemonType]?
    var halfEffective2: [PokemonType]?
    var fullyResistant2: [PokemonType]?
    var noEffect2: [PokemonType]?
    var tableData2 = [[PokemonType]]()
    
    var color: UIColor?
    
    var sections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = color
        title = "Attacking Strategy"
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(goHome))
    }
    
    @objc func goHome() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func fetchJSON() {
        if type!.count == 2 {
        var urlString1: String
        urlString1 = "https://pokeapi.co/api/v2/type/\(type![0])"
        var urlString2: String
        urlString2 = "https://pokeapi.co/api/v2/type/\(type![1])"
        
        if let url1 = URL(string: urlString1), let url2 = URL(string: urlString2) {
            if let data1 = try? Data(contentsOf: url1), let data2 = try? Data(contentsOf: url2) {
                parse2(json1: data1, json2: data2)
                return
            }
        }
        
        if let url2 = URL(string: urlString2) {
            if let data2 = try? Data(contentsOf: url2) {
                parse1(json: data2)
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        
        } else if type!.count == 1 {
            var urlString1: String
            urlString1 = "https://pokeapi.co/api/v2/type/\(type![0])"
            
            if let url1 = URL(string: urlString1) {
                if let data1 = try? Data(contentsOf: url1) {
                    parse1(json: data1)
                    
                    
                    return
                }
            }
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
        
    }
    
    
    func parse2(json1: Data, json2: Data) {
        let decoder = JSONDecoder()
        
        if let jsonType1 = try? decoder.decode(Relations.self, from: json1) {
            weakTo1 = jsonType1.damage_relations.double_damage_from
            strongAgainst1 = jsonType1.damage_relations.double_damage_to
            halfResistant1 = jsonType1.damage_relations.half_damage_from
            halfEffective1 = jsonType1.damage_relations.half_damage_to
            fullyResistant1 = jsonType1.damage_relations.no_damage_from
            noEffect1 = jsonType1.damage_relations.no_damage_to
            tableData1 = [weakTo1!, strongAgainst1!, halfResistant1!, halfEffective1!, fullyResistant1!, noEffect1!]
            for i in 0..<tableData1.count {
                switch i {
                case 0:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: -2]) { (old, new) in
                            if old < 0, new < 0 {
                                return old * new * -1
                            } else {
                                return old * new
                            }
                        }
                    }
                case 1:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: 1]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                        offTypes.merge([t.name: 2]) { (old, new) in
                            old * new
                        }
                    }
                    
                case 2:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: -0.5]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                    }
                case 3:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: 1]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                        offTypes.merge([t.name: 0.5]) { (old, new) in
                            old * new
                        }
                    }
                case 4:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: 0]) { (old, _) in
                            old * 0
                        }
                    }
                case 5:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: 1]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                        offTypes.merge([t.name: 0]) { (old, _) in
                            old * 0
                        }
                    }
                default:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: 1]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                    }
                }
            }
        }
        
        if let jsonType2 = try? decoder.decode(Relations.self, from: json2) {
            weakTo2 = jsonType2.damage_relations.double_damage_from
            strongAgainst2 = jsonType2.damage_relations.double_damage_to
            halfResistant2 = jsonType2.damage_relations.half_damage_from
            halfEffective2 = jsonType2.damage_relations.half_damage_to
            fullyResistant2 = jsonType2.damage_relations.no_damage_from
            noEffect2 = jsonType2.damage_relations.no_damage_to
            tableData2 = [weakTo2!, strongAgainst2!, halfResistant2!, halfEffective2!, fullyResistant2!, noEffect2!]
            for i in 0..<tableData2.count {
                switch i {
                case 0:
                    for t in tableData2[i] {
                        defTypes.merge([t.name: -2]) { (old, new) in
                            if old < 0, new < 0 {
                                return old * new * -1
                            } else if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                    }
                case 1:
                    for t in tableData2[i] {
                        defTypes.merge([t.name: 1]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                        offTypes.merge([t.name: 2]) { (old, new) in
                            old*new
                        }
                    }
                case 2:
                    for t in tableData2[i] {
                        defTypes.merge([t.name: -0.5]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                    }
                case 3:
                    for t in tableData2[i] {
                        defTypes.merge([t.name: 1]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                        offTypes.merge([t.name: 0.5]) { (old, new) in
                            old*new
                        }
                    }
                case 4:
                    for t in tableData2[i] {
                        defTypes.merge([t.name: 0]) { (old, _) in
                            old * 0
                        }
                    }
                case 5:
                    for t in tableData2[i] {
                        defTypes.merge([t.name: 1]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                        offTypes.merge([t.name: 0]) { (old, _) in
                            old * 0
                        }
                    }
                default:
                    for t in tableData2[i] {
                        defTypes.merge([t.name: 1]) { (old, new) in
                            old * new
                        }
                    }
                }
            }
        }
        
        var fourTimes = [String]()
        var twoTimes = [String]()
        var dealsTwoTimes = [String]()
        var neutral = [String]()
        var half = [String]()
        var dealsHalf = [String]()
        var zero = [String]()
        var dealsZero = [String]()
        
        for i in defTypes {
            if i.value == -4 {
                fourTimes.append(i.key)
            } else if i.value == -2 {
                twoTimes.append(i.key)
            } else if i.value == 1 {
                neutral.append(i.key)
            } else if i.value == -0.5 {
                half.append(i.key)
            } else if i.value == 0 {
                zero.append(i.key)
            }
        }
        for i in offTypes {
            if i.value == 2 {
                dealsTwoTimes.append(i.key)
            } else if i.value == 0.5 {
                dealsHalf.append(i.key)
            } else if i.value == 0 {
                dealsZero.append(i.key)
            }
        }
        
        defCalculated = [fourTimes, twoTimes, dealsTwoTimes, half, dealsHalf, zero, dealsZero, neutral]
        tableSections = ["Receives 4x Damage From", "Receives 2x Damage From","Deals 2x Damage To", "Receives 1/2 Damage From","Deals 1/2 Damage To", "Receives 0 Damage From", "Deals 0 Damage To", "Neutral"]
        DispatchQueue.main.async {
            self.appearance.titleTextAttributes = [.foregroundColor: self.color?.complementaryColor as Any]
            self.appearance.largeTitleTextAttributes = [.foregroundColor: self.color?.complementaryColor as Any]
            self.navigationController?.navigationBar.tintColor = self.color?.complementaryColor
            self.navigationItem.standardAppearance = self.appearance
            self.tableView.reloadData()
        }
    }
    
    func parse1(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonType1 = try? decoder.decode(Relations.self, from: json) {
            weakTo1 = jsonType1.damage_relations.double_damage_from
            strongAgainst1 = jsonType1.damage_relations.double_damage_to
            halfResistant1 = jsonType1.damage_relations.half_damage_from
            halfEffective1 = jsonType1.damage_relations.half_damage_to
            fullyResistant1 = jsonType1.damage_relations.no_damage_from
            noEffect1 = jsonType1.damage_relations.no_damage_to
            tableData1 = [weakTo1!, strongAgainst1!, halfResistant1!, halfEffective1!, fullyResistant1!, noEffect1!]
            for i in 0..<tableData1.count {
                switch i {
                case 0:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: -2]) { (old, new) in
                            if old < 0, new < 0 {
                                return old * new * -1
                            } else {
                                return old * new
                            }
                        }
                    }
                case 1:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: 1]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                        offTypes.merge([t.name: 2]) { (old, new) in
                            old*new
                        }
                    }
                case 2:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: -0.5]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                    }
                case 3:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: 1]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                        offTypes.merge([t.name: 0.5]) { (old, new) in
                            old*new
                        }
                    }
                case 4:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: 0]) { (old, _) in
                            old * 0
                        }
                    }
                case 5:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: 1]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                        offTypes.merge([t.name: 0]) { (old, _) in
                            old * 0
                        }
                    }
                default:
                    for t in tableData1[i] {
                        defTypes.merge([t.name: 1]) { (old, new) in
                            if old == 0 {
                                return 0
                            } else {
                                return old * new
                            }
                        }
                    }
                }
            }
        }
        var fourTimes = [String]()
        var twoTimes = [String]()
        var dealsTwoTimes = [String]()
        var neutral = [String]()
        var half = [String]()
        var dealsHalf = [String]()
        var zero = [String]()
        var dealsZero = [String]()
        
        for i in defTypes {
            if i.value == -4 {
                fourTimes.append(i.key)
            } else if i.value == -2 {
                twoTimes.append(i.key)
            } else if i.value == 1 {
                neutral.append(i.key)
            } else if i.value == -0.5 {
                half.append(i.key)
            } else if i.value == 0 {
                zero.append(i.key)
            }
        }
        for i in offTypes {
            if i.value == 2 {
                dealsTwoTimes.append(i.key)
            } else if i.value == 0.5 {
                dealsHalf.append(i.key)
            } else if i.value == 0 {
                dealsZero.append(i.key)
            }
        }
        
        defCalculated = [fourTimes, twoTimes, dealsTwoTimes, half, dealsHalf, zero, dealsZero, neutral]
        tableSections = ["Receives 4x Damage From", "Receives 2x Damage From","Deals 2x Damage To", "Receives 1/2 Damage From","Deals 1/2 Damage To", "Receives 0 Damage From", "Deals 0 Damage To", "Neutral"]
        DispatchQueue.main.async {
            self.appearance.titleTextAttributes = [.foregroundColor: self.color?.complementaryColor as Any]
            self.appearance.largeTitleTextAttributes = [.foregroundColor: self.color?.complementaryColor as Any]
            self.navigationController?.navigationBar.tintColor = self.color?.complementaryColor
            self.navigationItem.standardAppearance = self.appearance
            self.tableView.reloadData()
        }
    }
    
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the data; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StrategyToPokemon" {
            guard let vc = segue.destination as? PokemonViewController
            else {
                return
            }
            vc.type = sendType!
        }

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableSections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSections[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return defCalculated[section].count
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        header.contentView.backgroundColor = color
        
        switch color?.contrastRatio(with: (UIColor(named: "Color")!)) {
        case .acceptable:
            header.textLabel?.textColor = UIColor(named: "Color")
        case .acceptableForLargeText:
            header.textLabel?.textColor = UIColor(named: "Color")
        case .low:
            header.textLabel?.textColor = color?.complementaryColor
            
        default:
            header.textLabel?.textColor = UIColor(named: "default")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StrategyCell", for: indexPath)
        
        let typeName = defCalculated[indexPath.section][indexPath.row]
        cell.textLabel?.text = typeName.capitalized
        cell.backgroundColor = color
        switch color?.contrastRatio(with: (UIColor(named: "Color")!)) {
        case .acceptable:
            cell.textLabel?.textColor = UIColor(named: "Color")
        case .acceptableForLargeText:
            cell.textLabel?.textColor = UIColor(named: "Color")
        case .low:
            cell.textLabel?.textColor = color?.complementaryColor
            tableView.separatorColor = color?.complementaryColor

        default:
            cell.textLabel?.textColor = UIColor(named: "default")
        }
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "StrategyPokemon") as? PokemonViewController
        vc!.type = defCalculated[indexPath.section][indexPath.row].lowercased()
        sendType = defCalculated[indexPath.section][indexPath.row]
        vc!.color = color
        vc!.view.backgroundColor = color
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
