//
//  DetailViewController.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/16/21.
//

import UIKit
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
    var number: String?
    
    private var barChartTest: StatBarChart!
    
    @IBOutlet var barChartView: HorizontalBarChartView!
    
    @IBOutlet var statView: UIView!
    @IBOutlet weak var typeTable: UITableView!
    @IBOutlet weak var frontImage: UIImageView!
    
    @IBOutlet var strategyButton: UIButton!
    @IBOutlet var numberLabel: UILabel!
    
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
            self?.number = numberLabel
//            self?.numberLabel.text = numberLabel
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
            
            self?.title = "\(name) \((self?.number)!)"
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailToType" {
            
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
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

