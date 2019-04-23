//
//  firstViewController.swift
//  R_M
//
//  Created by Kyle Burns on 4/23/19.
//  Copyright © 2019 t. kyle burns. All rights reserved.
//

import UIKit

class firstViewController: UIViewController {
    
var characters = Characters()
var index = 0
var randomName = ""
var randomLocation = ""
var randomStatus = ""
var randomType = ""
var randomSpecies = ""
var randomGender = ""
var randomOrigin = ""
var randomImageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characters.getCharacters {
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func randomButtonPushed(_ sender: Any) {
//        randomName = characters.charactersArray.randomElement()!.name
//        print("@@@@@@@@@@@@@@@@@@@@@", randomName)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        index = (characters.charactersArray.randomElement()?.id)!
        randomName = characters.charactersArray[index].name
        randomLocation = characters.charactersArray[index].location
        randomStatus = characters.charactersArray[index].status
        randomType = characters.charactersArray[index].type
        randomSpecies = characters.charactersArray[index].species
        randomGender = characters.charactersArray[index].gender
        randomOrigin = characters.charactersArray[index].origin
        randomImageURL = characters.charactersArray[index].imageURL

        print("@@@@@@@@@@@@@@@@@@@@@", randomName)
        if segue.identifier == "RandomSegue" {
            let destination = segue.destination as! CharacterDetailViewController
            
                            destination.characterInfo.name = randomName
                            destination.characterInfo.location = randomLocation
                            destination.characterInfo.status = randomStatus
                            destination.characterInfo.species = randomSpecies
                            destination.characterInfo.type = randomType
                            destination.characterInfo.gender = randomGender
                            destination.characterInfo.origin = randomOrigin
                            destination.characterInfo.imageURL = randomImageURL
            
            
        }
    }
    

}
