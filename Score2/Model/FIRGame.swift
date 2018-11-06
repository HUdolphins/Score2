//
//  FIRGame.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/11/01.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FIRGame: NSObject {

    var id: String?
    var date: Date?
    var stadium: String?
    var topTeamKey: String?
    var botTeamKey: String?
    //Ohashi: 軟式か硬式か
    //Ohashi: topPlayer, bottomPlayer, lastIning, winner, loser, results
    
    init(snapshot: DataSnapshot) {
        self.id = snapshot.key

        let valueDictionary = snapshot.value as! [String: Any]

        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        self.stadium = valueDictionary["stadium"] as? String
        self.topTeamKey = valueDictionary["topTeam"] as? String
        self.botTeamKey = valueDictionary["botTeam"] as? String
        
    }
}
