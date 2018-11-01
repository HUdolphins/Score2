//
//  FIRPlayer.swift
//  Score
//
//  Created by Kazuki Ohashi on 2018/09/11.
//  Copyright © 2018年 Kazuki Ohashi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FIRPlayer: NSObject {
    var id: String?
    var name: String?
    var battingResultsArray: [String] = []
    //第一打席ならgame-1.
    
    init(snapshot: DataSnapshot){
        self.id = snapshot.key
        
        
        let valueDictionary = snapshot.value as! [String:Any]
        if let results = valueDictionary["results"] as? [String]{
            self.battingResultsArray = results
        }
        self.name = valueDictionary["name"] as? String
    }
    
}

