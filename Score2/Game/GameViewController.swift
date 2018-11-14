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
        imageView.image = UIImage(named: "count0-0-0")
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
    
    let ballOneImageView = UIImageView()
    let ballTwoImageView = UIImageView()
    let ballThreeImageView = UIImageView()
    let strikeOneImageView = UIImageView()
    let strikeTwoImageView = UIImageView()
    let outOneImageView = UIImageView()
    let outTwoImageView = UIImageView()
    
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

    var countViewArray: [UIImageView] = []
    var baseViewArray: [UIView] = []
    var playerButtonArray: [UIButton] = []
    var playerOriginArray: [CGPoint] = []
    var hitButtonArray: [UIButton] = []
    
    
    
    //Ohashi:ドラッグ時初期位置取得用変数
    var panStartPoint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Ohashi:配列に格納
        countViewArray = [ballOneImageView, ballTwoImageView, ballThreeImageView, strikeOneImageView, strikeTwoImageView, outOneImageView, outTwoImageView]
        baseViewArray = [firstBaseView, secondBaseView, thirdBaseView, homeBaseView]
        playerButtonArray = [pitcherPlayerButton, catcherPlayerButton, firstPlayerButton, secondPlayerButton, thirdPlayerButton, shortPlayerButton, leftPlayerButton, centerPlayerButton, rightPlayerButton]
        hitButtonArray = [pitcherOrCatcherHitButton, firstHitButton, secondHitButton, thirdHitButton, shortHitButton, leftHitButton, centerHitButton, rightHitButton, leftIntermediateHitButton, rightIntermediateHitButton, leftOverHitButton, centerOverHitButton, rightOverHitButton]
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Ohashi:セットアップビューはエクステンションに
        setupView()
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
        handlePan(sender: sender, throwToFirst: .pitcherGoroThrowToFirst, throwToSecond: .pitcherGorothrowToSecond, throwToThird: .pitcherGoroThrowToThird, throwToHome: .pitcherGoroThrowToHome)
    }
    @objc func handleCatcherPan(sender: UIPanGestureRecognizer){
        handlePan(sender: sender, throwToFirst: .catcherGoroThrowToFirst, throwToSecond: .catcherGoroThrowToSecond, throwToThird: .catcherGoroThrowToThird, throwToHome: .catcherGoroThrowToHome)
    }
    @objc func handleFirstPan(sender: UIPanGestureRecognizer){
        handlePan(sender: sender, throwToFirst: .firstGoroThrowToFirst , throwToSecond: .firstGoroThrowToSecond, throwToThird: .firstGoroThrowToThird, throwToHome: .firstGoroThrowToHome)
    }
    @objc func handleSecondPan(sender: UIPanGestureRecognizer){
        handlePan(sender: sender, throwToFirst: .secondGoroThrowToFirst, throwToSecond: .secondGoroThrowToSecond, throwToThird: .secondGoroThrowToThird, throwToHome: .secondGoroThrowToHome)
    }
    @objc func handleThirdPan(sender: UIPanGestureRecognizer){
        handlePan(sender: sender, throwToFirst: .thirdGoroThrowToFirst, throwToSecond: .thirdGoroThrowToSecond, throwToThird: .thirdGoroThrowToThird, throwToHome: .thirdGoroThrowToHome)
    }
    @objc func handleShortPan(sender: UIPanGestureRecognizer){
        handlePan(sender: sender, throwToFirst: .shortGoroThrowToFirst, throwToSecond: .shortGoroThrowToSecond, throwToThird: .shortGoroThrowToThird, throwToHome: .shortGoroThrowToHome)
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
                if Situation.firstRunner != nil{
                    baseViewArray[1].backgroundColor = .red
                }
            }else if panView.frame.intersects(baseViewArray[2].frame){
                if Situation.secondRunner != nil{
                    baseViewArray[2].backgroundColor = .red
                }
            }else if panView.frame.intersects(baseViewArray[3].frame){
                if Situation.thirdRunner != nil{
                    baseViewArray[3].backgroundColor = .red
                }
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
                if Situation.firstRunner != nil{
                    UIView.animate(withDuration: 0.5, animations: {
                        panView.alpha = 0
                        self.baseViewArray[1].backgroundColor = .clear
                    }, completion:{ _ in
                        panView.center = self.panStartPoint
                        panView.alpha = 1
                    })
                    Situation.result = throwToSecond
                    modalAppear()
                }else{
                    UIView.animate(withDuration: 0.5, animations: {
                        panView.center = self.panStartPoint
                    })
                }
            }else if panView.frame.intersects(baseViewArray[2].frame){
                if Situation.secondRunner != nil{
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
                }else {
                    UIView.animate(withDuration: 0.5, animations: {
                        panView.center = self.panStartPoint
                    })
                }
                
            }else if panView.frame.intersects(baseViewArray[3].frame){
                if Situation.thirdRunner != nil{
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
        if Situation.strikeCounts == 0{
            Situation.strikeCounts += 1
            UIView.animate(withDuration: 0.3, animations: {
                self.strikeOneImageView.alpha = 1
            })
        }else if Situation.strikeCounts == 1{
            Situation.strikeCounts += 1
            UIView.animate(withDuration: 0.3, animations: {
                self.strikeTwoImageView.alpha = 1
            })
        }else if Situation.strikeCounts == 2{
            Situation.result = .missedStruckOut
            modalAppear()
        }
    }
    @objc func takeALook(sender: UIButton){
        if Situation.ballCounts == 0{
            Situation.ballCounts += 1
            UIView.animate(withDuration: 0.3, animations: {
                self.ballOneImageView.alpha = 1
                })
        }else if Situation.ballCounts == 1{
            Situation.ballCounts += 1
            UIView.animate(withDuration: 0.3, animations: {
                self.ballTwoImageView.alpha = 1
            })
        }else if Situation.ballCounts == 2{
            Situation.ballCounts += 1
            UIView.animate(withDuration: 0.3, animations: {
                self.ballThreeImageView.alpha = 1
            })
        }else if Situation.ballCounts == 3{
            Situation.result = .fourBall
            modalAppear()
        }
    }
    @objc func swing(sender: UIButton){
        if Situation.strikeCounts == 0{
            Situation.strikeCounts += 1
            UIView.animate(withDuration: 0.3, animations: {
                self.strikeOneImageView.alpha = 1
            })
        }else if Situation.strikeCounts == 1{
            Situation.strikeCounts += 1
            UIView.animate(withDuration: 0.3, animations: {
                self.strikeTwoImageView.alpha = 1
            })
        }else if Situation.strikeCounts == 2{
            Situation.result = .struckOutSwinging
            modalAppear()
        }
    }
    @objc func faul(sender: UIButton){
        if Situation.strikeCounts == 0{
            Situation.strikeCounts += 1
            UIView.animate(withDuration: 0.3, animations: {
                self.strikeOneImageView.alpha = 1
            })
        }else if Situation.strikeCounts == 1{
            Situation.strikeCounts += 1
            UIView.animate(withDuration: 0.3, animations: {
                self.strikeTwoImageView.alpha = 1
            })
        }else if Situation.strikeCounts == 2{
            
        }
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
    
    func setupView(){
        self.view.addSubview(backgroundImageView)
        self.homeButton.addTarget(self, action: #selector(homeButton(sender:)), for: .touchUpInside)
        self.view.addSubview(homeButton)
        //Ohashi:カウントビューの追加とサイズ
        self.view.addSubview(countImageView)
        self.view.addConstraints([NSLayoutConstraint(item: countImageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.225, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: countImageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.13, constant: 0)])
        
        //Ohashi:カウント表示用ボールイメージ追加
        for (index, ball) in countViewArray.enumerated(){
            ball.alpha = 0
            ball.translatesAutoresizingMaskIntoConstraints = false
            if index == 0 || index == 1 || index == 2{
                ball.image = UIImage(named: "greenBall")
            }else if index == 3 || index == 4{
                ball.image = UIImage(named: "yellowBall")
            }else{
                ball.image = UIImage(named: "redBall")
            }
            self.view.addSubview(ball)
            self.view.addConstraints([NSLayoutConstraint(item: ball, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.05, constant: 0)])
            self.view.addConstraints([NSLayoutConstraint(item: ball, attribute: .height, relatedBy: .equal, toItem: ball, attribute: .width, multiplier: 1, constant: 0)])
        }
        
        
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
        self.view.addConstraints([NSLayoutConstraint(item: swingButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.17, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: faulButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.13, constant: 0)])
        
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
            if index <= 4{
                value.setImage(UIImage(named: "whiteHit"), for: .normal)
            }else{
                value.setImage(UIImage(named: "hit"), for: .normal)
            }
            
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
        self.view.addConstraints([NSLayoutConstraint(item: takeALookButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 140)])
        self.view.addConstraints([NSLayoutConstraint(item: takeALookButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 126)])
        self.view.addConstraints([NSLayoutConstraint(item: strikeButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 140)])
        self.view.addConstraints([NSLayoutConstraint(item: strikeButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 175)])
        self.view.addConstraints([NSLayoutConstraint(item: swingButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 152)])
        self.view.addConstraints([NSLayoutConstraint(item: swingButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 223)])
        self.view.addConstraints([NSLayoutConstraint(item: faulButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 143)])
        self.view.addConstraints([NSLayoutConstraint(item: faulButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 270)])
        //Ohashi:カウントイメージ
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[one]-5-[two]-5-[three]", options: .alignAllTop, metrics: nil, views: ["one": ballOneImageView, "two": ballTwoImageView, "three": ballThreeImageView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[one]-5-[two]", options: .alignAllTop, metrics: nil, views: ["one": strikeOneImageView, "two": strikeTwoImageView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[one]-5-[two]", options: .alignAllTop, metrics: nil, views: ["one": outOneImageView, "two": outTwoImageView]))
        self.view.addConstraints([NSLayoutConstraint(item: ballOneImageView, attribute: .top, relatedBy: .equal, toItem: countImageView, attribute: .top, multiplier: 1, constant: 5)])
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[ball]-5-[strike]-5-[out]", options: .alignAllLeft, metrics: nil, views: ["ball": ballOneImageView, "strike": strikeOneImageView, "out": outOneImageView]))
    }
    //Ohashi:結果モーダル表示用メソッド
    func modalAppear(){
        let resultViewController = ResultViewController()
        resultViewController.modalPresentationStyle = .custom
        resultViewController.transitioningDelegate = self
        self.present(resultViewController, animated: true, completion: nil)
    }
    
}


