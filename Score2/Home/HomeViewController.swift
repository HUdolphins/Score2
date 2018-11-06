//
//  HomeViewController.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/10/31.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeViewController: UITableViewController{

    var dataArray: [FIRGame] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func setData(){
        Database.database().reference().child(Const.gamePath).observe(.childAdded) { (snapshot) in
            print(snapshot)
            self.dataArray.append(FIRGame(snapshot: snapshot))
        }
    }
    
    func handleLogout(){
        
    }
    
}
