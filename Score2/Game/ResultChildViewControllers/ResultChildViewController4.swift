//
//  ResultChildViewController4.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/11/01.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit

class ResultChildViewController4: UIViewController {

    //Ohashi:ひとまず他と同じ形で仮置き
    
    var resultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var resultTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    var commentTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("send", for: .normal)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("cancel", for: .normal)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupView()
    }
    
    func setupView(){
        view.addSubview(resultImageView)
        view.addSubview(resultTextView)
        view.addSubview(commentTextField)
        view.addSubview(sendButton)
        view.addSubview(cancelButton)
    }
    

}
