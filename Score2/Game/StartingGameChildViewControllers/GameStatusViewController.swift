//
//  GameStatusViewController.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/11/02.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit

class GameStatusViewController: UIViewController {

    var stadiumTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "球場名"
        return textField
    }()
    
    let gameStartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("PlayBall", for: .normal)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("cancel", for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    

    func setupView(){
        self.view.addSubview(stadiumTextField)
        self.view.addSubview(gameStartButton)
        self.view.addSubview(cancelButton)
        
        
        gameStartButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
         gameStartButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[stadium]-10-[gameStart]-10-[cancel]", options: .alignAllCenterX, metrics: nil, views: ["stadium": stadiumTextField, "gameStart": gameStartButton, "cancel": cancelButton]))
    }

   
}
