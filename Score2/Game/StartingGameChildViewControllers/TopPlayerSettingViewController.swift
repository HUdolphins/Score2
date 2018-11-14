//
//  TopPlayerSettingViewController.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/11/02.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit

class TopPlayerSettingViewController: UIViewController {

    var teamNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "チーム名"
        return textField
    }()
    
    let orderLabel1 = UILabel()
    let orderLabel2 = UILabel()
    let orderLabel3 = UILabel()
    let orderLabel4 = UILabel()
    let orderLabel5 = UILabel()
    let orderLabel6 = UILabel()
    let orderLabel7 = UILabel()
    let orderLabel8 = UILabel()
    let orderLabel9 = UILabel()
    
    var playerName1 = UITextField()
    var playerName2 = UITextField()
    var playerName3 = UITextField()
    var playerName4 = UITextField()
    var playerName5 = UITextField()
    var playerName6 = UITextField()
    var playerName7 = UITextField()
    var playerName8 = UITextField()
    var playerName9 = UITextField()
    
//    var positionPickerView = UIPickerView()
    var positionPickerView1 = PositionPickerKeyboard()
    
    
    
    var uniformNumber1 = UITextField()
    var uniformNumber2 = UITextField()
    var uniformNumber3 = UITextField()
    var uniformNumber4 = UITextField()
    var uniformNumber5 = UITextField()
    var uniformNumber6 = UITextField()
    var uniformNumber7 = UITextField()
    var uniformNumber8 = UITextField()
    var uniformNumber9 = UITextField()
    
    var orderLabels: [UILabel] = []
    var playerNames: [UITextField] = []
    var uniformNumbers: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        orderLabels = [orderLabel1, orderLabel2, orderLabel3, orderLabel4, orderLabel5, orderLabel6, orderLabel7, orderLabel8, orderLabel9]
        playerNames = [playerName1, playerName2, playerName3, playerName4, playerName5, playerName6, playerName7, playerName8, playerName9]
        uniformNumbers = [uniformNumber1, uniformNumber2, uniformNumber3, uniformNumber4, uniformNumber5, uniformNumber6, uniformNumber7, uniformNumber8, uniformNumber9]
        
        self.view.addSubview(teamNameTextField)
        
        for (index, value) in orderLabels.enumerated(){
            value.translatesAutoresizingMaskIntoConstraints = false
            value.text = "\(index + 1)"
            self.view.addSubview(value)
        }
        
        for (index, value) in playerNames.enumerated(){
            value.translatesAutoresizingMaskIntoConstraints = false
//            value.text = "player\(index + 1)"
            self.view.addSubview(value)
        }
        
        for (index, value) in uniformNumbers.enumerated(){
            value.translatesAutoresizingMaskIntoConstraints = false
            value.text = "\(index + 1)"
            self.view.addSubview(value)
        }
        
        positionPickerView1.backgroundColor = .red
        positionPickerView1.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(positionPickerView1)
        positionPickerView1.textStore = positionPickerView1.data[0]
        positionPickerView1.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        positionPickerView1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        positionPickerView1.heightAnchor.constraint(equalTo: orderLabel1.heightAnchor).isActive = true
        positionPickerView1.widthAnchor.constraint(equalTo: orderLabel1.widthAnchor).isActive = true
        
        //Ohashi:以下制約
        let objects = ["team": teamNameTextField, "label1": orderLabel1, "label2": orderLabel2, "label3": orderLabel3, "label4": orderLabel4, "label5": orderLabel5, "label6": orderLabel6, "label7": orderLabel7, "label8": orderLabel8, "label9": orderLabel9, "name1": playerName1, "name2": playerName2, "name3": playerName3, "name4": playerName4, "name5": playerName5, "name6": playerName6, "name7": playerName7, "name8": playerName8, "name9": playerName9, "number1": uniformNumber1, "number2": uniformNumber2, "number3": uniformNumber3, "number4": uniformNumber4, "number5": uniformNumber5, "number6": uniformNumber6, "number7": uniformNumber7, "number8": uniformNumber8, "number9": uniformNumber9 ]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[label1]-8-[name1]-8-[number1]", options: .alignAllTop, metrics: nil, views: objects))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[team]-10-[label1]-8-[label2]-8-[label3]-8-[label4]-8-[label5]-8-[label6]-8-[label7]-8-[label8]-8-[label9]", options: .alignAllLeft, metrics: nil, views: objects))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:  "V:[name1]-8-[name2]-8-[name3]-8-[name4]-8-[name5]-8-[name6]-8-[name7]-8-[name8]-8-[name9]", options: .alignAllLeft, metrics: nil, views: objects))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[number1]-8-[number2]-8-[number3]-8-[number4]-8-[number5]-8-[number6]-8-[number7]-8-[number8]-[number9]", options: .alignAllLeft, metrics: nil, views: objects))
    }
    
}


