//
//  ViewController.swift
//  R_M
//
//  Created by Kyle Burns on 4/22/19.
//  Copyright © 2019 t. kyle burns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var characters = Characters()
    var loadAll = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        tableView.dataSource = self
        tableView.delegate = self
        loadData()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! CharacterDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow!
            
            //more succinct passing of characterInfo
            destination.characterInfo = characters.charactersArray[selectedIndex.row]
        }
    }
    func loadData() {
        characters.getCharacters {
            self.tableView.reloadData()
        }
    }
    
    
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.charactersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = characters.charactersArray[indexPath.row].name
        
        if indexPath.row == characters.charactersArray.count-1 {
            loadData()
        }
        return cell
    }
    
    
}

