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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageMenu()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupPageMenu(){
        
        startingGameViewControllers = [gameStatusViewController, topPlayerSettingViewController, bottomPlayerSettingViewController]
        
        gameStatusViewController.title = "試合設定"
        topPlayerSettingViewController.title = "先攻"
        bottomPlayerSettingViewController.title = "後攻"
        
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
        let gameRef = Database.database().reference().child("game")
        let playerRef = Database.database().reference().child("player")
        
        //Ohashi:先攻の選手データ作成
        if let topTeamName = topPlayerSettingViewController.teamNameTextField.text, let topPlayer1Name = topPlayerSettingViewController.playerName1.text, let topPlayer2Name = topPlayerSettingViewController.playerName2.text, let topPlayer3Name = topPlayerSettingViewController.playerName3.text, let topPlayer4Name = topPlayerSettingViewController.playerName4.text, let topPlayer5Name = topPlayerSettingViewController.playerName5.text, let topPlayer6Name = topPlayerSettingViewController.playerName6.text, let topPlayer7Name = topPlayerSettingViewController.playerName7.text, let topPlayer8Name = topPlayerSettingViewController.playerName8.text, let topPlayer9Name = topPlayerSettingViewController.playerName9.text, let topPlayer1Number = topPlayerSettingViewController.uniformNumber1.text, let topPlayer2Number = topPlayerSettingViewController.uniformNumber2.text, let topPlayer3Number = topPlayerSettingViewController.uniformNumber3.text, let topPlayer4Number = topPlayerSettingViewController.uniformNumber4.text, let topPlayer5Number = topPlayerSettingViewController.uniformNumber5.text, let topPlayer6Number = topPlayerSettingViewController.uniformNumber6.text, let topPlayer7Number = topPlayerSettingViewController.uniformNumber7.text, let topPlayer8Number = topPlayerSettingViewController.uniformNumber8.text, let topPlayer9Number = topPlayerSettingViewController.uniformNumber9.text{
            
            topPlayerNameArray = [topPlayer1Name, topPlayer2Name, topPlayer3Name, topPlayer4Name, topPlayer5Name, topPlayer6Name, topPlayer7Name, topPlayer8Name, topPlayer9Name]
            topPlayerUniNumberArray = [topPlayer1Number, topPlayer2Number, topPlayer3Number, topPlayer4Number, topPlayer5Number, topPlayer5Number, topPlayer6Number, topPlayer7Number, topPlayer8Number, topPlayer9Number]
            
            for index in 0...8{
                let batterData = ["name": topPlayerNameArray[index], "uniNum": topPlayerUniNumberArray[index], "team": topTeamName]
                playerRef.childByAutoId().setValue(batterData)
            }
        }
        //Ohashi:後攻の選手データ作成
        if let bottomTeamName = bottomPlayerSettingViewController.teamNameTextField.text, let bottomPlayer1Name = bottomPlayerSettingViewController.playerName1.text, let bottomPlayer2Name = bottomPlayerSettingViewController.playerName2.text, let bottomPlayer3Name = bottomPlayerSettingViewController.playerName3.text, let bottomPlayer4Name = bottomPlayerSettingViewController.playerName4.text, let bottomPlayer5Name = bottomPlayerSettingViewController.playerName5.text, let bottomPlayer6Name = bottomPlayerSettingViewController.playerName6.text, let bottomPlayer7Name = bottomPlayerSettingViewController.playerName7.text, let bottomPlayer8Name = bottomPlayerSettingViewController.playerName8.text, let bottomPlayer9Name = bottomPlayerSettingViewController.playerName9.text, let bottomPlayer1Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer2Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer3Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer4Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer5Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlaye6Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer7Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer8Number = bottomPlayerSettingViewController.uniformNumber1.text, let bottomPlayer9Number = bottomPlayerSettingViewController.uniformNumber1.text{
            
            bottomPlayerNameArray = [bottomPlayer1Name, bottomPlayer2Name, bottomPlayer3Name, bottomPlayer4Name, bottomPlayer5Name, bottomPlayer6Name, bottomPlayer7Name, bottomPlayer8Name, bottomPlayer9Name]
            bottomPlaterNumberArray = [bottomPlayer1Number, bottomPlayer2Number, bottomPlayer3Number, bottomPlayer4Number, bottomPlayer5Number, bottomPlaye6Number, bottomPlayer7Number, bottomPlayer8Number,bottomPlayer9Number]
            
            for index in 0...8{
                let batterData = ["name": bottomPlayerNameArray[index], "uniNum": bottomPlaterNumberArray[index], "team": bottomTeamName]
                playerRef.childByAutoId().setValue(batterData)
            }
            
        }
    
        //Ohashi:ゲームデータ作成
        if let topTeamName = topPlayerSettingViewController.teamNameTextField.text, let bottomTeamName = bottomPlayerSettingViewController.teamNameTextField.text, let stadium = gameStatusViewController.stadiumTextField.text{
            let time = Date.timeIntervalSinceReferenceDate
            let gameData = ["topTeam": topTeamName, "bottomTeam": bottomTeamName, "time": String(time), "stadium": stadium]
            gameRef.childByAutoId().setValue(gameData)
            
        }
       
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func cancel(sender: UIButton){
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        //Ohashi:他のとこの値をリセットする処理
    }
}
