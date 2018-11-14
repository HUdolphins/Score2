//
//  GameSuperViewController.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/11/01.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit
import ESTabBarController

class GameSuperViewController: UIViewController {

    let gameViewController = GameViewController()
    let topTeamViewController = TopTeamViewController()
    let bottomTeamViewController = BottomTeamViewController()
    let gameSettingViewController = GameSettingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTab()
    }
    
    func setupTab(){
        let tabBarController: ESTabBarController = ESTabBarController(tabIconNames: ["game", "home", "home", "home", "home"])
        tabBarController.selectedColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        tabBarController.buttonsBackgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabBarController.selectionIndicatorHeight = 3
        
        addChild(tabBarController)
        let tabBarView = tabBarController.view!
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBarView)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([tabBarView.topAnchor.constraint(equalTo: safeArea.topAnchor), tabBarView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor), tabBarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor), tabBarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)])
        tabBarController.didMove(toParent: self)
       
        
        tabBarController.setView(gameViewController, at: 0)
        tabBarController.setView(topTeamViewController, at: 2)
        tabBarController.setView(bottomTeamViewController, at: 3)
        tabBarController.setView(gameSettingViewController, at: 4)
        
        tabBarController.tabBarController?.tabBar.items![2].badgeValue = "\(Situation.topScore)"
        tabBarController.tabBarController?.tabBar.items![2].badgeColor = .red
        tabBarController.tabBarController?.tabBar.items![3].badgeValue = "\(Situation.bottomScore)"
        
        tabBarController.highlightButton(at: 1)
        tabBarController.setAction({
            let videoViewController = VideoViewController()
            self.present(videoViewController, animated: true, completion: nil)
        }, at: 1)
        
    }
    
    func reloadSituation(){
        
        if Situation.ballCounts == 0{
            gameViewController.ballOneImageView.alpha = 0
            gameViewController.ballTwoImageView.alpha = 0
            gameViewController.ballThreeImageView.alpha = 0
        }
        if Situation.strikeCounts == 0{
            gameViewController.strikeOneImageView.alpha = 0
            gameViewController.strikeTwoImageView.alpha = 0
        }
        if Situation.outCounts == 0{
            gameViewController.outOneImageView.alpha = 0
            gameViewController.outTwoImageView.alpha = 0
        }else if Situation.outCounts == 1{
            gameViewController.outOneImageView.alpha = 1
            gameViewController.outTwoImageView.alpha = 0
        }else{
            gameViewController.outOneImageView.alpha = 1
            gameViewController.outTwoImageView.alpha = 1
        }
        
        if Situation.firstRunner == nil && Situation.secondRunner == nil && Situation.thirdRunner == nil{
            gameViewController.backgroundImageView.image = UIImage(named: "base0-0-0")
        }else if Situation.firstRunner != nil && Situation.secondRunner == nil && Situation.thirdRunner == nil{
            gameViewController.backgroundImageView.image = UIImage(named: "base1-0-0")
        }else if Situation.firstRunner == nil && Situation.secondRunner != nil && Situation.thirdRunner == nil{
            gameViewController.backgroundImageView.image = UIImage(named: "base0-1-0")
        }else if Situation.firstRunner == nil && Situation.secondRunner == nil && Situation.thirdRunner != nil{
            gameViewController.backgroundImageView.image = UIImage(named: "base0-0-1")
        }else if Situation.firstRunner != nil && Situation.secondRunner != nil && Situation.thirdRunner == nil{
            gameViewController.backgroundImageView.image = UIImage(named: "base1-1-0")
        }else if Situation.firstRunner != nil && Situation.secondRunner == nil && Situation.thirdRunner != nil{
            gameViewController.backgroundImageView.image = UIImage(named: "base1-0-1")
        }else if Situation.firstRunner == nil && Situation.secondRunner != nil && Situation.thirdRunner != nil{
            gameViewController.backgroundImageView.image = UIImage(named: "base0-1-1")
        }else if Situation.firstRunner != nil && Situation.secondRunner != nil && Situation.thirdRunner != nil{
            gameViewController.backgroundImageView.image = UIImage(named: "base1-1-1")
        }
    }

}
