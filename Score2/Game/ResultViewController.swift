//
//  ResultViewController.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/10/31.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var resultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func setupView(){
        self.view.addSubview(resultImageView)
        
        
    }

}
