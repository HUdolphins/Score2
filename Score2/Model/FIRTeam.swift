//
//  FIRTeam.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/11/02.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FIRTeam: NSObject {
//Ohashi:menber, icon, teamname, league
    var id: String?
    var name: String?
    var members: [String] = []
    var games:[String] = []
    var league: String?
    
    init(snapshot:DataSnapshot) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        self.id = valueDictionary["name"] as? String
        if let member = valueDictionary["member"] as? [String: Bool]{
            //Ohashi:辞書として取得したmemberの，keyだけ取得
            self.members = [String](member.keys)
        }
        if let games = valueDictionary["games"] as? [String: Bool]{
            self.games = [String](games.keys)
        }
        
        self.league = valueDictionary["league"] as? String
    }
    
}
