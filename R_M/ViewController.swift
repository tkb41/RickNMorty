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
    var episodes = Episodes()
    var loadAll = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
        
        
 
        
        
//        characters.getCharacters {
//            self.tableView.reloadData()
//        }
        
//        episodes.getEpisodeInfo {
//            print("*****")
//        }
//
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! CharacterDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow!
            destination.characterInfo.name = characters.charactersArray[selectedIndex.row].name
            destination.characterInfo.location = characters.charactersArray[selectedIndex.row].location
            destination.characterInfo.status = characters.charactersArray[selectedIndex.row].status
            destination.characterInfo.species = characters.charactersArray[selectedIndex.row].species
            destination.characterInfo.type = characters.charactersArray[selectedIndex.row].type
            destination.characterInfo.gender = characters.charactersArray[selectedIndex.row].gender
            destination.characterInfo.origin = characters.charactersArray[selectedIndex.row].origin
            destination.characterInfo.imageURL = characters.charactersArray[selectedIndex.row].imageURL
            destination.characterInfo.episodeName = characters.charactersArray[selectedIndex.row].episodeName
            
            
        }
    }
    func loadData() {
        if characters.nextURL.hasPrefix("http") {
            characters.getCharacters {
                self.tableView.reloadData()
            }
            episodes.getEpisodes {
                self.tableView.reloadData()
            }
            
        } else {
                self.loadAll = false
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

