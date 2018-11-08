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
        imageView.image = UIImage(named: "base0-0-0")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let countImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "count3-2-2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let homeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("home", for: .normal)
        return button
    }()
    
    let strikeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "見逃し"), for: .normal)
        return button
    }()
    
    let takeALookButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "見送り"), for: .normal)
        return button
    }()
    
    let swingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "空振り"), for: .normal)
        return button
    }()
    
    let faulButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ファール"), for: .normal)
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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Ohashi:セットアップビューはエクステンションに
        setupView()
        setCount()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Ohashi:試合中はgameid入っているから試合開始の時だけ呼ばれる
        if Situation.gameId == nil {
            let startingGameViewController = StartingGameViewController()
            startingGameViewController.modalPresentationStyle = .custom
            startingGameViewController.transitioningDelegate = self
            self.present(startingGameViewController, animated: true, completion: nil)
        }
        
        print(Situation.topPlayerArray)
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
                }, completion:{ _ in
                    panView.center = self.panStartPoint
                    panView.alpha = 1
                })
                Situation.result = throwToFirst
                modalAppear()
            }else if panView.frame.intersects(baseViewArray[1].frame){
                UIView.animate(withDuration: 0.5, animations: {
                    panView.alpha = 0
                    self.baseViewArray[1].backgroundColor = .clear
                }, completion:{ _ in
                    panView.center = self.panStartPoint
                    panView.alpha = 1
                })
                
                Situation.result = throwToSecond
                modalAppear()
            }else if panView.frame.intersects(baseViewArray[2].frame){
                UIView.animate(withDuration: 0.5, animations: {
                    panView.alpha = 0
                    panView.center = self.panStartPoint
                    self.baseViewArray[2].backgroundColor = .clear
                }, completion:{ _ in
                    panView.center = self.panStartPoint
                    panView.alpha = 1
                })
                Situation.result = throwToThird
                modalAppear()
                
            }else if panView.frame.intersects(baseViewArray[3].frame){
                UIView.animate(withDuration: 0.5, animations: {
                    panView.alpha = 0
                    panView.center = self.panStartPoint
                    self.baseViewArray[3].backgroundColor = .clear
                }, completion:{ _ in
                    panView.center = self.panStartPoint
                    panView.alpha = 1
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
    
    //Ohashi:カウントメソッド
    @objc func strike(sender: UIButton){
        if Situation.strikeCounts == 2{
            //Ohashi:アウトカウントの処理はResultViewControllerで
            Situation.result = .missedStruckOut
            modalAppear()
        }else{
            Situation.strikeCounts += 1
        }
        setCount()
    }
    @objc func takeALook(sender: UIButton){
        if Situation.ballCounts == 3{
            Situation.result = .fourBall
            modalAppear()
        }else{
            Situation.ballCounts += 1
        }
        setCount()
    }
    @objc func swing(sender: UIButton){
        if Situation.strikeCounts == 2{
            //Ohashi:アウトカウントの処理はResultViewControllerで
            Situation.result = .struckOutSwinging
            modalAppear()
        }else{
            Situation.strikeCounts += 1
        }
        setCount()
    }
    @objc func faul(sender: UIButton){
        if Situation.strikeCounts == 2{
            
        }else{
            Situation.strikeCounts += 1
        }
        setCount()
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
        self.dismiss(animated: true, completion: nil)
    }
    
    //Ohashi:結果モーダル表示用メソッド
    func modalAppear(){
        let resultViewController = ResultViewController()
        resultViewController.modalPresentationStyle = .custom
        resultViewController.transitioningDelegate = self
        self.present(resultViewController, animated: true, completion: nil)
    }
    
    
}

extension GameViewController{
    //Ohashi:羅列系はこっちに
    
    func setupView(){
        self.view.addSubview(backgroundImageView)
        self.homeButton.addTarget(self, action: #selector(homeButton(sender:)), for: .touchUpInside)
        self.view.addSubview(homeButton)
        //Ohashi:カウントビューの追加とサイズ
        self.view.addSubview(countImageView)
        self.view.addConstraints([NSLayoutConstraint(item: countImageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.28, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: countImageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.13, constant: 0)])
        //Ohashi:カウントボタン追加, メソッド付与と制約
        self.view.addSubview(strikeButton)
        strikeButton.addTarget(self, action: #selector(self.strike(sender:)), for: .touchUpInside)
        self.view.addSubview(takeALookButton)
        takeALookButton.addTarget(self, action: #selector(self.takeALook(sender:)), for: .touchUpInside)
        self.view.addSubview(swingButton)
        swingButton.addTarget(self, action: #selector(self.swing(sender:)), for: .touchUpInside)
        self.view.addSubview(faulButton)
        faulButton.addTarget(self, action: #selector(self.faul(sender:)), for: .touchUpInside)
        self.view.addConstraints([NSLayoutConstraint(item: strikeButton, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.08, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: takeALookButton, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.08, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: swingButton, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.07, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: faulButton, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.07, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: strikeButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.11, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: takeALookButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.11, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: swingButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.16, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: faulButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.14, constant: 0)])
        
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
        //Ohashi:カウントビュー
        
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
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[home]", options: .alignAllTop, metrics: nil, views: ["home": homeButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[count]-50-[home]-10-|", options: .alignAllLeft, metrics: nil, views: ["home": homeButton, "count": countImageView]))
        //Ohashi:カウントボタン
        self.view.addConstraints([NSLayoutConstraint(item: strikeButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 140)])
        self.view.addConstraints([NSLayoutConstraint(item: strikeButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 126)])
        self.view.addConstraints([NSLayoutConstraint(item: takeALookButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 140)])
        self.view.addConstraints([NSLayoutConstraint(item: takeALookButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 175)])
        self.view.addConstraints([NSLayoutConstraint(item: swingButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 155)])
        self.view.addConstraints([NSLayoutConstraint(item: swingButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 223)])
        self.view.addConstraints([NSLayoutConstraint(item: faulButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 140)])
        self.view.addConstraints([NSLayoutConstraint(item: faulButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 270)])
        //         self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[strike]-10-[ball]-10-[swing]-10-[faul]-10-|", options: .alignAllLeft, metrics: nil, views: ["strike": strikeButton, "ball": takeALookButton, "swing": swingButton, "faul": faulButton]))
        
    }
    
    func setCount(){
        //Ohashi:ストライクとボールの書き順間違えた
        if Situation.strikeCounts == 0 && Situation.ballCounts == 0 && Situation.outCounts == 0{
            countImageView.image = UIImage(named: "count0-0-0")
        }else if Situation.strikeCounts == 1 && Situation.ballCounts == 0 && Situation.outCounts == 0{
            countImageView.image = UIImage(named: "count0-1-0")
        }else if Situation.strikeCounts == 2 && Situation.ballCounts == 0 && Situation.outCounts == 0{
            countImageView.image = UIImage(named: "count0-2-0")
        }else if Situation.strikeCounts == 0 && Situation.ballCounts == 1 && Situation.outCounts == 0{
            countImageView.image = UIImage(named: "count1-0-0")
        }else if Situation.strikeCounts == 1 && Situation.ballCounts == 1 && Situation.outCounts == 0{
            countImageView.image = UIImage(named: "count1-1-0")
        }else if Situation.strikeCounts == 2 && Situation.ballCounts == 1 && Situation.outCounts == 0{
            countImageView.image = UIImage(named: "count1-2-0")
        }else if Situation.strikeCounts == 0 && Situation.ballCounts == 2 && Situation.outCounts == 0{
            countImageView.image = UIImage(named: "count2-0-0")
        }else if Situation.strikeCounts == 1 && Situation.ballCounts == 2 && Situation.outCounts == 0{
            countImageView.image = UIImage(named: "count2-1-0")
        }else if Situation.strikeCounts == 2 && Situation.ballCounts == 2 && Situation.outCounts == 0{
            countImageView.image = UIImage(named: "count2-2-0")
        }else if Situation.strikeCounts == 0 && Situation.ballCounts == 3 && Situation.outCounts == 0{
            countImageView.image = UIImage(named: "count3-0-0")
        }else if Situation.strikeCounts == 1 && Situation.ballCounts == 3 && Situation.outCounts == 0{
            countImageView.image = UIImage(named: "count3-1-0")
        }else if Situation.strikeCounts == 2 && Situation.ballCounts == 3 && Situation.outCounts == 0{
            countImageView.image = UIImage(named: "count3-2-0")
        }else if Situation.strikeCounts == 0 && Situation.ballCounts == 0 && Situation.outCounts == 1{
            countImageView.image = UIImage(named: "count0-0-1")
        }else if Situation.strikeCounts == 1 && Situation.ballCounts == 0 && Situation.outCounts == 1{
            countImageView.image = UIImage(named: "count0-1-1")
        }else if Situation.strikeCounts == 2 && Situation.ballCounts == 0 && Situation.outCounts == 1{
            countImageView.image = UIImage(named: "count0-2-1")
        }else if Situation.strikeCounts == 0 && Situation.ballCounts == 1 && Situation.outCounts == 1{
            countImageView.image = UIImage(named: "count1-0-1")
        }else if Situation.strikeCounts == 1 && Situation.ballCounts == 1 && Situation.outCounts == 1{
            countImageView.image = UIImage(named: "count1-1-1")
        }else if Situation.strikeCounts == 2 && Situation.ballCounts == 1 && Situation.outCounts == 1{
            countImageView.image = UIImage(named: "count1-2-1")
        }else if Situation.strikeCounts == 0 && Situation.ballCounts == 2 && Situation.outCounts == 1{
            countImageView.image = UIImage(named: "count2-0-1")
        }else if Situation.strikeCounts == 1 && Situation.ballCounts == 2 && Situation.outCounts == 1{
            countImageView.image = UIImage(named: "count2-1-1")
        }else if Situation.strikeCounts == 2 && Situation.ballCounts == 2 && Situation.outCounts == 1{
            countImageView.image = UIImage(named: "count2-2-1")
        }else if Situation.strikeCounts == 0 && Situation.ballCounts == 3 && Situation.outCounts == 1{
            countImageView.image = UIImage(named: "count3-0-1")
        }else if Situation.strikeCounts == 1 && Situation.ballCounts == 3 && Situation.outCounts == 1{
            countImageView.image = UIImage(named: "count3-1-1")
        }else if Situation.strikeCounts == 2 && Situation.ballCounts == 3 && Situation.outCounts == 1{
            countImageView.image = UIImage(named: "count3-2-1")
        }else if Situation.strikeCounts == 0 && Situation.ballCounts == 0 && Situation.outCounts == 2{
            countImageView.image = UIImage(named: "count0-0-2")
        }else if Situation.strikeCounts == 1 && Situation.ballCounts == 0 && Situation.outCounts == 2{
            countImageView.image = UIImage(named: "count0-1-2")
        }else if Situation.strikeCounts == 2 && Situation.ballCounts == 0 && Situation.outCounts == 2{
            countImageView.image = UIImage(named: "count0-2-2")
        }else if Situation.strikeCounts == 0 && Situation.ballCounts == 1 && Situation.outCounts == 2{
            countImageView.image = UIImage(named: "count1-0-2")
        }else if Situation.strikeCounts == 1 && Situation.ballCounts == 1 && Situation.outCounts == 2{
            countImageView.image = UIImage(named: "count1-1-2")
        }else if Situation.strikeCounts == 2 && Situation.ballCounts == 1 && Situation.outCounts == 2{
            countImageView.image = UIImage(named: "count1-2-2")
        }else if Situation.strikeCounts == 0 && Situation.ballCounts == 2 && Situation.outCounts == 2{
            countImageView.image = UIImage(named: "count2-0-2")
        }else if Situation.strikeCounts == 1 && Situation.ballCounts == 2 && Situation.outCounts == 2{
            countImageView.image = UIImage(named: "count2-1-2")
        }else if Situation.strikeCounts == 2 && Situation.ballCounts == 2 && Situation.outCounts == 2{
            countImageView.image = UIImage(named: "count2-2-2")
        }else if Situation.strikeCounts == 0 && Situation.ballCounts == 3 && Situation.outCounts == 2{
            countImageView.image = UIImage(named: "count3-0-2")
        }else if Situation.strikeCounts == 1 && Situation.ballCounts == 3 && Situation.outCounts == 2{
            countImageView.image = UIImage(named: "count3-1-2")
        }else if Situation.strikeCounts == 2 && Situation.ballCounts == 3 && Situation.outCounts == 2{
            countImageView.image = UIImage(named: "count3-2-2")
        }
    }
    
}

