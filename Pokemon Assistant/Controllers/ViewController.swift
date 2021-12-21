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
            switch type.lowercased() {
            case "normal":
                vc.view.backgroundColor = #colorLiteral(red: 0.6666682363, green: 0.666665554, blue: 0.6016612053, alpha: 1)
                vc.color = #colorLiteral(red: 0.6666682363, green: 0.666665554, blue: 0.6016612053, alpha: 1)
            case "fire":
                vc.view.backgroundColor = #colorLiteral(red: 0.9990099072, green: 0.2657647729, blue: 0.1324933469, alpha: 1)
                vc.color = #colorLiteral(red: 0.9990099072, green: 0.2657647729, blue: 0.1324933469, alpha: 1)
            case "water":
                vc.view.backgroundColor = #colorLiteral(red: 0.2019404173, green: 0.6003515124, blue: 1, alpha: 1)
                vc.color = #colorLiteral(red: 0.2019404173, green: 0.6003515124, blue: 1, alpha: 1)
            case "electric":
                vc.view.backgroundColor = #colorLiteral(red: 1, green: 0.8001163602, blue: 0.199642837, alpha: 1)
                vc.color = #colorLiteral(red: 1, green: 0.8001163602, blue: 0.199642837, alpha: 1)
            case "grass":
                vc.view.backgroundColor = #colorLiteral(red: 0.4653936625, green: 0.8004567623, blue: 0.3343704343, alpha: 1)
                vc.color = #colorLiteral(red: 0.4653936625, green: 0.8004567623, blue: 0.3343704343, alpha: 1)
            case "ice":
                vc.view.backgroundColor = #colorLiteral(red: 0.3980832398, green: 0.8015164733, blue: 0.9996564984, alpha: 1)
                vc.color = #colorLiteral(red: 0.3980832398, green: 0.8015164733, blue: 0.9996564984, alpha: 1)
            case "fighting":
                vc.view.backgroundColor = #colorLiteral(red: 0.7320317626, green: 0.3339761198, blue: 0.2686732411, alpha: 1)
                vc.color = #colorLiteral(red: 0.7320317626, green: 0.3339761198, blue: 0.2686732411, alpha: 1)
            case "poison":
                vc.view.backgroundColor = #colorLiteral(red: 0.6664613485, green: 0.3353112936, blue: 0.601334393, alpha: 1)
                vc.color = #colorLiteral(red: 0.6664613485, green: 0.3353112936, blue: 0.601334393, alpha: 1)
            case "ground":
                vc.view.backgroundColor = #colorLiteral(red: 0.869314611, green: 0.7321483493, blue: 0.3316730261, alpha: 1)
                vc.color = #colorLiteral(red: 0.869314611, green: 0.7321483493, blue: 0.3316730261, alpha: 1)
            case "flying":
                vc.view.backgroundColor = #colorLiteral(red: 0.5317198038, green: 0.6021832824, blue: 1, alpha: 1)
                vc.color = #colorLiteral(red: 0.5317198038, green: 0.6021832824, blue: 1, alpha: 1)
            case "psychic":
                vc.view.backgroundColor = #colorLiteral(red: 1, green: 0.3353482783, blue: 0.6001918316, alpha: 1)
                vc.color = #colorLiteral(red: 1, green: 0.3353482783, blue: 0.6001918316, alpha: 1)
            case "bug":
                vc.view.backgroundColor = #colorLiteral(red: 0.6652684212, green: 0.7355222106, blue: 0.134421885, alpha: 1)
                vc.color = #colorLiteral(red: 0.6652684212, green: 0.7355222106, blue: 0.134421885, alpha: 1)
            case "rock":
                vc.view.backgroundColor = #colorLiteral(red: 0.7324152589, green: 0.6683269739, blue: 0.4004109204, alpha: 1)
                vc.color = #colorLiteral(red: 0.7324152589, green: 0.6683269739, blue: 0.4004109204, alpha: 1)
            case "ghost":
                vc.view.backgroundColor = #colorLiteral(red: 0.3999871612, green: 0.4000101089, blue: 0.7316676974, alpha: 1)
                vc.color = #colorLiteral(red: 0.3999871612, green: 0.4000101089, blue: 0.7316676974, alpha: 1)
            case "dragon":
                vc.view.backgroundColor = #colorLiteral(red: 0.4654070735, green: 0.4016181529, blue: 0.933308661, alpha: 1)
                vc.color = #colorLiteral(red: 0.4654070735, green: 0.4016181529, blue: 0.933308661, alpha: 1)
            case "dark":
                vc.view.backgroundColor = #colorLiteral(red: 0.4675114751, green: 0.3316375315, blue: 0.2684605718, alpha: 1)
                vc.color = #colorLiteral(red: 0.4675114751, green: 0.3316375315, blue: 0.2684605718, alpha: 1)
            case "steel":
                vc.view.backgroundColor = #colorLiteral(red: 0.6666648984, green: 0.6666681767, blue: 0.7352042794, alpha: 1)
                vc.color = #colorLiteral(red: 0.6666648984, green: 0.6666681767, blue: 0.7352042794, alpha: 1)
            case "fairy":
                vc.view.backgroundColor = #colorLiteral(red: 0.9337071776, green: 0.6006908417, blue: 0.9325963855, alpha: 1)
                vc.color = #colorLiteral(red: 0.9337071776, green: 0.6006908417, blue: 0.9325963855, alpha: 1)
            case "unknown":
                vc.view.backgroundColor = #colorLiteral(red: 0.1865261209, green: 0.1200824366, blue: 0.1862421438, alpha: 1)
                vc.color = #colorLiteral(red: 0.1865261209, green: 0.1200824366, blue: 0.1862421438, alpha: 1)
            case "shadow":
                vc.view.backgroundColor = #colorLiteral(red: 0.2455663803, green: 0.04699495158, blue: 0.4070554124, alpha: 1)
                vc.color = #colorLiteral(red: 0.2455663803, green: 0.04699495158, blue: 0.4070554124, alpha: 1)
            default:
                vc.view.backgroundColor = UIColor(named: "Color")
                vc.color = UIColor(named: "Color")
            }
        }
    }
    
    
}

