//
//  RootViewController.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/10/31.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit
import ESTabBarController

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()
    }
    
    func setupTab(){
        let tabBarController: ESTabBarController = ESTabBarController(tabIconNames: ["home", "game", "account"])
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
        let homeNavViewController = UINavigationController(rootViewController: HomeViewController())
        let accountViewController = AccountViewController()
        
        tabBarController.setView(homeNavViewController, at: 0)
        tabBarController.setView(accountViewController, at: 2)
        
        tabBarController.highlightButton(at: 1)
        tabBarController.setAction({
            let gameSuperViewController = GameSuperViewController()
            self.present(gameSuperViewController, animated: true, completion: nil)
        }, at: 1)
        
        
    }
    
    //Ohashi:TODOログインチェックメソッド
}
