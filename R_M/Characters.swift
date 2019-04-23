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
    
    var charactersArray: [CharacterInfo] = []
    var apiURL = "https://rickandmortyapi.com/api/character/"
//    var episodeDetailURL = ""
    
    func getCharacters(completed: @escaping ()->() ) {
        Alamofire.request(apiURL).responseJSON { response in
            switch response.result {
            case.success(let value):
                let json = JSON(value)
                let numberOfCharacters = json["results"].count
                for index in 0..<numberOfCharacters {
                    var episodeIndex = 0
                    let name = json["results"][index]["name"].stringValue
                    let status = json["results"][index]["status"].stringValue
                    let species = json["results"][index]["species"].stringValue
                    let type = json["results"][index]["type"].stringValue
                    let gender = json["results"][index]["gender"].stringValue
                    let origin = json["results"][index]["origin"]["name"].stringValue
                    let location = json["results"][index]["location"]["name"].stringValue
                   let episodeURL = json["results"][index]["episode"][0].stringValue
                    let imageURL = json["results"][index]["image"].stringValue
                    let id = json["results"][index]["id"].int
                    print("\(index+1) \(name) \(origin) \(location) \(imageURL) \(episodeURL) \(id)")
             
                    self.charactersArray.append(CharacterInfo(name:name, status: status, species: species, type: type, gender: gender, origin: origin, location: location, imageURL: imageURL, episodeURL: episodeURL, id: id!))
                    
                    // pic: image
                    
                }
            case.failure(let error):
                print("getting the info did not work, \(error.localizedDescription)")
            }
            completed()
        }
//        print("💯\(episodeDetailURL)")
    }


        
 }
    


