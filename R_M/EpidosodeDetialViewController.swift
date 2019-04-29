//
//  EpidosodeDetialViewController.swift
//  R_M
//
//  Created by Kyle Burns on 4/29/19.
//  Copyright © 2019 t. kyle burns. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EpidosodeDetialViewController: UIViewController {
    
    var characterInfo = CharacterInfo()
    var characters = Characters()
    var episodeName = ""
    var episodeNum = ""
    var airDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getEpisodeName(url: characterInfo.episodeName) {
            
        }
        
        
        
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func getEpisodeInfo(url: String, completed: @escaping ()->() ) {
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.episodeName = json["name"].stringValue
                self.episodeNum = json["episode"].stringValue
                self.airDate = json["air_date"].stringValue
                print("📍\(self.episodeName) \(self.episodeNum)")
                
              
            case .failure(_):
                print("ERROR")
            }
        }
    }

  
}
