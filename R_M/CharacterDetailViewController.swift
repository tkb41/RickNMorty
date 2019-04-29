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
    
    @IBOutlet weak var episodeNumber: UILabel!
    @IBOutlet weak var redX: UIImageView!
    
    


    @IBOutlet weak var epNumberLabel: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var lastSeen: UILabel!
    @IBOutlet weak var species: UILabel!
    @IBOutlet weak var firstAppearanceTag: UILabel!
    
    var episodeName = ""
    var episodeNum = ""
    var airDate = ""
    
    var characterInfo = CharacterInfo()
    var characters = Characters()
    
    override func viewDidLoad() {
        
        navigationController?.navigationBar.backgroundColor = UIColor.blue
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        nameLabel.text = characterInfo.name
        statusLabel.text = characterInfo.status
        originLabel.text = characterInfo.origin
        speciesLabel.text = characterInfo.species
        lastKnownLocationLabel.text = characterInfo.location
    redX.isHidden = true
              
        switch characterInfo.gender {
        case "Male":
            genderImage.image = UIImage(named: "male")
        case "Female":
            genderImage.image = UIImage(named: "women")
        default:
          genderImage.isHidden = true
        }
        epNumberLabel.backgroundColor = .black
        name.backgroundColor = .clear
        name.layer.cornerRadius = 5
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.green.cgColor
        
        status.backgroundColor = .clear
        status.layer.cornerRadius = 5
        status.layer.borderWidth = 1
        status.layer.borderColor = UIColor.green.cgColor
        
        lastSeen.backgroundColor = .clear
        lastSeen.layer.cornerRadius = 5
        lastSeen.layer.borderWidth = 1
        lastSeen.layer.borderColor = UIColor.green.cgColor
        
        species.backgroundColor = .clear
        species.layer.cornerRadius = 5
        species.layer.borderWidth = 1
        species.layer.borderColor = UIColor.green.cgColor
        
        origin.backgroundColor = .clear
        origin.layer.cornerRadius = 5
        origin.layer.borderWidth = 1
        origin.layer.borderColor = UIColor.green.cgColor
        
        firstAppearanceTag.backgroundColor = .clear
        firstAppearanceTag.layer.cornerRadius = 5
        firstAppearanceTag.layer.borderWidth = 1
        firstAppearanceTag.layer.borderColor = UIColor.green.cgColor
        
        
        
        
        
        func getEpisodeName(url: String, completed: @escaping ()->() ) {
            Alamofire.request(url).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.episodeName = json["name"].stringValue
                    self.episodeNum = json["episode"].stringValue
                    self.airDate = json["air_date"].stringValue
                    print("📍\(self.episodeName) \(self.episodeNum)")
                    
                    self.firstEpisode.text = self.episodeName
                    self.episodeNumber.text = self.episodeNum
                case .failure(_):
                    print("ERROR")
                }
            }
        }
       getEpisodeName(url: characterInfo.episodeName) {
        }
        updateUserInterface()
    }
    override func viewWillAppear(_ animated: Bool) {
        if statusLabel.text == "Dead" {
redX.isHidden = false
            animateText()
        }
        
        
    }
    func animateText() {
        UIView.transition(with: statusLabel, duration: 1.0, options: .transitionFlipFromBottom, animations: {
            self.statusLabel.textColor = .red
            self.statusLabel.font = UIFont.boldSystemFont(ofSize: 16)
        })}
    
    
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
