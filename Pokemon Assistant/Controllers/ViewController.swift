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
    
    @IBAction func searchTapped(_ sender: UIButton) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToDetail" {
            let vc = segue.destination as! DetailViewController
            vc.pokeSearch = searchField.text?.lowercased()
        }
    }
    
    
}

