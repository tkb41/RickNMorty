//
//  CharacterDetailViewController.swift
//  R_M
//
//  Created by Kyle Burns on 4/22/19.
//  Copyright © 2019 t. kyle burns. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CharacterDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var lastKnownLocationLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var genderImage: UIImageView!
    
    @IBOutlet weak var firstEpisode: UILabel!
    var episodeName = ""
    
    var characterInfo = CharacterInfo()
    var characters = Characters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        nameLabel.text = characterInfo.name
        statusLabel.text = characterInfo.status
        originLabel.text = characterInfo.origin
        speciesLabel.text = characterInfo.species
        lastKnownLocationLabel.text = characterInfo.location
              
        switch characterInfo.gender {
        case "Male":
            genderImage.image = UIImage(named: "male")
        case "Female":
            genderImage.image = UIImage(named: "women")
        default:
          genderImage.isHidden = true
        }
        func getEpisodeName(url: String, completed: @escaping ()->() ) {
            Alamofire.request(url).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.episodeName = json["name"].stringValue
                    print("📍\(self.episodeName)")
                    self.firstEpisode.text = self.episodeName
                case .failure(_):
                    print("ERROR")
                }
            }
        }
//        print("📍📍\(episodeName)")
       getEpisodeName(url: characterInfo.episodeName) {
        }
        updateUserInterface()
    }
    
    func updateUserInterface() {
//         code for reading in a url and displaying in an image
        guard let imageURL = URL(string: characterInfo.imageURL)
            else { return }
        do {
            let data = try Data(contentsOf: imageURL)
            characterImage.image = UIImage(data: data)
        } catch {
            print("cant get the data frmo URL \(imageURL)")
        }
        
}
}
