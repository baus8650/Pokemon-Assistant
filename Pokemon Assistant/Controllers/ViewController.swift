//
//  ViewController.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/16/21.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var searchResults = [String]()
    var isSearching: Bool? {
        didSet {
            if isSearching! {
                pokemonTable.isHidden = false
            } else {
                pokemonTable.isHidden = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching! {
                return searchResults.count
            }
            else{

                return 0
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        if isSearching! {
            let name = searchResults[indexPath.row]
            cell.textLabel?.text = name.capitalized
        } else {
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching! {
            pokeSearch = searchResults[indexPath.row].lowercased()
            performSegue(withIdentifier: "SearchToDetail", sender: pokeSearch!)
        }
    }
    

    var pokeSearch: String?
    var allPokemon = [String]()
    private var pokemonViewModel: PokemonViewModel!
    
    @IBOutlet var searchField: UITextField!
    @IBOutlet var searchType: UITextField!
    @IBOutlet var pokemonTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        searchField.delegate = self
        searchType.delegate = self
        
        pokemonTable.delegate = self
        pokemonTable.dataSource = self
        
        pokemonTable.layer.cornerRadius = 5.0
        
        isSearching = false
        
        self.navigationItem.title = "Search"
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        navigationItem.standardAppearance = appearance
        
        pokemonViewModel = PokemonViewModel(for: "charmander")
        
        pokemonViewModel.getAllPokemon()
        setUp()
        
    }
    
    func setUp() {
        pokemonViewModel.allPokemon.bind { [weak self] pokemon in
            self?.allPokemon = pokemon?.results.map { $0.name } ?? [""]
            print("FROM VIEW CONTROLLER: ",self?.allPokemon)
            self?.pokemonTable.reloadData()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{

        var searchText  = textField.text! + string

        if string  == "" {
            searchText = (searchText as String).substring(to: searchText.index(before: searchText.endIndex))
        }

        if searchText == "" {
            isSearching = false
            pokemonTable.reloadData()
        }
        else{
            getSearchArrayContains(searchText)
        }
        print("SEARCH TEXT: ",searchText)

        return true
    }
    
    func getSearchArrayContains(_ text : String) {
        var predicate : NSPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", text)
        searchResults = (allPokemon as NSArray).filtered(using: predicate) as! [String]
        isSearching = true
        pokemonTable.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            performSegue(withIdentifier: "SearchToDetail", sender: self)
        } else if textField.tag == 1 {
            performSegue(withIdentifier: "TypeToType", sender: self)
        }
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Search"
        searchType.text = ""
        searchField.text = ""
        isSearching = false
        searchResults = [String]()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToDetail" {
            self.navigationItem.title = "Search"
            let vc = segue.destination as! DetailViewController
            if self.pokeSearch == sender as! String {
                vc.pokeSearch = sender as! String
            } else {
                vc.pokeSearch = searchField.text?.lowercased()
            }
        }
        if segue.identifier == "TypeToType" {
            self.navigationItem.title = "Search"
            let vc = segue.destination as! TypesViewController
            vc.type = searchType.text?.lowercased()
            navigationController?.isNavigationBarHidden = false
        }
    }
    
    
}

