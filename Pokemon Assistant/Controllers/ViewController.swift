//
//  ViewController.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/16/21.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    var pokeSearch: String?
    
    @IBOutlet var searchField: UITextField!
    @IBOutlet var searchType: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        searchField.delegate = self
        searchType.delegate = self
        
        self.navigationItem.title = "Search"
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        navigationItem.standardAppearance = appearance
    
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToDetail" {
            self.navigationItem.title = "Search"
            let vc = segue.destination as! DetailViewController
            vc.pokeSearch = searchField.text?.lowercased()
        }
        if segue.identifier == "TypeToType" {
            self.navigationItem.title = "Search"
            let vc = segue.destination as! TypesViewController
            vc.type = searchType.text?.lowercased()
            let type = searchType.text!
            navigationController?.isNavigationBarHidden = false
        }
    }
    
    
}

