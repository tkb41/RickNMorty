//
//  Characters.swift
//  R_M
//
//  Created by Kyle Burns on 4/22/19.
//  Copyright © 2019 t. kyle burns. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Characters {
    var index = 0
    var charactersArray: [CharacterInfo] = []
    var apiURL = "https://rickandmortyapi.com/api/character/"
    var nextURL = "https://rickandmortyapi.com/api/character/?page=1"
    //    var episodeDetailURL = ""
    
    func getCharacters(completed: @escaping ()->() ) {
        print(">>> Before Alamofire Call URL is \(self.nextURL)")
        Alamofire.request(nextURL).responseJSON { response in
            switch response.result {
            case.success(let value):
                let json = JSON(value)
                self.nextURL = json["info"]["next"].stringValue
                let numberOfCharacters = json["results"].count
                for index in 0..<numberOfCharacters {
                    let name = json["results"][index]["name"].stringValue
                    let status = json["results"][index]["status"].stringValue
                    let species = json["results"][index]["species"].stringValue
                    let type = json["results"][index]["type"].stringValue
                    let gender = json["results"][index]["gender"].stringValue
                    let origin = json["results"][index]["origin"]["name"].stringValue
                    let location = json["results"][index]["location"]["name"].stringValue
                    let imageURL = json["results"][index]["image"].stringValue
                    let id = json["results"][index]["image"].int
                    let episodeURL = json["results"][index]["episode"][0].stringValue
        
                    let newCharacterInfo = CharacterInfo(name: name, status: status, species: species, type: type, gender: gender, origin: origin, location: location, imageURL: imageURL, id: index, episodeName: episodeURL, episodeURL:episodeURL)
                    self.charactersArray.append(newCharacterInfo)
                }
                
            case.failure(let error):
                print("getting the info did not work, \(error.localizedDescription)")
            }
            completed()
        }
    }


}



