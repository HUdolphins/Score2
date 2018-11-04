//
//  StartingGameViewController.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/11/02.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit
import PageMenu
import FirebaseDatabase

class StartingGameViewController: UIViewController {
    
    
    let gameStatusViewController = GameStatusViewController()
    let topPlayerSettingViewController = TopPlayerSettingViewController()
    let bottomPlayerSettingViewController = BottomPlayerSettingViewController()
    

    var pageMenu: CAPSPageMenu?
    var startingGameViewControllers: [UIViewController] = []
    
    var topPlayerNameArray: [String] = []
    var topPlayerUniNumberArray : [String] = []
    var bottomPlayerNameArray: [String] = []
    var bottomPlaterNumberArray: [String] = []
    
    //Ohashi:送信用辞書
    var topPlayersDic:[String:Bool] = [:]
    var bottomPlayerDic: [String:Bool] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageMenu()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupPageMenu(){
        
        startingGameViewControllers = [gameStatusViewController, topPlayerSettingViewController, bottomPlayerSettingViewController]
        //Ohashi:メニューバーのタイトル設定
        gameStatusViewController.title = "試合設定"
        topPlayerSettingViewController.title = "先攻"
        bottomPlayerSettingViewController.title = "後攻"
        //Ohashi:各ビューのデフォルト値設定
        topPlayerSettingViewController.teamNameTextField.text = "チームA"
        bottomPlayerSettingViewController.teamNameTextField.text = "チームB"
        
        let topNameTFArray = [topPlayerSettingViewController.playerName1, topPlayerSettingViewController.playerName2, topPlayerSettingViewController.playerName3, topPlayerSettingViewController.playerName4, topPlayerSettingViewController.playerName5, topPlayerSettingViewController.playerName6, topPlayerSettingViewController.playerName7, topPlayerSettingViewController.playerName8, topPlayerSettingViewController.playerName9]
        for (index, value) in topNameTFArray.enumerated(){
            value.text = "Player\(index + 1)"
        }
        
        let bottomNameTFArray = [bottomPlayerSettingViewController.playerName1, bottomPlayerSettingViewController.playerName2, bottomPlayerSettingViewController.playerName3, bottomPlayerSettingViewController.playerName4, bottomPlayerSettingViewController.playerName5, bottomPlayerSettingViewController.playerName6, bottomPlayerSettingViewController.playerName7, bottomPlayerSettingViewController.playerName8, bottomPlayerSettingViewController.playerName9]
        for (index, value) in bottomNameTFArray.enumerated(){
            value.text = "Player\(index + 1)"
        }
        
        let topNumberTFArray = [topPlayerSettingViewController.uniformNumber1, topPlayerSettingViewController.uniformNumber2, topPlayerSettingViewController.uniformNumber3, topPlayerSettingViewController.uniformNumber4, topPlayerSettingViewController.uniformNumber5, topPlayerSettingViewController.uniformNumber6, topPlayerSettingViewController.uniformNumber7, topPlayerSettingViewController.uniformNumber8, topPlayerSettingViewController.uniformNumber9]
        for (index, value) in topNumberTFArray.enumerated(){
            value.text = "\(index + 1)"
        }
        
        let bottomNumberTFArray = [bottomPlayerSettingViewController.uniformNumber1, bottomPlayerSettingViewController.uniformNumber2, bottomPlayerSettingViewController.playerName3, bottomPlayerSettingViewController.uniformNumber4, bottomPlayerSettingViewController.uniformNumber5, bottomPlayerSettingViewController.uniformNumber6, bottomPlayerSettingViewController.uniformNumber7, bottomPlayerSettingViewController.uniformNumber8, bottomPlayerSettingViewController.uniformNumber9]
        for (index, value) in bottomNumberTFArray.enumerated(){
            value.text = "\(index + 1)"
        }
        
        gameStatusViewController.gameStartButton.addTarget(self, action: #selector(gameStart(sender:)), for: .touchUpInside)
        gameStatusViewController.cancelButton.addTarget(self, action: #selector(cancel(sender:)), for: .touchUpInside)
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.0),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.0),
            .scrollMenuBackgroundColor(#colorLiteral(red: 0, green: 0.3764705882, blue: 0.01568627451, alpha: 1)),
            .selectionIndicatorColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        ]
        
        pageMenu =  CAPSPageMenu(viewControllers: startingGameViewControllers, frame: view.bounds, pageMenuOptions: parameters)
        view.addSubview(pageMenu!.view)
    }
    
    @objc func gameStart(sender: UIButton){
        let gameRef = Database.database().reference().child(Const.gamePath)
        let playerRef = Database.database().reference().child(Const.playerPath)
        
        //Ohashi:空欄がある時の処理
        
        //Ohashi:ゲームデータ作成
        if let topTeamName = topPlayerSettingViewController.teamNameTextField.text, let bottomTeamName = bottomPlayerSettingViewController.teamNameTextField.text, let stadium = gameStatusViewController.stadiumTextField.text{
            
            let time = Date.timeIntervalSinceReferenceDate
            let gameData = ["topTeam": topTeamName, "bottomTeam": bottomTeamName, "time": String(time), "stadium": stadium] as [String : Any]
            Situation.gameId = gameRef.childByAutoId().key
            print("DEBUG_PRINT: gameIdセット")
            gameRef.child(Situation.gameId).setValue(gameData)
        }
        
        //Ohashi:先攻の選手データ作成
        if let topTeamName = topPlayerSettingViewController.teamNameTextField.text, let topPlayer1Name = topPlayerSettingViewController.playerName1.text, let topPlayer2Name = topPlayerSettingViewController.playerName2.text, let topPlayer3Name = topPlayerSettingViewController.playerName3.text, let topPlayer4Name = topPlayerSettingViewController.playerName4.text, let topPlayer5Name = topPlayerSettingViewController.playerName5.text, let topPlayer6Name = topPlayerSettingViewController.playerName6.text, let topPlayer7Name = topPlayerSettingViewController.playerName7.text, let topPlayer8Name = topPlayerSettingViewController.playerName8.text, let topPlayer9Name = topPlayerSettingViewController.playerName9.text, let topPlayer1Number = topPlayerSettingViewController.uniformNumber1.text, let topPlayer2Number = topPlayerSettingViewController.uniformNumber2.text, let topPlayer3Number = topPlayerSettingViewController.uniformNumber3.text, let topPlayer4Number = topPlayerSettingViewController.uniformNumber4.text, let topPlayer5Number = topPlayerSettingViewController.uniformNumber5.text, let topPlayer6Number = topPlayerSettingViewController.uniformNumber6.text, let topPlayer7Number = topPlayerSettingViewController.uniformNumber7.text, let topPlayer8Number = topPlayerSettingViewController.uniformNumber8.text, let topPlayer9Number = topPlayerSettingViewController.uniformNumber9.text{
            
            //Ohashi:配列に格納
            topPlayerNameArray = [topPlayer1Name, topPlayer2Name, topPlayer3Name, topPlayer4Name, topPlayer5Name, topPlayer6Name, topPlayer7Name, topPlayer8Name, topPlayer9Name]
            topPlayerUniNumberArray = [topPlayer1Number, topPlayer2Number, topPlayer3Number, topPlayer4Number, topPlayer5Number, topPlayer5Number, topPlayer6Number, topPlayer7Number, topPlayer8Number, topPlayer9Number]
            
            //Ohashi:それぞれデータをセットし，gameの方にもセットするように辞書にidを入れる。
            for index in 0...8{
                let batterData = ["name": topPlayerNameArray[index], "uniNum": topPlayerUniNumberArray[index], "team": topTeamName]
                let key = playerRef.childByAutoId().key
                playerRef.child(key).setValue(batterData)
                topPlayersDic[key] = true
                print("DEBUG_PRINT: topPlayerセット")
            }
        }
        
        //Ohashi:後攻の選手データ作成
        if let bottomTeamName = bottomPlayerSettingViewController.teamNameTextField.text, let bottomPlayer1Name = bottomPlayerSettingViewController.playerName1.text, let bottomPlayer2Name = bottomPlayerSettingViewController.playerName2.text, let bottomPlayer3Name = bottomPlayerSettingViewController.playerName3.text, let bottomPlayer4Name = bottomPlayerSettingViewController.playerName4.text, let bottomPlayer5Name = bottomPlayerSettingViewController.playerName5.text, let bottomPlayer6Name = bottomPlayerSettingViewController.playerName6.text, let bottomPlayer7Name = bottomPlayerSettingViewController.playerName7.text, let bottomPlayer8Name = bottomPlayerSettingViewController.playerName8.text, let bottomPlayer9Name = bottomPlayerSettingViewController.playerName9.text, let bottomPlayer1Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer2Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer3Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer4Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer5Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlaye6Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer7Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer8Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer9Number = bottomPlayerSettingViewController.uniformNumber1.text{
            
            //Ohashi:配列に格納
            bottomPlayerNameArray = [bottomPlayer1Name, bottomPlayer2Name, bottomPlayer3Name, bottomPlayer4Name, bottomPlayer5Name, bottomPlayer6Name, bottomPlayer7Name, bottomPlayer8Name, bottomPlayer9Name]
            bottomPlaterNumberArray = [bottomPlayer1Number, bottomPlayer2Number, bottomPlayer3Number, bottomPlayer4Number, bottomPlayer5Number, bottomPlaye6Number, bottomPlayer7Number, bottomPlayer8Number,bottomPlayer9Number]
          
            //Ohashi:それぞれデータをセットし，辞書にも追加
            for index in 0...8{
                let batterData = ["name": bottomPlayerNameArray[index], "uniNum": bottomPlaterNumberArray[index], "team": bottomTeamName]
                let key = playerRef.childByAutoId().key
                playerRef.child(key).setValue(batterData)
                bottomPlayerDic.updateValue(true, forKey: key)
                print("DEBUG_PRiNT:bottomPlayerセット")
            }
        }
    
        //Ohashi:ゲームの下にもプレイヤーセット
        gameRef.child(Situation.gameId).child("topPlayer").setValue(topPlayersDic)
        gameRef.child(Situation.gameId).child("botPlayer").setValue(bottomPlayerDic)
        
        //Ohashi:Situation.swiftの打順の配列にも入れておく
        //Ohashi:順番sortしないといけない
        for (key, value) in topPlayersDic{
            playerRef.child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot.value!)
                let player = FIRPlayer(snapshot: snapshot)
                Situation.topPlayerArray.append(player)
                print(player)
                })
        }
        for (key, value) in bottomPlayerDic{
            playerRef.child(key).observeSingleEvent(of: .value) { (snapshot) in
                Situation.bottomPlayerArray.append(FIRPlayer(snapshot: snapshot))
            }
        }
        
        //Ohashi:ここの順番よくわからない。
        print(Situation.topPlayerArray)
        //Ohashi:次の試合のために空にしておく。
        topPlayerNameArray.removeAll()
        bottomPlayerNameArray.removeAll()
        topPlayerUniNumberArray.removeAll()
        bottomPlaterNumberArray.removeAll()
        topPlayersDic.removeAll()
        bottomPlayerDic.removeAll()
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func cancel(sender: UIButton){
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        //Ohashi:他のとこの値をリセットする処理
    }
}
