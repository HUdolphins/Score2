//
//  ReadingGameViewController.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/11/07.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit

class ReadingGameViewController: UIViewController {

    var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("編集する", for: .normal)
        return button
    }()
    
    var teamLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    
    func setupView(){
        self.view.addSubview(editButton)
        self.view.addSubview(teamLabel)
        
        editButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[team]-50-[edit]", options: .alignAllCenterX, metrics: nil, views: ["team": teamLabel, "edit": editButton]))
    }
}
