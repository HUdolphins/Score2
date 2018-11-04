//
//  ResultChildViewController1.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/11/01.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit

class ResultChildViewController1: UIViewController {

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
        button.backgroundColor = .red
        button.setTitle("send", for: .normal)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
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
        
        let objects = ["imageView": resultImageView, "textView": resultTextView, "comment": commentTextField, "send": sendButton, "cancel": cancelButton]
        
        
        resultImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        resultTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        commentTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[imageView]-[textView]-[comment]-[send]-[cancel]", options: .alignAllLeft, metrics: nil, views: objects))
    }
}
