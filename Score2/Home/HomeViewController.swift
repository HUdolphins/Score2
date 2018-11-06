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

    var gamesArray: [FIRGame] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.leftBarButtonItem))
        setData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesArray.count
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        //Ohashi:セルのタイトル用にチーム名取得
        let game = gamesArray[indexPath.row]
        var topTeamName: String?
        var botTeamName: String?
        
        //Ohashi:強制アンラップ多用。大丈夫か。
        Database.database().reference().child(Const.teamPath).child(game.topTeamKey!).child("name").observeSingleEvent(of: .value) { (snapshot) in
            let valueDictionary = snapshot.value as! [String: Any]
            topTeamName = valueDictionary["name"] as? String
        }
        Database.database().reference().child(Const.teamPath).child(game.botTeamKey!).child("name").observeSingleEvent(of: .value) { (snapshot) in
            let valueDictionary = snapshot.value as! [String: Any]
            botTeamName = valueDictionary["name"] as? String
        }
        //Ohashi:セルのタイトル設定
        cell.textLabel?.text = "\(topTeamName!)vs\(botTeamName!)"
        //Ohashi:セルの詳細に日付つける
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        cell.detailTextLabel?.text = formatter.string(from: game.date!)
        
        return cell
    }
    
    func setData(){
        Database.database().reference().child(Const.gamePath).observe(.childAdded) { (snapshot) in
            print(snapshot)
            self.gamesArray.append(FIRGame(snapshot: snapshot))
            self.tableView.reloadData()
        }
    }
    
    func handleLogout(){
        
    }
    @objc func leftBarButtonItem(){
        
    }
}
