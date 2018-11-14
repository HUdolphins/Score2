//
//  CreateAccountViewController.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/11/13.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit

class CreateAccountViewController: UIViewController, FBSDKLoginButtonDelegate{
    
    

    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "あなたの野球にテクノロジーを。"
        textView.backgroundColor = .white
        return textView
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ログイン", for: .normal)
        return button
    }()
    
    let trialButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("スコア記入体験へ", for: .normal)
        button.addTarget(self, action: #selector(trialGame(sender:)), for: .touchUpInside)
        return button
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "表示名"
        return textField
    }()
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "メールアドレス"
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "パスワード(6文字以上)"
        return textField
    }()

    let createAccountButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("アカウント作成", for: .normal)
        button.addTarget(self, action: #selector(createAccount(sender:)), for: .touchUpInside)
        return button
    }()

    let faceBookButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    

    func setupView(){
        faceBookButton.delegate = self
        
        self.view.addSubview(textView)
        self.view.addSubview(loginButton)
        self.view.addSubview(trialButton)
        self.view.addSubview(nameTextField)
        self.view.addSubview(addressTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(createAccountButton)
        self.view.addSubview(faceBookButton)
        
        //Ohashi:以下制約
        textView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[text]-[name]-[address]-[password]-[create]-[facebook]", options: .alignAllCenterX, metrics: nil, views: ["text": textView, "name": nameTextField, "address": addressTextField, "password": passwordTextField, "create": createAccountButton, "facebook": faceBookButton]))
    }
    
    @objc func createAccount(sender: UIButton){
        if let address = addressTextField.text, let password = passwordTextField.text, let name = nameTextField.text {
            
            // アドレスとパスワードと表示名のいずれかでも入力されていない時は何もしない
            if address.isEmpty || password.isEmpty || name.isEmpty {
                print("DEBUG_PRINT: 何かが空文字です。")
                return
            }
            
            Auth.auth().createUser(withEmail: address, password: password) { (user, error) in
                if let error = error {
                    // エラーがあったら原因をprintして、returnすることで以降の処理を実行せずに処理を終了する
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    return
                }
                print("DEBUG_PRINT: ユーザー作成に成功しました。")
                
                let user = Auth.auth().currentUser
                if let user = user {
                    user.createProfileChangeRequest().displayName = name
                    user.createProfileChangeRequest().commitChanges { (error) in
                        if let error = error {
                            // プロフィールの更新でエラーが発生
                            print("DEBUG_PRINT: " + error.localizedDescription)
                            return
                        }
                        print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func trialGame(sender: UIButton){
        let trialGameViewController = TrialGameViewController()
        self.present(trialGameViewController, animated: true, completion: nil)
    }
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error == nil {
            if result.isCancelled {
                print("キャンセル")
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            print("エラー")
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
}
