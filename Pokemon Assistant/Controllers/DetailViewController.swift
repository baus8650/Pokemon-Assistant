//
//  DetailViewController.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/16/21.
//

import UIKit
import ColorKit
import Charts

class DetailViewController: UIViewController {
    
    private var pokemonViewModel: PokemonViewModel!
    
    
    
    var pokemon: Pokemon?
    var species: Species?
    var types: [Types]?
    var sprites: Sprites?
    var pokeSearch: String?
    var stats: BarChartData?
    var nextID: Int?
    var prevID: Int?
    var id: Int?
    
    private var barChartTest: StatBarChart!
    
    @IBOutlet var barChartView: HorizontalBarChartView!
    
    @IBOutlet var statView: UIView!
    @IBOutlet weak var typeTable: UITableView!
    @IBOutlet weak var frontImage: UIImageView!
    
    @IBOutlet var strategyButton: UIButton!
    @IBOutlet var numberLabel: UILabel!
    var contrastRatio: UIColor.ContrastRatioResult?
    var color: UIColor?
    var typeArray = [String]()
    
    
    @IBAction func previousPressed(_ sender: Any) {
        typeArray = [String]()
        pokeSearch = String(prevID!)
        pokemonViewModel = PokemonViewModel(for: pokeSearch!)
        pokemonViewModel.getPokemon(for: pokeSearch!)
        setUp()
    }

    @IBAction func nextPressed(_ sender: Any) {
        typeArray = [String]()
        pokeSearch = String(nextID!)
        pokemonViewModel = PokemonViewModel(for: pokeSearch!)
        pokemonViewModel.getPokemon(for: pokeSearch!)
        setUp()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeTable.delegate = self
        typeTable.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationController?.isNavigationBarHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(goHome))
        
        pokemonViewModel = PokemonViewModel(for: pokeSearch ?? "charmander")
        
        pokemonViewModel.getPokemon(for: pokeSearch ?? "charmander")
        
        setUp()
        
    }
    
    func setUp() {
        pokemonViewModel.pokemon.bind { [weak self] pokemon in
            self?.pokemon = pokemon
        }
        
        pokemonViewModel.numberLabel.bind { [weak self] numberLabel in
            self?.numberLabel.text = numberLabel
        }
        
        pokemonViewModel.nextID.bind { [weak self] nextID in
            self?.nextID = nextID
        }
        
        pokemonViewModel.prevID.bind { [weak self] prevID in
            self?.prevID = prevID
        }
        
        pokemonViewModel.image.bind { [weak self] image in
            self?.frontImage.image = image
        }
        
        pokemonViewModel.title.bind { [weak self] name in
            self?.title = name
        }
        
        pokemonViewModel.types.bind { [weak self] types in
            self?.typeArray = types
            self?.typeTable.reloadData()
        }
        
        pokemonViewModel.stats.bind { [weak self] stats in
            stats.drawValuesEnabled = true
            stats.valueFont = UIFont.systemFont(ofSize: 12)
            self?.barChartTest = StatBarChart(for: (self?.barChartView)!, with: stats)
        }
        
    }
    
    @objc func goHome() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    //    @objc func fetchJSON() {
    //        let urlString: String
    //        urlString = "https://pokeapi.co/api/v2/pokemon/\(pokeSearch ?? "charmander")"
    //
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
    //
    //    func parse(json: Data) {
    //        let decoder = JSONDecoder()
    //
    //        if let jsonPokemon = try? decoder.decode(Pokemon.self, from: json) {
    //
    //            species = jsonPokemon.species
    //            types = jsonPokemon.types
    //            sprites = jsonPokemon.sprites
    //            stats = jsonPokemon.stats
    //            id = jsonPokemon.id
    //            if id == 1 {
    //                nextID = id! + 1
    //                prevID = id!
    //            } else {
    //                nextID = id! + 1
    //                prevID = id! - 1
    //            }
    //
    //            pokemon = Pokemon(species: species!, types: types!, sprites: sprites!, stats: stats!)
    //            guard let urlFront = URL(string: (self.pokemon?.sprites.front_default)!) else {
    //                return
    //            }
    //            if let frontData = try? Data(contentsOf: urlFront) {
    //                let domColors = try? UIImage(data: frontData)?.dominantColors()
    //                DispatchQueue.main.async { [self] in
    //                    frontImage.image = UIImage(data: frontData)
    //
    //                    color = UIColor(red: CIColor(cgColor: (domColors?[0].cgColor)!).red, green: CIColor(cgColor: (domColors?[0].cgColor)!).green, blue: CIColor(cgColor: (domColors?[0].cgColor)!).blue, alpha: 1)
    //
    //                    let accent = UIColor(red: CIColor(cgColor: (domColors?[1].cgColor)!).red, green: CIColor(cgColor: (domColors?[1].cgColor)!).green, blue: CIColor(cgColor: (domColors?[1].cgColor)!).blue, alpha: 1)
    //
    //                    contrastRatio = color?.contrastRatio(with: UIColor(named: "Color")!)
    //
//                        hpSlider.value = Float(stats![0].base_stat)
    //                    hpStat.text = String(stats![0].base_stat)
    //
    //                    attackSlider.value = Float(stats![1].base_stat)
    //                    attackStat.text = String(stats![1].base_stat)
    //
    //                    defenseSlider.value = Float(stats![2].base_stat)
    //                    defenseStat.text = String(stats![2].base_stat)
    //
    //                    spAtkSlider.value = Float(stats![3].base_stat)
    //                    spAtkStat.text = String(stats![3].base_stat)
    //
    //                    spDefSlider.value = Float(stats![4].base_stat)
    //                    spDefStat.text = String(stats![4].base_stat)
    //
    //                    speedSlider.value = Float(stats![5].base_stat)
    //                    speedStat.text = String(stats![5].base_stat)
    //
    //                    hpStat.textColor = UIColor.black
    //                    attackStat.textColor = UIColor.black
    //                    defenseStat.textColor = UIColor.black
    //                    spAtkStat.textColor = UIColor.black
    //                    spDefStat.textColor = UIColor.black
    //                    speedStat.textColor = UIColor.black
    //
    //                    view.backgroundColor =  color
    //                    typeTable.backgroundColor = color
    //
    //                    let appearance = UINavigationBarAppearance()
    //
    //                    switch color?.contrastRatio(with: accent) {
    //                    case .acceptable:
    //                        appearance.titleTextAttributes = [.foregroundColor: accent]
    //                        appearance.largeTitleTextAttributes = [.foregroundColor: accent]
    //                        self.navigationController?.navigationBar.tintColor = accent
    //                        hpSlider.tintColor = accent
    //                        attackSlider.tintColor = accent
    //                        defenseSlider.tintColor = accent
    //                        spAtkSlider.tintColor = accent
    //                        spDefSlider.tintColor = accent
    //                        speedSlider.tintColor = accent
    //                        hpSlider.maximumTrackTintColor = color
    //                        attackSlider.maximumTrackTintColor = color
    //                        defenseSlider.maximumTrackTintColor = color
    //                        spAtkSlider.maximumTrackTintColor = color
    //                        spDefSlider.maximumTrackTintColor = color
    //                        speedSlider.maximumTrackTintColor = color
    //                        hpLabel.textColor = accent
    //                        attackLabel.textColor = accent
    //                        defenseLabel.textColor = accent
    //                        spAtkLabel.textColor = accent
    //                        spDefLabel.textColor = accent
    //                        speedLabel.textColor = accent
    //                        hpStat.textColor = accent
    //                        attackStat.textColor = accent
    //                        defenseStat.textColor = accent
    //                        spAtkStat.textColor = accent
    //                        spDefStat.textColor = accent
    //                        speedStat.textColor = accent
    //                        strategyButton.tintColor = accent
    //                        numberLabel.textColor = accent
    //                        statView.backgroundColor = color
    //                    case .acceptableForLargeText:
    //                        appearance.titleTextAttributes = [.foregroundColor: accent]
    //                        appearance.largeTitleTextAttributes = [.foregroundColor: accent]
    //                        self.navigationController?.navigationBar.tintColor = accent
    //                        hpSlider.tintColor = accent
    //                        attackSlider.tintColor = accent
    //                        defenseSlider.tintColor = accent
    //                        spAtkSlider.tintColor = accent
    //                        spDefSlider.tintColor = accent
    //                        speedSlider.tintColor = accent
    //                        hpSlider.maximumTrackTintColor = color
    //                        attackSlider.maximumTrackTintColor = color
    //                        defenseSlider.maximumTrackTintColor = color
    //                        spAtkSlider.maximumTrackTintColor = color
    //                        spDefSlider.maximumTrackTintColor = color
    //                        speedSlider.maximumTrackTintColor = color
    //                        hpLabel.textColor = accent
    //                        attackLabel.textColor = accent
    //                        defenseLabel.textColor = accent
    //                        spAtkLabel.textColor = accent
    //                        spDefLabel.textColor = accent
    //                        speedLabel.textColor = accent
    //                        hpStat.textColor = accent
    //                        attackStat.textColor = accent
    //                        defenseStat.textColor = accent
    //                        spAtkStat.textColor = accent
    //                        spDefStat.textColor = accent
    //                        speedStat.textColor = accent
    //                        strategyButton.tintColor = accent
    //                        numberLabel.textColor = accent
    //                        statView.backgroundColor = color
    //                    case .low:
    //                        appearance.titleTextAttributes = [.foregroundColor: accent.complementaryColor]
    //                        appearance.largeTitleTextAttributes = [.foregroundColor: accent.complementaryColor]
    //                        self.navigationController?.navigationBar.tintColor = accent.complementaryColor
    //                        hpSlider.tintColor = accent.complementaryColor
    //                        attackSlider.tintColor = accent.complementaryColor
    //                        defenseSlider.tintColor = accent.complementaryColor
    //                        spAtkSlider.tintColor = accent.complementaryColor
    //                        spDefSlider.tintColor = accent.complementaryColor
    //                        speedSlider.tintColor = accent.complementaryColor
    //                        hpSlider.maximumTrackTintColor = color
    //                        attackSlider.maximumTrackTintColor = color
    //                        defenseSlider.maximumTrackTintColor = color
    //                        spAtkSlider.maximumTrackTintColor = color
    //                        spDefSlider.maximumTrackTintColor = color
    //                        speedSlider.maximumTrackTintColor = color
    //                        hpLabel.textColor = accent.complementaryColor
    //                        attackLabel.textColor = accent.complementaryColor
    //                        defenseLabel.textColor = accent.complementaryColor
    //                        spAtkLabel.textColor = accent.complementaryColor
    //                        spDefLabel.textColor = accent.complementaryColor
    //                        speedLabel.textColor = accent.complementaryColor
    //                        hpStat.textColor = accent.complementaryColor
    //                        attackStat.textColor = accent.complementaryColor
    //                        defenseStat.textColor = accent.complementaryColor
    //                        spAtkStat.textColor = accent.complementaryColor
    //                        spDefStat.textColor = accent.complementaryColor
    //                        speedStat.textColor = accent.complementaryColor
    //                        strategyButton.tintColor = accent.complementaryColor
    //                        numberLabel.textColor = accent.complementaryColor
    //                        statView.backgroundColor = color
    //                    default:
    //                        appearance.titleTextAttributes = [.foregroundColor: color?.complementaryColor as Any]
    //                        appearance.largeTitleTextAttributes = [.foregroundColor: color?.complementaryColor as Any]
    //                        self.navigationController?.navigationBar.tintColor = color?.complementaryColor
    //                        hpSlider.tintColor = color?.complementaryColor
    //                        attackSlider.tintColor = color?.complementaryColor
    //                        defenseSlider.tintColor = color?.complementaryColor
    //                        spAtkSlider.tintColor = color?.complementaryColor
    //                        spDefSlider.tintColor = color?.complementaryColor
    //                        speedSlider.tintColor = color?.complementaryColor
    //                        hpLabel.textColor = color?.complementaryColor
    //                        attackLabel.textColor = color?.complementaryColor
    //                        defenseLabel.textColor = color?.complementaryColor
    //                        spAtkLabel.textColor = color?.complementaryColor
    //                        spDefLabel.textColor = color?.complementaryColor
    //                        speedLabel.textColor = color?.complementaryColor
    //                        attackStat.textColor = color?.complementaryColor
    //                        defenseStat.textColor = color?.complementaryColor
    //                        spAtkStat.textColor = color?.complementaryColor
    //                        spDefStat.textColor = color?.complementaryColor
    //                        speedStat.textColor = color?.complementaryColor
    //                        strategyButton.tintColor = color?.complementaryColor
    //                        numberLabel.textColor = color?.complementaryColor
    //                        statView.backgroundColor = color
    //                    }
    //
    //                    navigationItem.standardAppearance = appearance
    //                }
    //            }
    //
    //            for i in 0..<types!.count {
    //                typeArray.append(types![i].type.name)
    //            }
    //            DispatchQueue.main.async {
    //                self.title = self.pokemon!.species.name.capitalized
    //                self.numberLabel.text = "#\(self.id!)"
    //                self.typeTable.reloadData()
    //            }
    //        }
    //
    //    }
    //
    //    @objc func showError() {
    //        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the data; please check your connection and try again.", preferredStyle: .alert)
    //        ac.addAction(UIAlertAction(title: "OK", style: .default))
    //        present(ac,animated: true)
    //    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailToType" {
            //            title = "Search"
            
            guard let vc = segue.destination as? TypesViewController,
                  let index = typeTable.indexPathForSelectedRow?.row
            else {
                return
            }
            vc.type = typeArray[index]
        }
        if segue.identifier == "PokemonToStrategy" {
            guard let vc = segue.destination as? StrategyViewController else { return }
            vc.type = typeArray
            vc.color = color
            vc.view.backgroundColor = color
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
        vc!.color = color
        vc!.view.backgroundColor = color
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

