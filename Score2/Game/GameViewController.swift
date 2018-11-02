//
//  ViewController.swift
//  GameScreen
//
//  Created by Kazuki Ohashi on 2018/10/30.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stadium")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let homeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("home", for: .normal)
        return button
    }()
    
    let firstBaseView = UIView()
    let secondBaseView = UIView()
    let thirdBaseView = UIView()
    let homeBaseView = UIView()
    
    let pitcherPlayerButton = UIButton()
    let catcherPlayerButton = UIButton()
    let firstPlayerButton = UIButton()
    let secondPlayerButton = UIButton()
    let thirdPlayerButton = UIButton()
    let shortPlayerButton = UIButton()
    let leftPlayerButton = UIButton()
    let centerPlayerButton = UIButton()
    let rightPlayerButton = UIButton()
    
    let pitcherOrCatcherHitButton = UIButton()
    let firstHitButton = UIButton()
    let secondHitButton = UIButton()
    let thirdHitButton = UIButton()
    let shortHitButton = UIButton()
    let leftHitButton = UIButton()
    let centerHitButton = UIButton()
    let rightHitButton = UIButton()
    let leftIntermediateHitButton = UIButton()
    let rightIntermediateHitButton = UIButton()
    let leftOverHitButton = UIButton()
    let centerOverHitButton = UIButton()
    let rightOverHitButton = UIButton()
    
    var baseViewArray: [UIView] = []
    var playerButtonArray: [UIButton] = []
    var playerOriginArray: [CGPoint] = []
    var hitButtonArray: [UIButton] = []
    
    
    
    //Ohashi:ドラッグ時初期位置取得用変数
    var panStartPoint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Ohashi:配列に格納
        baseViewArray = [firstBaseView, secondBaseView, thirdBaseView, homeBaseView]
        playerButtonArray = [pitcherPlayerButton, catcherPlayerButton, firstPlayerButton, secondPlayerButton, thirdPlayerButton, shortPlayerButton, leftPlayerButton, centerPlayerButton, rightPlayerButton]
        hitButtonArray = [pitcherOrCatcherHitButton, firstHitButton, secondHitButton, thirdHitButton, shortHitButton, leftHitButton, centerHitButton, rightHitButton, leftIntermediateHitButton, rightIntermediateHitButton, leftOverHitButton, centerOverHitButton, rightOverHitButton]
        
        setupView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Situation.playingGame == nil {
            let startingGameViewController = StartingGameViewController()
            startingGameViewController.modalPresentationStyle = .custom
            startingGameViewController.transitioningDelegate = self
            self.present(startingGameViewController, animated: true, completion: nil)
        }
    }
    
    func setupView(){
        self.view.addSubview(backgroundImageView)
        self.homeButton.addTarget(self, action: #selector(homeButton(sender:)), for: .touchUpInside)
        self.view.addSubview(homeButton)
        
        baseViewArray.forEach{
            //Ohashi:ベースのautolayout適用，viewに追加
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .clear
            self.view.addSubview($0)
            self.view.addConstraints([NSLayoutConstraint(item: $0, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.13, constant: 0)])
            self.view.addConstraints([NSLayoutConstraint(item: $0, attribute: .height, relatedBy: .equal, toItem: $0, attribute: .width, multiplier: 1.0, constant: 0)])
        }
        
        for (index, value) in playerButtonArray.enumerated(){
            //Ohashi: 各ボタンautolayout適用して，画像をセットして，viewに追加
            value.translatesAutoresizingMaskIntoConstraints = false
            value.setImage(UIImage(named: "player"), for: .normal)
            value.tag = index + 1
            value.addTarget(self, action: #selector(self.pushedPlayerButton(sender:)), for: .touchUpInside)
            self.view.addSubview(value)
            
            //ohashi: 各ボタンサイズ設定
            self.view.addConstraints([NSLayoutConstraint(item: value, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.1, constant: 0)])
            self.view.addConstraints([NSLayoutConstraint(item: value, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.07, constant: 0)])
        }
        //Ohashi:内野手にだけドラッグつける
        let pitcherPan = UIPanGestureRecognizer(target: self, action: #selector(self.handlePitcherPan(sender:)))
        pitcherPlayerButton.addGestureRecognizer(pitcherPan)
        let catcherPan = UIPanGestureRecognizer(target: self, action: #selector(self.handleCatcherPan(sender:)))
        catcherPlayerButton.addGestureRecognizer(catcherPan)
        let firstPan = UIPanGestureRecognizer(target: self, action: #selector(self.handleFirstPan(sender:)))
        firstPlayerButton.addGestureRecognizer(firstPan)
        let secondPan = UIPanGestureRecognizer(target: self, action: #selector(self.handleSecondPan(sender:)))
        secondPlayerButton.addGestureRecognizer(secondPan)
        let thirdPan = UIPanGestureRecognizer(target: self, action: #selector(self.handleThirdPan(sender:)))
        thirdPlayerButton.addGestureRecognizer(thirdPan)
        let shortPan = UIPanGestureRecognizer(target: self, action: #selector(self.handleShortPan(sender:)))
        shortPlayerButton.addGestureRecognizer(shortPan)
        
        for (index, value) in hitButtonArray.enumerated(){
            value.translatesAutoresizingMaskIntoConstraints = false
            value.setImage(UIImage(named: "hit"), for: .normal)
            value.tag = index + 101
            value.addTarget(self, action: #selector(self.pushedHitButton(sender:)), for: .touchUpInside)
            self.view.addSubview(value)
            self.view.addConstraints([NSLayoutConstraint(item: value, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.1, constant: 0)])
            self.view.addConstraints([NSLayoutConstraint(item: value, attribute: .height, relatedBy: .equal, toItem: value, attribute: .width, multiplier: 1, constant: 0)])
        }
        
        //Ohashi:以下制約
        //Ohashi:背景
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: [], metrics: nil, views: ["v0": backgroundImageView] ))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: [], metrics: nil, views: ["v0": backgroundImageView] ))
        //Ohashi:ピッチャー
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[0], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[0], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 50)])
        //Ohashi:キャッチャー
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[1], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[1], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 260)])
        //Ohashi:ファースト
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[2], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 150)])
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[2], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0)])
        //Ohashi:セカンド
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[3], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 90)])
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[3], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -100)])
        //Ohashi:サード
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[4], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: -150)])
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[4], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0)])
        //Ohashi:ショート
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[5], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: -90)])
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[5], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -100)])
        //Ohashi:レフト
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[6], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: -150)])
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[6], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -210)])
        //Ohashi:センター
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[7], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[7], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -230)])
        //Ohashi:ライト
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[8], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 150)])
        self.view.addConstraints([NSLayoutConstraint(item: playerButtonArray[8], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -210)])
        //Ohashi:ファーストベース
        self.view.addConstraints([NSLayoutConstraint(item: baseViewArray[0], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 140)])
        self.view.addConstraints([NSLayoutConstraint(item: baseViewArray[0], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 60)])
        //Ohashi:セカンドベース
        self.view.addConstraints([NSLayoutConstraint(item: baseViewArray[1], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: baseViewArray[1], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -90)])
        //Ohashi:サードベース
        self.view.addConstraints([NSLayoutConstraint(item: baseViewArray[2], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: -140)])
        self.view.addConstraints([NSLayoutConstraint(item: baseViewArray[2], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 60)])
        //Ohashi:ホームベース
        self.view.addConstraints([NSLayoutConstraint(item: baseViewArray[3], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: baseViewArray[3], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 200)])
        
        //Ohashi:ピッチャーヒット
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[0], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[0], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 140)])
        //Ohashi:ファーストヒット
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[1], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 90)])
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[1], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 70)])
        //Ohashi:セカンドヒット
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[2], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 70)])
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[2], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -30)])
        //Ohashi:サードヒット
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[3], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: -90)])
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[3], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 70)])
        //Ohashi:ショートヒット
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[4], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: -70)])
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[4], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -30)])
        //Ohashi:レフトヒット
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[5], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: -140)])
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[5], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -140)])
        //Ohashi:センターヒット
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[6], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[6], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -170)])
        //Ohashi:ライトヒット
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[7], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 140)])
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[7], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -140)])
        //Ohashi:左中間ヒット
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[8], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: -80)])
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[8], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -230)])
        //Ohashi:右中間ヒット
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[9], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 80)])
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[9], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -230)])
        //Ohashi:レフトオーバー
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[10], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: -160)])
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[10], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -270)])
        //Ohashi:センターオーバー
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[11], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[11], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -290)])
        //Ohashi:ライトオーバー
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[12], attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 160)])
        self.view.addConstraints([NSLayoutConstraint(item: hitButtonArray[12], attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -270)])
        //Ohashi:ホームボタン
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[home]", options: .alignAllTop, metrics: nil, views: ["home": homeButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[home]-50-|", options: .alignAllTop, metrics: nil, views: ["home": homeButton]))
        
    }
    
    //Ohashi:ドラッグメソッド
    @objc func handlePitcherPan(sender: UIPanGestureRecognizer){
        handlePan(sender: sender, throwToFirst: .catcherFly, throwToSecond: .catcherFly, throwToThird: .catcherFly, throwToHome: .catcherFly)
    }
    @objc func handleCatcherPan(sender: UIPanGestureRecognizer){
        handlePan(sender: sender, throwToFirst: .catcherFly, throwToSecond: .catcherFly, throwToThird: .catcherFly, throwToHome: .catcherFly)
    }
    @objc func handleFirstPan(sender: UIPanGestureRecognizer){
        handlePan(sender: sender, throwToFirst: .catcherFly, throwToSecond: .catcherFly, throwToThird: .catcherFly, throwToHome: .catcherFly)
    }
    @objc func handleSecondPan(sender: UIPanGestureRecognizer){
        handlePan(sender: sender, throwToFirst: .catcherFly, throwToSecond: .catcherFly, throwToThird: .catcherFly, throwToHome: .catcherFly)
    }
    @objc func handleThirdPan(sender: UIPanGestureRecognizer){
        handlePan(sender: sender, throwToFirst: .catcherFly, throwToSecond: .catcherFly, throwToThird: .catcherFly, throwToHome: .catcherFly)
    }
    @objc func handleShortPan(sender: UIPanGestureRecognizer){
        handlePan(sender: sender, throwToFirst: .catcherFly, throwToSecond: .catcherFly, throwToThird: .catcherFly, throwToHome: .catcherFly)
    }
    
    func handlePan(sender: UIPanGestureRecognizer, throwToFirst: ResultEnum, throwToSecond: ResultEnum, throwToThird: ResultEnum, throwToHome: ResultEnum){
        let panView = sender.view!
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began:
            panStartPoint = panView.center
            print(panStartPoint)
        case  .changed:
            panView.center = CGPoint(x: panView.center.x + translation.x, y: panView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
            if panView.frame.intersects(baseViewArray[0].frame){
                baseViewArray[0].backgroundColor = .red
            }else if panView.frame.intersects(baseViewArray[1].frame){
                baseViewArray[1].backgroundColor = .red
            }else if panView.frame.intersects(baseViewArray[2].frame){
                baseViewArray[2].backgroundColor = .red
            }else if panView.frame.intersects(baseViewArray[3].frame){
                baseViewArray[3].backgroundColor = .red
            }else{
                baseViewArray[0].backgroundColor = .clear
                baseViewArray[1].backgroundColor = .clear
                baseViewArray[2].backgroundColor = .clear
                baseViewArray[3].backgroundColor = .clear
            }
        case .ended:
            if panView.frame.intersects(baseViewArray[0].frame){
                UIView.animate(withDuration: 0.5, animations: {
                    panView.alpha = 0
                    self.baseViewArray[0].backgroundColor = .clear
                })
                Situation.result = throwToFirst
                modalAppear()
                
            }else if panView.frame.intersects(baseViewArray[1].frame){
                UIView.animate(withDuration: 0.5, animations: {
                    panView.alpha = 0
                    self.baseViewArray[1].backgroundColor = .clear
                })
                Situation.result = throwToSecond
                modalAppear()
            }else if panView.frame.intersects(baseViewArray[2].frame){
                UIView.animate(withDuration: 0.5, animations: {
                    panView.alpha = 0
                    self.baseViewArray[2].backgroundColor = .clear
                })
                Situation.result = throwToThird
                modalAppear()
                
            }else if panView.frame.intersects(baseViewArray[3].frame){
                UIView.animate(withDuration: 0.5, animations: {
                    panView.alpha = 0
                    self.baseViewArray[3].backgroundColor = .clear
                })
                Situation.result = throwToHome
                modalAppear()
            }else{
                UIView.animate(withDuration: 0.5, animations: {
                    panView.center = self.panStartPoint
                })
            }
        default:
            break
        }
    }
    //Ohashi:結果モーダル表示用メソッド
    func modalAppear(){
        let resultViewController = ResultViewController()
        resultViewController.modalPresentationStyle = .custom
        resultViewController.transitioningDelegate = self
        self.present(resultViewController, animated: true, completion: nil)
    }
    //Ohashi:フライボタン用メソッド
    @objc func pushedPlayerButton(sender: UIButton){
        switch sender.tag {
        case 1:
            Situation.result = .pitcherFly
        case 2:
            Situation.result = .catcherFly
        case 3:
            Situation.result = .firstFly
        case 4:
            Situation.result = .secondFly
        case 5:
            Situation.result = .thirdFly
        case 6:
            Situation.result = .shortFly
        case 7:
            Situation.result = .leftFly
        case 8:
            Situation.result = .centerFly
        case 9:
            Situation.result = .rightFly
        default:
            break
        }
        print(Situation.result)
        modalAppear()
    }
    //Ohashi:ヒットボタン用メソッド
    @objc func pushedHitButton(sender: UIButton){
        switch sender.tag {
        case 101:
            Situation.result = .pitcherOrCatcherHit
        case 102:
            Situation.result = .firstHit
        default:
            break
        }
        modalAppear()
    }
    
    @objc func homeButton(sender: UIButton){
//        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        //Ohashi:仮
        self.dismiss(animated: true, completion: nil)
    }
}



