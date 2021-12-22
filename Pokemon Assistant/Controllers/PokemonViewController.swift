//
//  PokemonViewController.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 12/21/21.
//

import UIKit

class PokemonViewController: UITableViewController {

    var type: String?
    var color: UIColor?
    var attackPokemon = [AttackPokemon]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false

        navigationController?.navigationBar.prefersLargeTitles = false
        title = "\(type!.capitalized) Type Pokemon"
        tableView.backgroundColor = color
        view.backgroundColor = color
        print("FROM POKE PAGE", type)
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        self.clearsSelectionOnViewWillAppear = true
    }

    @objc func fetchJSON() {
        let urlString: String
        urlString = "https://pokeapi.co/api/v2/type/\(type! ?? "normal")"
        print("STRING STRING: ",urlString)
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                print("PARSING FROM OBJC")
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        print("HERE'S DECODER")
        if let jsonType = try? decoder.decode(PokemonStrategy.self, from: json) {
            print("IT WORKED",jsonType.pokemon)
            attackPokemon = jsonType.pokemon
            print("COUNT", attackPokemon.count)
//            print("TESTING: ", attackPokemon)
            DispatchQueue.main.async { [self] in
                let appearance = UINavigationBarAppearance()

                appearance.titleTextAttributes = [.foregroundColor: color?.complementaryColor as Any]
                appearance.largeTitleTextAttributes = [.foregroundColor: color?.complementaryColor as Any]
                self.navigationController?.navigationBar.tintColor = color?.complementaryColor
                navigationItem.standardAppearance = appearance
                tableView.reloadData()
            }
        }
        
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the data; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
    
    
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return attackPokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        cell.backgroundColor = color
        let pokeName = attackPokemon[indexPath.row]
        cell.textLabel?.text = pokeName.pokemon.name?.capitalized
        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
