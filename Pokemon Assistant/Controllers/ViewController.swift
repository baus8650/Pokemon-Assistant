//
//  ViewController.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/16/21.
//

import UIKit


class ViewController: UIViewController {

    var pokeSearch: String?
    
    @IBOutlet var searchField: UITextField!
    @IBOutlet var searchType: UITextField!
    
    @IBAction func searchTapped(_ sender: UIButton) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToDetail" {
            let vc = segue.destination as! DetailViewController
            vc.pokeSearch = searchField.text?.lowercased()
        }
        if segue.identifier == "TypeToType" {
            let vc = segue.destination as! TypesViewController
            vc.type = searchType.text?.lowercased()
        }
    }
    
    
}

