//
//  firstViewController.swift
//  R_M
//
//  Created by Kyle Burns on 4/23/19.
//  Copyright © 2019 t. kyle burns. All rights reserved.
//

// get all the data to load here !!!!!

import UIKit
import AVFoundation

class firstViewController: UIViewController {
    
    
    
    @IBOutlet weak var hiddenRickButton: UIButton!
    @IBOutlet weak var star: UIImageView!
    var yAtLanding: CGFloat!
    var audioPlayer = AVAudioPlayer()
    
    
    var characters = Characters()
    
    var delayCounter = 1
    var index = 0
    var randomName = ""
    var randomLocation = ""
    var randomStatus = ""
    var randomType = ""
    var randomSpecies = ""
    var randomGender = ""
    var randomOrigin = ""
    var randomImageURL = ""
    var randomEpisodeName = ""
    
    var viewController = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        star.center.x  -= view.bounds.width
        animateStar()
        
        characters.getCharacters {
        }
//        if characters.nextURL.hasPrefix("http") {
//            characters.getCharacters {
//
//            }
//        }
    }

    
    @IBAction func randomButtonPushed(_ sender: Any) {
    }
    
    @IBAction func rickButtonPushed(_ sender: Any) {
        playSound(soundName: "RnM", audioPlayer: &audioPlayer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        index = ((characters.charactersArray.randomElement()?.id)!)
        print(index)
        randomName = characters.charactersArray[index].name
        randomLocation = characters.charactersArray[index].location
        randomStatus = characters.charactersArray[index].status
        randomType = characters.charactersArray[index].type
        randomSpecies = characters.charactersArray[index].species
        randomGender = characters.charactersArray[index].gender
        randomOrigin = characters.charactersArray[index].origin
        randomImageURL = characters.charactersArray[index].imageURL
        randomEpisodeName = characters.charactersArray[index].episodeName
        
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
            destination.characterInfo.episodeName = randomEpisodeName
        }
    }
    
    func animateStar() {
        UIView.animate(withDuration: 5, delay: 0.0, animations: {
            self.star.center.x += self.view.bounds.width+410;
            self.star.center.y -= self.view.bounds.width})}
}

func playSound(soundName: String, audioPlayer: inout AVAudioPlayer ){
    if let sound = NSDataAsset(name: soundName) {
        do {
            try audioPlayer = AVAudioPlayer(data: sound.data)
            audioPlayer.play()
        }catch{
        }
    }else{
        print("error, data from the douns file did not play ")
    }
}
