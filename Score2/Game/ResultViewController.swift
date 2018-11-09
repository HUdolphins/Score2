//
//  ResultViewController.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/10/31.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit
import PageMenu
import FirebaseDatabase

class ResultViewController: UIViewController {
    
    var pageMenu: CAPSPageMenu?
    var resultChildViewControllers: [UIViewController] = []
    var noOutNoRunner = Situation.outCounts == 0 && Situation.firstRunner == nil && Situation.secondRunner == nil && Situation.thirdRunner == nil
    var oneOutNoRunner = Situation.outCounts == 1 && Situation.firstRunner == nil && Situation.secondRunner == nil && Situation.thirdRunner == nil
    var twoOutNoRunner = Situation.outCounts == 2 && Situation.firstRunner == nil && Situation.secondRunner == nil && Situation.thirdRunner == nil
    var noOutRunnerOnFirst = Situation.outCounts == 0 && Situation.firstRunner != nil && Situation.secondRunner == nil && Situation.thirdRunner == nil
    var oneOutRunnerOnFirst = Situation.outCounts == 1 && Situation.firstRunner != nil && Situation.secondRunner == nil && Situation.thirdRunner == nil
    var twoOutRunnerOnFirst = Situation.outCounts == 2 && Situation.firstRunner != nil && Situation.secondRunner == nil && Situation.thirdRunner == nil
    var noOutRunnerOnSecond = Situation.outCounts == 0 && Situation.firstRunner == nil && Situation.secondRunner != nil && Situation.thirdRunner == nil
    var oneOutRunnerOnSecond = Situation.outCounts == 1 && Situation.firstRunner == nil && Situation.secondRunner != nil && Situation.thirdRunner == nil
    var twoOutRunnerOnSecond = Situation.outCounts == 2 && Situation.firstRunner == nil && Situation.secondRunner != nil && Situation.thirdRunner == nil
    var noOutRunnerOnThird = Situation.outCounts == 0 && Situation.firstRunner == nil && Situation.secondRunner == nil && Situation.thirdRunner != nil
    var oneOutRunnerOnThird = Situation.outCounts == 1 && Situation.firstRunner == nil && Situation.secondRunner == nil && Situation.thirdRunner != nil
    var twoOutRunnerOnThird = Situation.outCounts == 2 && Situation.firstRunner == nil && Situation.secondRunner == nil && Situation.thirdRunner != nil
    var noOutRunnersOnFirstAndSecond = Situation.outCounts == 0  && Situation.firstRunner != nil && Situation.secondRunner != nil && Situation.thirdRunner == nil
    var oneOutRunnersOnFirstAndSecond = Situation.outCounts == 1  && Situation.firstRunner != nil && Situation.secondRunner != nil && Situation.thirdRunner == nil
    var twoOutRunnersOnFirstAndSecond = Situation.outCounts == 2  && Situation.firstRunner != nil && Situation.secondRunner != nil && Situation.thirdRunner == nil
    var noOutRunnersOnFirstAndThird = Situation.outCounts == 0  && Situation.firstRunner != nil && Situation.secondRunner == nil && Situation.thirdRunner != nil
    var oneOutRunnersOnFirstAndThird = Situation.outCounts == 1  && Situation.firstRunner != nil && Situation.secondRunner == nil && Situation.thirdRunner != nil
    var twoOutRunnersOnFirstAndThird = Situation.outCounts == 2  && Situation.firstRunner != nil && Situation.secondRunner == nil && Situation.thirdRunner != nil
    var noOutRunnersOnSecondAndThird = Situation.outCounts == 0  && Situation.firstRunner == nil && Situation.secondRunner != nil && Situation.thirdRunner != nil
    var oneOutRunnersOnSecondAndThird = Situation.outCounts == 1  && Situation.firstRunner == nil && Situation.secondRunner != nil && Situation.thirdRunner != nil
    var twoOutRunnersOnSecondAndThird = Situation.outCounts == 2  && Situation.firstRunner == nil && Situation.secondRunner != nil && Situation.thirdRunner != nil
    var noOutFullBase = Situation.outCounts == 0  && Situation.firstRunner != nil && Situation.secondRunner != nil && Situation.thirdRunner != nil
    var oneOutFullBase = Situation.outCounts == 1  && Situation.firstRunner != nil && Situation.secondRunner != nil && Situation.thirdRunner != nil
    var twoOutFullBase = Situation.outCounts == 2  && Situation.firstRunner != nil && Situation.secondRunner != nil && Situation.thirdRunner != nil
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupChildren()
        setupPageMenu()
    }
    
    func setupPageMenu(){
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.0),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.0),
            .scrollMenuBackgroundColor(#colorLiteral(red: 0, green: 0.3764705882, blue: 0.01568627451, alpha: 1)),
            .selectionIndicatorColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        ]
        
        pageMenu =  CAPSPageMenu(viewControllers: resultChildViewControllers, frame: view.bounds, pageMenuOptions: parameters)
        view.addSubview(pageMenu!.view)
    }
    
    func setupChildren(){
        let resultChildViewController1 = ResultChildViewController1()
        let resultChildViewController2 = ResultChildViewController2()
        let resultChildViewController3 = ResultChildViewController3()
        let resultChildViewController4 = ResultChildViewController4()
        
        resultChildViewControllers = [resultChildViewController1, resultChildViewController2, resultChildViewController3, resultChildViewController4]
        //Ohashi:タブの表示名
        resultChildViewController1.title = childOptionOne().resultTitle
        resultChildViewController2.title = childOptionOne().resultTitle
        resultChildViewController3.title = childOptionOne().resultTitle
        resultChildViewController4.title = childOptionOne().resultTitle
        
        //Ohashi:画像
        resultChildViewController1.resultImageView.image = childOptionOne().resultImage
        resultChildViewController2.resultImageView.image = childOptionOne().resultImage
        resultChildViewController3.resultImageView.image = childOptionOne().resultImage
        resultChildViewController4.resultImageView.image = childOptionOne().resultImage
        
        //Ohashi:結果テキスト
        resultChildViewController1.resultTextView.text = childOptionOne().resultString
        resultChildViewController2.resultTextView.text = childOptionOne().resultString
        resultChildViewController3.resultTextView.text = childOptionOne().resultString
        resultChildViewController4.resultTextView.text = childOptionOne().resultString
        
        resultChildViewController1.sendButton.addTarget(self, action: #selector(sendResultOne), for: .touchUpInside)
        resultChildViewController2.sendButton.addTarget(self, action: #selector(sendResultOne), for: .touchUpInside)
        resultChildViewController3.sendButton.addTarget(self, action: #selector(sendResultOne), for: .touchUpInside)
        resultChildViewController4.sendButton.addTarget(self, action: #selector(sendResultOne), for: .touchUpInside)
        
        resultChildViewController1.cancelButton.addTarget(self, action: #selector(cancelTapped(sender:)), for: .touchUpInside)
        resultChildViewController2.cancelButton.addTarget(self, action: #selector(cancelTapped(sender:)), for: .touchUpInside)
        resultChildViewController3.cancelButton.addTarget(self, action: #selector(cancelTapped(sender:)), for: .touchUpInside)
        resultChildViewController4.cancelButton.addTarget(self, action: #selector(cancelTapped(sender:)), for: .touchUpInside)
        
      
    }
    
    @objc func sendResultOne(sender: UIButton){
        print("DEBUG_PRiNT:sendResult")
        let playerRef = Database.database().reference().child(Const.playerPath)
        let resultRef = Database.database().reference().child(Const.resultPath)
        
        if Situation.topOrBottom == "Top"{
            //Ohashi:firresult型のchildbyautoid
            let key = resultRef.childByAutoId().key
            let batter = Situation.topPlayerArray[Situation.topBattingOrder]
            
            //Ohashi:打者の結果辞書を更新，追加できるようvarで宣言,初打席ならデータ作成，データあればアンラップ
            //Ohashi:プレイヤーノード
            if var resultDic = batter.battingResultsDic{
                resultDic[key] = true
                playerRef.child(batter.id!).updateChildValues(resultDic)
            }else{
                let resultDic = [key: true]
                playerRef.child(batter.id!).child("results").setValue(resultDic)
            }
            //Ohashi:対戦投手，何球目か，捕殺者
            //Ohashi:結果ノード
            let resultDic = ["results": childOptionOne().resultTitle, "player": batter.id, "game": Situation.gameId]
            resultRef.child(key).setValue(resultDic)
        }
        
        //Ohashi:仮の結果処理
        switch Situation.result! {
        case .pitcherFly, .catcherFly, .firstFly, .secondFly, .thirdFly, .shortFly, .leftFly, .centerFly, .rightFly, .pitcherGoroThrowToFirst, .catcherGoroThrowToFirst, .firstGoroThrowToFirst, .secondGoroThrowToFirst, .thirdGoroThrowToFirst, .shortGoroThrowToFirst, .struckOutSwinging, .missedStruckOut:
            batterOut()
        default:
            batterOnBaseSingle()
        }
        let gameViewController = GameViewController()
        gameViewController.setCount()
        gameViewController.setRunner()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelTapped(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    func childOptionOne() -> (resultTitle: String,resultString: String, resultImage: UIImage){
        //タプルで返す値を複数に
        
        switch Situation.result! {
        case .pitcherFly:
            if oneOutNoRunner {
                return ("投飛", "ピッチャーフライ\n２死走者なし", UIImage(named: "2-0")!)
            }else if twoOutNoRunner{
                return ("投飛", "ピッチャーフライ\n３アウトチェンジ", UIImage(named: "3-0")!)
            }
            else if noOutNoRunner{
                return ("投飛", "ピッチャーフライ\n1死走者なし", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("投飛", "ピッチャーフライ\n1死1塁", UIImage(named: "1-1")!)
            }
            else if oneOutRunnerOnFirst{
                return ("投飛", "ピッチャーフライ\n2死走者1塁", UIImage(named: "2-1")!)
            }
            else if twoOutRunnerOnFirst{
                return ("投飛", "ピッチャーフライ\n3アウトチェンジ", UIImage(named: "3-1")!)
            }
            else if noOutRunnerOnSecond{
                return ("投飛", "ピッチャーフライ\n1死2塁", UIImage(named: "1-2")!)
            }
            else if oneOutRunnerOnSecond{
                return ("投飛", "ピッチャーフライ\n2死2塁", UIImage(named: "2-2")!)
            }
            else if twoOutRunnerOnSecond{
                return ("投飛", "ピッチャーフライ\n3アウトチェンジ", UIImage(named: "3-2")!)
            }
            else if noOutRunnerOnThird{
                return ("投飛", "ピッチャーフライ\n1死3塁", UIImage(named: "1-3")!)
            }
            else if oneOutRunnerOnThird{
                return ("投飛", "ピッチャーフライ\n2死3塁", UIImage(named: "2-3")!)
            }
            else if twoOutRunnerOnThird{
                return ("投飛", "ピッチャーフライ\n3アウトチェンジ", UIImage(named: "3-3")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("投飛", "ピッチャーフライ\n1死走者1,2塁", UIImage(named: "1-1,2")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("投飛", "ピッチャーフライ\n2死1,2塁", UIImage(named: "2-1,2")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("投飛", "ピッチャーフライ\n3アウトチェンジ", UIImage(named: "3-1,2")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("投飛", "ピッチャーフライ\n1死1,3塁", UIImage(named: "1-1,3")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("投飛", "ピッチャーフライ\n2死1,３塁", UIImage(named: "2-1,3")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("投飛", "ピッチャーフライ\n3アウトチェンジ", UIImage(named: "3-1,3")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("投飛", "ピッチャーフライ\n1死2,3塁", UIImage(named: "1-2,3")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("投飛", "ピッチャーフライ\n2死2,3塁", UIImage(named: "2-2,3")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("投飛", "ピッチャーフライ\n3アウトチェンジ", UIImage(named: "3-2,3")!)
            }
            else if noOutFullBase{
                return ("投飛", "ピッチャーフライ\n1死満塁", UIImage(named: "1-1,2,3")!)
            }
            else if oneOutFullBase{
                return ("投飛", "ピッチャーフライ\n2死満塁", UIImage(named: "2-1,2,3")!)
            }
            else if twoOutFullBase{
                return ("投飛", "ピッチャーフライ\n3アウトチェンジ", UIImage(named: "3-1,2,3")!)
            }
        //画像名前仮置き
        case .catcherFly:
            if noOutNoRunner {
                return ("捕邪飛", "キャッチャーファウルフライ\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("捕邪飛", "キャッチャーファウルフライ\n2死走者なし", UIImage(named: "1-0")! )
            }
            else if twoOutNoRunner{
                return ("捕邪飛", "キャッチャーファウルフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("捕邪飛", "キャッチャーファウルフライ\n1死1塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("捕邪飛", "キャッチャーファウルフライ\n2死1塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnFirst{
                return ("捕邪飛", "キャッチャーファウルフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("捕邪飛", "キャッチャーファウルフライ\n1死2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnSecond{
                return ("捕邪飛", "キャッチャーファウルフライ\n2死2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnSecond{
                return ("捕邪飛", "キャッチャーファウルフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnThird{
                return ("捕邪飛", "キャッチャーファウルフライ\n1死3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnThird{
                return ("捕邪飛", "キャッチャーファウルフライ\n2死3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnThird{
                return ("捕邪飛", "キャッチャーファウルフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("捕邪飛", "キャッチャーファウルフライ\n1死1,2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("捕邪飛", "キャッチャーファウルフライ\n2死1,2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("捕邪飛", "キャッチャーファウルフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("捕邪飛", "キャッチャーファウルフライ\n1死1,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("捕邪飛", "キャッチャーファウルフライ\n2死1,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("捕邪飛", "キャッチャーファウルフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutFullBase{
                return ("捕邪飛", "キャッチャーファウルフライ\n1死満塁", UIImage(named: "1-0")! )
            }
            else if oneOutFullBase{
                return ("捕邪飛", "キャッチャーファウルフライ\n2死満塁", UIImage(named: "1-0")! )
            }
            else if twoOutFullBase{
                return ("捕邪飛", "キャッチャーファウルフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
        case .firstFly:
            if noOutNoRunner {
                return ("一飛", "ファーストフライ\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("一飛", "ファーストフライ\n2死走者なし", UIImage(named: "1-0")! )
            }
            else if twoOutNoRunner{
                return ("一飛", "ファーストフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("一飛", "ファーストフライ\n1死1塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("一飛", "ファーストフライ\n2死1塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnFirst{
                return ("一飛", "ファーストフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("一飛", "ファーストフライ\n1死2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnSecond{
                return ("一飛", "ファーストフライ\n2死2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnSecond{
                return ("一飛", "ファーストフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnThird{
                return ("一飛", "ファーストフライ\n1死3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnThird{
                return ("一飛", "ファーストフライ\n2死3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnThird{
                return ("一飛", "ファーストフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("一飛", "ファーストフライ\n1死1,2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("一飛", "ファーストフライ\n2死1,2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("一飛", "ファーストフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("一飛", "ファーストフライ\n1死1,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("一飛", "ファーストフライ\n2死1,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("一飛", "ファーストフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("一飛", "ファーストフライ\n1死2,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("一飛", "ファーストフライ\n2死2,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("一飛", "ファーストフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutFullBase{
                return ("一飛", "ファーストフライ\n1死満塁", UIImage(named: "1-0")! )
            }
            else if oneOutFullBase{
                return ("一飛", "ファーストフライ\n2死満塁", UIImage(named: "1-0")! )
            }
            else if twoOutFullBase{
                return ("一飛", "ファーストフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
        case .secondFly:
            if noOutNoRunner {
                return ("二飛", "セカンドフライ\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("二飛", "セカンドフライ\n2死走者なし", UIImage(named: "1-0")! )
            }
            else if twoOutNoRunner{
                return ("二飛", "セカンドフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("二飛", "セカンドフライ\n1死1塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("二飛", "セカンドフライ\n2死1塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnFirst{
                return ("二飛", "セカンドフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("二飛", "セカンドフライ\n1死2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnSecond{
                return ("二飛", "セカンドフライ\n2死2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnSecond{
                return ("二飛", "セカンドフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnThird{
                return ("二飛", "セカンドフライ\n1死3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnThird{
                return ("二飛", "セカンドフライ\n2死3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnThird{
                return ("二飛", "セカンドフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("二飛", "セカンドフライ\n1死1,2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("二飛", "セカンドフライ\n2死1,2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("二飛", "セカンドフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("二飛", "セカンドフライ\n1死1,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("二飛", "セカンドフライ\n2死1,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("二飛", "セカンドフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("二飛", "セカンドフライ\n1死2,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("二飛", "セカンドフライ\n2死2,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("二飛", "セカンドフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutFullBase{
                return ("二飛", "セカンドフライ\n1死満塁", UIImage(named: "1-0")! )
            }
            else if oneOutFullBase{
                return ("二飛", "セカンドフライ\n2死満塁", UIImage(named: "1-0")! )
            }
            else if twoOutFullBase{
                return ("二飛", "セカンドフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
        case .thirdFly:
            
            if noOutNoRunner {
                return ("三飛", "サードフライ\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("三飛", "サードフライ\n2死走者なし", UIImage(named: "1-0")! )
            }
            else if twoOutNoRunner{
                return ("三飛", "サードフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("三飛", "サードフライ\n1死1,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("三飛", "サードフライ\n2死1,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnFirst{
                return ("三飛", "サードフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("三飛", "サードフライ\n1死2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnSecond{
                return ("三飛", "サードフライ\n2死2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnSecond{
                return ("三飛", "サードフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnThird{
                return ("三飛", "サードフライ\n1死3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnThird{
                return ("三飛", "サードフライ\n2死3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnThird{
                return ("三飛", "サードフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("三飛", "サードフライ\n1死1,2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("三飛", "サードフライ\n2死1,2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("三飛", "サードフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("三飛", "サードフライ\n1死1,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("三飛", "サードフライ\n2死1,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("三飛", "サードフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("三飛", "サードフライ\n1死2,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("三飛", "サードフライ\n2死2,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("三飛", "サードフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutFullBase{
                return ("三飛", "サードフライ\n1死満塁", UIImage(named: "1-0")! )
            }
            else if oneOutFullBase{
                return ("三飛", "サードフライ\n2死満塁", UIImage(named: "1-0")! )
            }
            else if twoOutFullBase{
                return ("三飛", "サードフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
        case .shortFly:
            if noOutNoRunner {
                return ("遊飛", "ショートフライ\n一死なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("遊飛", "ショートフライ\n2死走者なし", UIImage(named: "1-0")! )
            }
            else if twoOutNoRunner{
                return ("遊飛", "ショートフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("遊飛", "ショートフライ\n1死1塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("遊飛", "ショートフライ\n2死1塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnFirst{
                return ("遊飛", "ショートフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("遊飛", "ショートフライ\n1死2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnSecond{
                return ("遊飛", "ショートフライ\n2死2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnSecond{
                return ("遊飛", "ショートフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnThird{
                return ("遊飛", "ショートフライ\n1死3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnThird{
                return ("遊飛", "ショートフライ\n2死3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnThird{
                return ("遊飛", "ショートフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("遊飛", "ショートフライ\n1死1,2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("遊飛", "ショートフライ\n2死1,2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("遊飛", "ショートフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("遊飛", "ショートフライ\n1死1,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("遊飛", "ショートフライ\n2死1,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("遊飛", "ショートフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("遊飛", "ショートフライ\n1死2,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("遊飛", "ショートフライ\n2死2,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("遊飛", "ショートフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutFullBase{
                return ("遊飛", "ショートフライ\n1死満塁", UIImage(named: "1-0")! )
            }
            else if oneOutFullBase{
                return ("遊飛", "ショートフライ\n2死満塁", UIImage(named: "1-0")! )
            }
            else if twoOutFullBase{
                return ("遊飛", "ショートフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
        case .leftFly:
            if noOutNoRunner {
                return ("左飛", "レフトフライ\n1死走者なし", UIImage(named: "1-0")!)
            }else if oneOutNoRunner{
                return ("左飛", "レフトフライ\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("左飛", "レフトフライ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("左飛", "レフトフライ\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return ("左飛", "レフトフライ\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("左飛", "レフトフライ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("左飛", "レフトフライ\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("左飛", "レフトフライ\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("左飛", "レフトフライ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("左犠飛", "タッチアップ\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("左犠飛", "タッチアップ\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("左飛", "レフトフライ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("左飛", "レフトフライ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("左飛", "レフトフライ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("左飛", "レフトフライ\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("左犠飛", "タッチアップ\n1死1塁\n1点", UIImage(named: "1-1,4_1")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("左犠飛", "タッチアップ\n2死1塁\n1点", UIImage(named: "2-1,4_1")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("左飛", "レフトフライ\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("左犠飛", "タッチアップ\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("左犠飛", "タッチアップ\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("左飛", "レフトフライ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("左犠飛", "タッチアップ\n1死1,2塁\n1点", UIImage(named: "1-1,2,4_1")! )
            }
            else if oneOutFullBase{
                return ("左犠飛", "タッチアップ\n2死1,2塁\n1点", UIImage(named: "2-1,2,4_1")! )
            }
            else if twoOutFullBase{
                return ("左飛", "レフトフライ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        case .centerFly:
            if noOutNoRunner {
                return ("中飛", "センターフライ\n一死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("中飛", "センターフライ\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("中飛", "センターフライ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("中飛", "センターフライ\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return("中飛", "センターフライ\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("中飛", "センターフライ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("中飛", "センターフライ\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("中飛", "センターフライ\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("中飛", "センターフライ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("中犠飛", "タッチアップ\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("中犠飛", "タッチアップ\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("中飛", "センターフライ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("中飛", "センターフライ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("中飛", "センターフライ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("中飛", "センターフライ\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("中犠飛", "タッチアップ\n1死1塁\n1点", UIImage(named: "1-1,4_1")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("中犠飛", "タッチアップ\n2死1塁\n1点", UIImage(named: "2-1,4_1")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("中飛", "センターフライ\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("中犠飛", "タッチアップ\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("中犠飛", "タッチアップ\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("中飛", "センターフライ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("中犠飛", "タッチアップ\n1死1,2塁", UIImage(named: "1-1,2,4_1")! )
            }
            else if oneOutFullBase{
                return ("中犠飛", "タッチアップ\n2死1,2塁", UIImage(named: "2-1,2,4_1")! )
            }
            else if twoOutFullBase{
                return ("中飛", "センターフライ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        case .rightFly:
            if noOutNoRunner {
                return ("右飛", "ライトフライ\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("右飛", "ライトフライ\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("右飛", "ライトフライ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("右飛", "ライトフライ\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return ("右飛", "ライトフライ\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("右飛", "ライトフライ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("右飛", "ライトフライ\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("右飛", "ライトフライ\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("右飛", "ライトフライ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("右犠飛", "タッチアップ\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("右犠飛", "タッチアップ\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("右飛", "ライトフライ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("右飛", "ライトフライ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("右飛", "ライトフライ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("右飛", "ライトフライ\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("右飛", "タッチアップ\n1死1塁\n1点", UIImage(named: "1-1,4_1")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("右犠飛", "タッチアップ\n2死1塁\n1点", UIImage(named: "2-1,4_1")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("右飛", "ライトフライ\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                //oohashi:23塁のがいいか？
                return ("右犠飛", "タッチアップ\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("右犠飛", "タッチアップ\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("右飛", "ライトフライ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                //13塁のがいいか
                return ("右犠飛", "タッチアップ\n1死1,2塁\n1点", UIImage(named: "1-1,2,4_1")! )
            }
            else if oneOutFullBase{
                return ("右犠飛", "タッチアップ\n2死1,2塁\n1点", UIImage(named: "2-1,2,4_1")! )
            }
            else if twoOutFullBase{
                return ("右飛", "ライトフライ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        

            
            
        case .pitcherGoroThrowToFirst:
            if noOutNoRunner {
                return ("投ゴロ", "ピッチャーゴロ\n走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("投ゴロ", "ピッチャーゴロ\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("投ゴロ", "ピッチャーゴロ\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnFirst{
                return ("投ゴロ", "ピッチャーゴロ\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnFirst{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("投ゴロ", "ピッチャーゴロ\n1死3塁", UIImage(named: "1-3")! )
            }
            else if oneOutRunnerOnSecond{
                return ("投ゴロ", "ピッチャーゴロ\n2死3塁", UIImage(named: "2-3")! )
            }
            else if twoOutRunnerOnSecond{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("投ゴロ", "ピッチャーゴロ\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("投ゴロ", "ピッチャーゴロ\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("投ゴロ", "ピッチャーゴロ\n1死2,3塁", UIImage(named: "1-2,3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("投ゴロ", "ピッチャーゴロ\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("投ゴロ", "ピッチャーゴロ\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("投ゴロ", "ピッチャーゴロ\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("投ゴロ", "ピッチャーゴロ\n1死3塁\n1点", UIImage(named: "1-3,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("投ゴロ", "ピッチャーゴロ\n2死3塁\n1点", UIImage(named: "2-3,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("投ゴロ", "ピッチャーゴロ\n1死2,3塁\n1点", UIImage(named: "1-2,3,4_1")! )
            }
            else if oneOutFullBase{
                return ("投ゴロ", "ピッチャーゴロ\n2死2,3塁\n1点", UIImage(named: "2-2,3,4_1")! )
            }
            else if twoOutFullBase{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }

        case .pitcherGorothrowToSecond:
            if noOutNoRunner {
                return ("", "\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("", "\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("投併", "1-6-3 ダブルプレー\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("投併", "1-6-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("", "\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("", "\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("", "\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("", "\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("投併", "1-6-3 ダブルプレー\n2死3塁", UIImage(named: "2-3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("投併", "1-6-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("投併", "1-6-3 ダブルプレー\n1死1塁\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("投併", "1-6-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("", "\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("", "\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("投併", "1-6-3 ダブルプレー\n2死3塁", UIImage(named: "2-3,4-1")! )
            }
            else if oneOutFullBase{
                return ("投併", "1-6-3 ダブルプレー\n2死1,2塁\n1点3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if twoOutFullBase{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
        case .pitcherGoroThrowToThird:
            if noOutRunnerOnSecond{
                return ("投ゴロ", "投ゴロタッチアウト\n1死1塁", UIImage(named: "1-1")! )
            }else if oneOutRunnerOnThird{
                return ("投ゴロ", "投ゴロタッチアウト\n2死1塁", UIImage(named: "2-1")! )
            }else if twoOutRunnerOnThird{
                return ("投ゴロ", "投ゴロタッチアウト\n3アウトチェンジ", UIImage(named: "3-0")! )
            }else if noOutRunnersOnFirstAndSecond{
                return ("投ゴロ", "投ゴロ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }else if oneOutRunnersOnFirstAndSecond{
                return ("投ゴロ", "投ゴロ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }else if twoOutRunnersOnFirstAndSecond{
                return ("投ゴロ", "投ゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
        case .pitcherGoroThrowToHome:
            if noOutNoRunner {
                return ("", "\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("", "\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("", "\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return ("", "\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("", "\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("", "\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("投ゴロ", "ピッチャーゴロ\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnThird{
                return ("投ゴロ", "ピッチャーゴロ\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnThird{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("", "\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("", "\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("投ゴロ", "ピッチャーゴロ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("投ゴロ", "ピッチャーゴロ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("投ゴロ", "ピッチャーゴロ\n1死1,3塁", UIImage(named: "1-1,3")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("投ゴロ", "ピッチャーゴロ\n2死1,3塁", UIImage(named: "2-1,3")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutFullBase{
                return ("投併殺", "1-2-3ホームゲッツー\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if oneOutFullBase{
                return ("投併殺", "1-2-3ホームゲッツー\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if twoOutFullBase{
                return ("投ゴロ", "ピッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
            
        case .catcherGoroThrowToFirst:
            if noOutNoRunner {
                return ("捕ゴロ", "キャッチャーゴロ\n走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("捕ゴロ", "キャッチャーゴロ\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("捕ゴロ", "キャッチャーゴロ\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnFirst{
                return ("捕ゴロ", "キャッチャーゴロ\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnFirst{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("捕ゴロ", "キャッチャーゴロ\n1死3塁", UIImage(named: "1-3")! )
            }
            else if oneOutRunnerOnSecond{
                return ("捕ゴロ", "キャッチャーゴロ\n2死3塁", UIImage(named: "2-3")! )
            }
            else if twoOutRunnerOnSecond{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("捕ゴロ", "キャッチャーゴロ\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("捕ゴロ", "キャッチャーゴロ\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("捕ゴロ", "キャッチャーゴロ\n1死2,3塁", UIImage(named: "1-2,3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("捕ゴロ", "キャッチャーゴロ\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("捕ゴロ", "キャッチャーゴロ\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("捕ゴロ", "キャッチャーゴロ\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("捕ゴロ", "キャッチャーゴロ\n1死3塁\n1点", UIImage(named: "1-3,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("捕ゴロ", "キャッチャーゴロ\n2死3塁\n1点", UIImage(named: "2-3,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("捕ゴロ", "キャッチャーゴロ\n1死2,3塁\n1点", UIImage(named: "1-2,3,4_1")! )
            }
            else if oneOutFullBase{
                return ("捕ゴロ", "キャッチャーゴロ\n2死2,3塁\n1点", UIImage(named: "2-2,3,4_1")! )
            }
            else if twoOutFullBase{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        case .catcherGoroThrowToSecond:
            if noOutNoRunner {
                return ("", "\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("", "\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("捕併", "2-6-3 ダブルプレー\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("捕併", "2-6-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("", "\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("", "\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("", "\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("", "\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("捕併", "2-6-3 ダブルプレー\n2死3塁", UIImage(named: "2-3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("捕併", "2-6-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("捕併", "2-6-3 ダブルプレー\n1死1塁\n1点", UIImage(named: "1-4_1")! )
            }
                
            else if oneOutRunnersOnFirstAndThird{
                return ("捕併", "2-6-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("", "\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("", "\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("捕併", "2-6-3 ダブルプレー\n2死3塁", UIImage(named: "2-3,4-1")! )
            }
            else if oneOutFullBase{
                return ("捕併", "2-6-3 ダブルプレー\n2死1,2塁\n1点3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if twoOutFullBase{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
        case .catcherGoroThrowToThird:
            if noOutRunnerOnSecond{
                return ("捕ゴロ", "捕ゴロタッチアウト\n1死1塁", UIImage(named: "1-1")! )
            }else if oneOutRunnerOnThird{
                return ("捕ゴロ", "捕ゴロタッチアウト\n2死1塁", UIImage(named: "2-1")! )
            }else if twoOutRunnerOnThird{
                return ("捕ゴロ", "捕ゴロタッチアウト\n3アウトチェンジ", UIImage(named: "3-0")! )
            }else if noOutRunnersOnFirstAndSecond{
                return ("捕ゴロ", "キャッチャーゴロ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }else if oneOutRunnersOnFirstAndSecond{
                return ("捕ゴロ", "キャッチャーゴロ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }else if twoOutRunnersOnFirstAndSecond{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
        case .catcherGoroThrowToHome:
            if noOutNoRunner {
                return ("", "\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("", "\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("", "\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return ("", "\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("", "\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("", "\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("捕ゴロ", "キャッチャーゴロ\n1死1塁", UIImage(named: "1-1")! )
            }else if oneOutRunnerOnThird{
                return ("捕ゴロ", "キャッチャーゴロ\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnThird{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("", "\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("", "\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("捕ゴロ", "キャッチャーゴロ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("捕ゴロ", "キャッチャーゴロ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("捕ゴロ", "キャッチャーゴロ\n1死1,3塁", UIImage(named: "1-1,3")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("捕ゴロ", "キャッチャーゴロ\n2死1,3塁", UIImage(named: "2-1,3")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutFullBase{
                return ("捕併殺", "2-2-3ホームゲッツー\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if oneOutFullBase{
                return ("捕併殺", "2-2-3ホームゲッツー\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if twoOutFullBase{
                return ("捕ゴロ", "キャッチャーゴロ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        case .firstGoroThrowToFirst:
            if noOutNoRunner {
                return ("一ゴロ", "ファーストゴロ\n走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("一ゴロ", "ファーストゴロ\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("一ゴロ", "ファーストゴロ\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnFirst{
                return ("一ゴロ", "ファーストゴロ\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnFirst{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("一ゴロ", "ファーストゴロ\n1死3塁", UIImage(named: "1-3")! )
            }
            else if oneOutRunnerOnSecond{
                return ("一ゴロ", "ファーストゴロ\n2死3塁", UIImage(named: "2-3")! )
            }
            else if twoOutRunnerOnSecond{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("一ゴロ", "ファーストゴロ\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("一ゴロ", "ファーストゴロ\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("一ゴロ", "ファーストゴロ\n1死2,3塁", UIImage(named: "1-2,3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("一ゴロ", "ファーストゴロ\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("一ゴロ", "ファーストゴロ\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("一ゴロ", "ファーストゴロ\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("一ゴロ", "ファーストゴロ\n1死3塁\n1点", UIImage(named: "1-3,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("一ゴロ", "ファーストゴロ\n2死3塁\n1点", UIImage(named: "2-3,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("一ゴロ", "ファーストゴロ\n1死2,3塁\n1点", UIImage(named: "1-2,3,4_1")! )
            }
            else if oneOutFullBase{
                return ("一ゴロ", "ファーストゴロ\n2死2,3塁\n1点", UIImage(named: "2-2,3,4_1")! )
            }
            else if twoOutFullBase{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        case .firstGoroThrowToSecond:
            if noOutNoRunner {
                return ("", "\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("", "\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("一併", "3-6-1 ダブルプレー\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("一併", "3-6-1 ダブルプレー\n3アウトチェンジ", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("", "\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("", "\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("", "\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("", "\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("一併", "3-6-1 ダブルプレー\n2死3塁", UIImage(named: "2-3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("一併", "3-6-1 ダブルプレー\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("一併", "3-6-1 ダブルプレー\n1死1塁\n1点", UIImage(named: "1-4_1")! )
            }
                
            else if oneOutRunnersOnFirstAndThird{
                return ("一併", "3-6-1 ダブルプレー\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("", "\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("", "\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("一併", "3-6-1 ダブルプレー\n2死3塁", UIImage(named: "2-3,4-1")! )
            }
            else if oneOutFullBase{
                return ("一併", "3-6-1 ダブルプレー\n2死1,2塁\n1点3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if twoOutFullBase{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
        case .firstGoroThrowToThird:
            if noOutRunnerOnSecond{
                return ("一ゴロ", "一ゴロタッチアウト\n1死1塁", UIImage(named: "1-1")! )
            }else if oneOutRunnerOnThird{
                return ("一ゴロ", "一ゴロタッチアウト\n2死1塁", UIImage(named: "2-1")! )
            }else if twoOutRunnerOnThird{
                return ("一ゴロ", "一ゴロタッチアウト\n3アウトチェンジ", UIImage(named: "3-0")! )
            }else if noOutRunnersOnFirstAndSecond{
                return ("一ゴロ", "ファーストゴロ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }else if oneOutRunnersOnFirstAndSecond{
                return ("一ゴロ", "ファーストゴロ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }else if twoOutRunnersOnFirstAndSecond{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
        case .firstGoroThrowToHome:
            if noOutNoRunner {
                return ("", "\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("", "\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("", "\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return ("", "\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("", "\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("", "\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("一ゴロ", "ファーストゴロ\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnThird{
                return ("一ゴロ", "ファーストゴロ\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnThird{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("", "\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("", "\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("一ゴロ", "ファーストゴロ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("一ゴロ", "ファーストゴロ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("一ゴロ", "ファーストゴロ\n1死1,3塁", UIImage(named: "1-1,3")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("一ゴロ", "ファーストゴロ\n2死1,3塁", UIImage(named: "2-1,3")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutFullBase{
                return ("一併殺", "3-2-4ホームゲッツー\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if oneOutFullBase{
                return ("一併殺", "3-2-4ホームゲッツー\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if twoOutFullBase{
                return ("一ゴロ", "ファーストゴロ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
            
        case .secondGoroThrowToFirst:
            if noOutNoRunner {
                return ("二ゴロ", "セカンドゴロ\n走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("二ゴロ", "セカンドゴロ\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("二ゴロ", "セカンドゴロ\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnFirst{
                return ("二ゴロ", "セカンドゴロ\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnFirst{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("二ゴロ", "セカンドゴロ\n1死3塁", UIImage(named: "1-3")! )
            }
            else if oneOutRunnerOnSecond{
                return ("二ゴロ", "セカンドゴロ\n2死3塁", UIImage(named: "2-3")! )
            }
            else if twoOutRunnerOnSecond{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("二ゴロ", "セカンドゴロ\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("二ゴロ", "セカンドゴロ\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("二ゴロ", "セカンドゴロ\n1死2,3塁", UIImage(named: "1-2,3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("二ゴロ", "セカンドゴロ\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("二ゴロ", "セカンドゴロ\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("二ゴロ", "セカンドゴロ\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("二ゴロ", "セカンドゴロ\n1死3塁\n1点", UIImage(named: "1-3,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("二ゴロ", "セカンドゴロ\n2死3塁\n1点", UIImage(named: "2-3,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("二ゴロ", "セカンドゴロ\n1死2,3塁\n1点", UIImage(named: "1-2,3,4_1")! )
            }
            else if oneOutFullBase{
                return ("二ゴロ", "セカンドゴロ\n2死2,3塁\n1点", UIImage(named: "2-2,3,4_1")! )
            }
            else if twoOutFullBase{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        case .secondGoroThrowToSecond:
            if noOutNoRunner {
                return ("", "\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("", "\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("二併", "4-6-3 ダブルプレー\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("二併", "4-6-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("", "\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("", "\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("", "\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("", "\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("二併", "4-6-3 ダブルプレー\n2死3塁", UIImage(named: "2-3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("二併", "4-6-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("二併", "4-6-3 ダブルプレー\n1死1塁\n1点", UIImage(named: "1-4_1")! )
            }
                
            else if oneOutRunnersOnFirstAndThird{
                return ("二併", "4-6-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("", "\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("", "\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("二併", "4-6-3 ダブルプレー\n2死3塁", UIImage(named: "2-3,4-1")! )
            }
            else if oneOutFullBase{
                return ("二併", "4-6-3 ダブルプレー\n2死1,2塁\n1点3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if twoOutFullBase{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
        case .secondGoroThrowToThird:
            if noOutRunnerOnSecond{
                return ("二ゴロ", "セカンドゴロタッチアウト\n1死1塁", UIImage(named: "1-1")! )
            }else if oneOutRunnerOnThird{
                return ("二ゴロ", "セカンドゴロタッチアウト\n2死1塁", UIImage(named: "2-1")! )
            }else if twoOutRunnerOnThird{
                return ("二ゴロ", "セカンドゴロタッチアウト\n3アウトチェンジ", UIImage(named: "3-0")! )
            }else if noOutRunnersOnFirstAndSecond{
                return ("二ゴロ", "セカンドゴロ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }else if oneOutRunnersOnFirstAndSecond{
                return ("二ゴロ", "セカンドゴロ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }else if twoOutRunnersOnFirstAndSecond{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
        case .secondGoroThrowToHome:
            if noOutNoRunner {
                return ("", "\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("", "\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("", "\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return ("", "\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("", "\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("", "\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("二ゴロ", "セカンドゴロ\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnThird{
                return ("二ゴロ", "セカンドゴロ\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnThird{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("", "\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("", "\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("二ゴロ", "セカンドゴロ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("二ゴロ", "セカンドゴロ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("二ゴロ", "セカンドゴロ\n1死1,3塁", UIImage(named: "1-1,3")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("二ゴロ", "セカンドゴロ\n2死1,3塁", UIImage(named: "2-1,3")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutFullBase{
                return ("二併", "4-2-3ホームゲッツー\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if oneOutFullBase{
                return ("二併", "4-2-3ホームゲッツー\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if twoOutFullBase{
                return ("二ゴロ", "セカンドゴロ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
            
        case .thirdGoroThrowToFirst:
            if noOutNoRunner {
                return ("三ゴロ", "サードゴロ\n走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("三ゴロ", "サードゴロ\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("三ゴロ", "サードゴロ\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnFirst{
                return ("三ゴロ", "サードゴロ\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnFirst{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("三ゴロ", "サードゴロ\n1死3塁", UIImage(named: "1-3")! )
            }
            else if oneOutRunnerOnSecond{
                return ("三ゴロ", "サードゴロ\n2死3塁", UIImage(named: "2-3")! )
            }
            else if twoOutRunnerOnSecond{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("三ゴロ", "サードゴロ\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("三ゴロ", "サードゴロ\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("三ゴロ", "サードゴロ\n1死2,3塁", UIImage(named: "1-2,3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("三ゴロ", "サードゴロ\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("三ゴロ", "サードゴロ\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("三ゴロ", "サードゴロ\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("三ゴロ", "サードゴロ\n1死3塁\n1点", UIImage(named: "1-3,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("三ゴロ", "サードゴロ\n2死3塁\n1点", UIImage(named: "2-3,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("三ゴロ", "サードゴロ\n1死2,3塁\n1点", UIImage(named: "1-2,3,4_1")! )
            }
            else if oneOutFullBase{
                return ("三ゴロ", "サードゴロ\n2死2,3塁\n1点", UIImage(named: "2-2,3,4_1")! )
            }
            else if twoOutFullBase{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        case .thirdGoroThrowToSecond:
            if noOutNoRunner {
                return ("", "\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("", "\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("三併", "5-4-3 ダブルプレー\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("三併", "5-4-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("", "\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("", "\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("", "\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("", "\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("三併", "5-4-3 ダブルプレー\n2死3塁", UIImage(named: "2-3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("三併", "5-4-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("三併", "5-4-3 ダブルプレー\n1死1塁\n1点", UIImage(named: "1-4_1")! )
            }
                
            else if oneOutRunnersOnFirstAndThird{
                return ("三併", "5-4-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("", "\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("", "\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("三併", "5-4-3 ダブルプレー\n2死3塁", UIImage(named: "2-3,4-1")! )
            }
            else if oneOutFullBase{
                return ("三併", "5-4-3 ダブルプレー\n2死1,2塁\n1点3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if twoOutFullBase{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
        case .thirdGoroThrowToThird:
            if noOutRunnerOnSecond{
                return ("三ゴロ", "サードゴロタッチアウト\n1死1塁", UIImage(named: "1-1")! )
            }else if oneOutRunnerOnThird{
                return ("三ゴロ", "サードゴロタッチアウト\n2死1塁", UIImage(named: "2-1")! )
            }else if twoOutRunnerOnThird{
                return ("三ゴロ", "サードゴロタッチアウト\n3アウトチェンジ", UIImage(named: "3-0")! )
            }else if noOutRunnersOnFirstAndSecond{
                return ("三ゴロ", "サードゴロ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }else if oneOutRunnersOnFirstAndSecond{
                return ("三ゴロ", "サードゴロ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }else if twoOutRunnersOnFirstAndSecond{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
        case .thirdGoroThrowToHome:
            if noOutNoRunner {
                return ("", "\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("", "\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("", "\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return ("", "\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("", "\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("", "\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("三ゴロ", "サードゴロ\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnThird{
                return ("三ゴロ", "サードゴロ\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnThird{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("", "\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("", "\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("三ゴロ", "サードゴロ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("三ゴロ", "サードゴロ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("三ゴロ", "サードゴロ\n1死1,3塁", UIImage(named: "1-1,3")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("三ゴロ", "サードゴロ\n2死1,3塁", UIImage(named: "2-1,3")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutFullBase{
                return ("三併", "5-2-3ホームゲッツー\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if oneOutFullBase{
                return ("三併", "5-2-3ホームゲッツー\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if twoOutFullBase{
                return ("三ゴロ", "サードゴロ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
            
        case .shortGoroThrowToFirst:
            if noOutNoRunner {
                return ("遊ゴロ", "ショートゴロ\n走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("遊ゴロ", "ショートゴロ\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("遊ゴロ", "ショートゴロ\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnFirst{
                return ("遊ゴロ", "ショートゴロ\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnFirst{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("遊ゴロ", "ショートゴロ\n1死3塁", UIImage(named: "1-3")! )
            }
            else if oneOutRunnerOnSecond{
                return ("遊ゴロ", "ショートゴロ\n2死3塁", UIImage(named: "2-3")! )
            }
            else if twoOutRunnerOnSecond{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("遊ゴロ", "ショートゴロ\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("遊ゴロ", "ショートゴロ\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("遊ゴロ", "ショートゴロ\n1死2,3塁", UIImage(named: "1-2,3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("遊ゴロ", "ショートゴロ\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("遊ゴロ", "ショートゴロ\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("遊ゴロ", "ショートゴロ\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("遊ゴロ", "ショートゴロ\n1死3塁\n1点", UIImage(named: "1-3,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("遊ゴロ", "ショートゴロ\n2死3塁\n1点", UIImage(named: "2-3,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("遊ゴロ", "ショートゴロ\n1死2,3塁\n1点", UIImage(named: "1-2,3,4_1")! )
            }
            else if oneOutFullBase{
                return ("遊ゴロ", "ショートゴロ\n2死2,3塁\n1点", UIImage(named: "2-2,3,4_1")! )
            }
            else if twoOutFullBase{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        case .shortGoroThrowToSecond:
            if noOutNoRunner {
                return ("", "\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("", "\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("遊併", "6-4-3 ダブルプレー\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("遊併", "6-4-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("", "\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("", "\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("", "\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("", "\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("遊併", "6-4-3 ダブルプレー\n2死3塁", UIImage(named: "2-3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("遊併", "6-4-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("遊併", "6-4-3 ダブルプレー\n1死1塁\n1点", UIImage(named: "1-4_1")! )
            }
                
            else if oneOutRunnersOnFirstAndThird{
                return ("遊併", "6-4-3 ダブルプレー\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("", "\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("", "\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("遊併", "6-4-3 ダブルプレー\n2死3塁", UIImage(named: "2-3,4-1")! )
            }
            else if oneOutFullBase{
                return ("遊併", "6-4-3 ダブルプレー\n2死1,2塁\n1点3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if twoOutFullBase{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
        case .shortGoroThrowToThird:
            if noOutRunnerOnSecond{
                return ("遊ゴロ", "ショートゴロタッチアウト\n1死1塁", UIImage(named: "1-1")! )
            }else if oneOutRunnerOnThird{
                return ("遊ゴロ", "ショートゴロタッチアウト\n2死1塁", UIImage(named: "2-1")! )
            }else if twoOutRunnerOnThird{
                return ("遊ゴロ", "ショートゴロタッチアウト\n3アウトチェンジ", UIImage(named: "3-0")! )
            }else if noOutRunnersOnFirstAndSecond{
                return ("遊ゴロ", "ショートゴロ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }else if oneOutRunnersOnFirstAndSecond{
                return ("遊ゴロ", "ショートゴロ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }else if twoOutRunnersOnFirstAndSecond{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
        case .shortGoroThrowToHome:
            if noOutNoRunner {
                return ("", "\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("", "\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("", "\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return ("", "\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("", "\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("", "\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("遊ゴロ", "ショートゴロ\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnThird{
                return ("遊ゴロ", "ショートゴロ\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnThird{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("", "\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("", "\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("", "\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("遊ゴロ", "ショートゴロ\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("遊ゴロ", "ショートゴロ\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("遊ゴロ", "ショートゴロ\n1死1,3塁", UIImage(named: "1-1,3")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("遊ゴロ", "ショートゴロ\n2死1,3塁", UIImage(named: "2-1,3")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutFullBase{
                return ("遊併", "6-2-3ホームゲッツー\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if oneOutFullBase{
                return ("遊併", "6-2-3ホームゲッツー\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if twoOutFullBase{
                return ("遊ゴロ", "ショートゴロ\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
            
            
        case .struckOutSwinging:
            
            if noOutNoRunner {
                return ("空振", "空振り三振\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("空振", "空振り三振\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("空振", "空振り三振\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("空振", "空振り三振\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return ("空振", "空振り三振\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("空振", "空振り三振\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("空振", "空振り三振\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("空振", "空振り三振\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("空振", "空振り三振\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("空振", "空振り三振\n1死3塁", UIImage(named: "1-3")! )
            }
            else if oneOutRunnerOnThird{
                return ("空振", "空振り三振n2死3塁", UIImage(named: "2-3")! )
            }
            else if twoOutRunnerOnThird{
                return ("空振", "空振り三振\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("空振", "空振り三振\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("空振", "空振り三振\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("空振", "空振り三振\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("空振", "空振り三振\n1死1,3塁", UIImage(named: "1-1,3")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("空振", "空振り三振\n2死1,3塁", UIImage(named: "2-1,3")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("空振", "空振り三振\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("空振", "空振り三振\n1死2,3塁", UIImage(named: "1-2,3")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("空振", "空振り三振\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("空振", "空振り三振\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("空振", "空振り三振\n1死満塁", UIImage(named: "1-1,2,3")! )
            }
            else if oneOutFullBase{
                return ("空振", "空振り三振\n2死満塁", UIImage(named: "2-1,2,3")! )
            }
            else if twoOutFullBase{
                return ("空振", "空振り三振\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        case .missedStruckOut:
            if noOutNoRunner {
                return ("見振", "見逃し三振\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("見振", "見逃し三振\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("見振", "見逃し三振\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("見振", "見逃し三振\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return ("見振", "見逃し三振\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("見振", "見逃し三振\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("見振", "見逃し三振\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("見振", "見逃し三振\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("見振", "見逃し三振\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("見振", "見逃し三振\n1死3塁", UIImage(named: "1-3")! )
            }
            else if oneOutRunnerOnThird{
                return ("見振", "見逃し三振\n2死3塁", UIImage(named: "2-3")! )
            }
            else if twoOutRunnerOnThird{
                return ("見振", "見逃し三振\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("見振", "見逃し三振\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("見振", "見逃し三振\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("見振", "見逃し三振\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("見振", "見逃し三振\n1死1,3塁", UIImage(named: "1-1,3")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("見振", "見逃し三振\n2死1,3塁", UIImage(named: "2-1,3")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("見振", "見逃し三振\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("見振", "見逃し三振\n1死2,3塁", UIImage(named: "1-2,3")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("見振", "見逃し三振\n2死2,3塁", UIImage(named: "2-2,3")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("見振", "見逃し三振\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("見振", "見逃し三振\n1死満塁", UIImage(named: "1-1,2,3")! )
            }
            else if oneOutFullBase{
                return ("見振", "見逃し三振\n2死満塁", UIImage(named: "2-1,2,3")! )
            }
            else if twoOutFullBase{
                return ("見振", "見逃し三振\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        case .leftIntermediateHit:
            if noOutNoRunner {
                return ("左中二", "左中間ツーベース\n無死2塁", UIImage(named: "0-2")!)
            }else if oneOutNoRunner{
                return ("左中二", "左中間ツーベース\n1死2塁", UIImage(named: "1-2")!)
            }
            else if twoOutNoRunner{
                return ("左中二", "左中間ツーベース\n2死2塁", UIImage(named: "2-2")!)
            }
            else if noOutRunnerOnFirst{
                return ("左中二", "左中間ツーベース\n無死2,3塁", UIImage(named: "0-2,3")!)
            }
            else if oneOutRunnerOnFirst{
                return ("左中二", "左中間ツーベース\n1死2,3塁", UIImage(named: "1-2,3")!)
            }
            else if twoOutRunnerOnFirst{
                return ("左中二", "左中間ツーベース\n２死2死2,3塁", UIImage(named: "2-2,3")!)
            }
            else if noOutRunnerOnSecond{
                return ("左中二", "左中間ツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnSecond{
                return ("左中二", "左中間ツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnSecond{
                return ("左中二", "左中間ツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnerOnThird{
                return ("左中二", "左中間ツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("左中二", "左中間ツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("左中二", "左中間ツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("左中二", "左中間ツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("左中二", "左中間ツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("左中二", "左中間ツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("左中二", "左中間ツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("左中二", "左中間ツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("左中二", "左中間ツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("左中二", "左中間ツーベース\n無死2塁", UIImage(named: "0-2,4_2")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("左中二", "左中間ツーベース\n1死2塁", UIImage(named: "1-2,4_2")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("左中二", "左中間ツーベース\n2死2塁", UIImage(named: "2-2,4_2")!)
            }
            else if noOutFullBase{
                return ("左中二", "左中間ツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_2")!)
            }
            else if oneOutFullBase{
                return ("左中二", "左中間ツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_2")!)
            }
            else if twoOutFullBase{
                return ("左中二", "左中間ツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_2")!)
            }
        case .rightIntermediateHit:
            if noOutNoRunner {
                return ("右中二", "右中間ツーベース\n無死2塁", UIImage(named: "0-2")!)
            }else if oneOutNoRunner{
                return ("右中二", "右中間ツーベース\n1死2塁", UIImage(named: "1-2")!)
            }
            else if twoOutNoRunner{
                return ("右中二", "右中間ツーベース\n2死2塁", UIImage(named: "2-2")!)
            }
            else if noOutRunnerOnFirst{
                return ("右中二", "右中間ツーベース\n2死2塁", UIImage(named: "2-2")!)
            }
            else if oneOutRunnerOnFirst{
                return ("右中二", "右中間ツーベース\n1死2,3塁", UIImage(named: "1-2,3")!)
            }
            else if twoOutRunnerOnFirst{
                return ("右中二", "右中間ツーベース\n２死2死2,3塁", UIImage(named: "2-2,3")!)
            }
            else if noOutRunnerOnSecond{
                return ("右中二", "右中間ツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnSecond{
                return ("右中二", "右中間ツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnSecond{
                return ("右中二", "右中間ツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnerOnThird{
                return ("右中二", "右中間ツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("右中二", "右中間ツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("右中二", "右中間ツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("右中二", "右中間ツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("右中二", "右中間ツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("右中二", "左中間ツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("右中二", "右中間ツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("右中二", "右中間ツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("右中二", "右中間ツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("右中二", "右中間ツーベース\n無死2塁", UIImage(named: "0-2,4_2")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("右中二", "右中間ツーベース\n1死2塁", UIImage(named: "1-2,4_2")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("右中二", "右中間ツーベース\n2死2塁", UIImage(named: "2-2,4_2")!)
            }
            else if noOutFullBase{
                return ("右中二", "右中間ツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_2")!)
            }
            else if oneOutFullBase{
                return ("右中二", "右中間ツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_2")!)
            }
            else if twoOutFullBase{
                return ("右中二", "右中間ツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_2")!)
            }
        case .leftSingleHit:
            if noOutNoRunner {
                return ("左前安", "レフト前ヒット\n無死1塁", UIImage(named: "0-1")!)
            }else if oneOutNoRunner{
                return ("左前安", "レフト前ヒット\n1死1塁", UIImage(named: "1-1")!)
            }
            else if twoOutNoRunner{
                return ("左前安", "レフト前ヒット\n2死1塁", UIImage(named: "2-1")!)
            }
            else if noOutRunnerOnFirst{
                return ("左前安", "レフト前ヒット\n無死1,2塁", UIImage(named: "0-1,2")!)
            }
            else if oneOutRunnerOnFirst{
                return ("左前安", "レフト前ヒット\n1死1,2塁", UIImage(named: "1-1,2")!)
            }
            else if twoOutRunnerOnFirst{
                return ("左前安", "レフト前ヒット\n2死1,2塁", UIImage(named: "2-1,2")!)
            }
            else if noOutRunnerOnSecond{
                return ("左前安", "レフト前ヒット\n無死1,3塁", UIImage(named: "0-1,3")!)
            }
            else if oneOutRunnerOnSecond{
                return ( "左前安", "レフト前ヒット\n1死1,3塁", UIImage(named: "1-1,3")!)
            }
            else if twoOutRunnerOnSecond{
                return ("左前安", "レフト前ヒット\n2死1,3塁", UIImage(named: "2-1,3")!)
            }
            else if noOutRunnerOnThird{
                return ("左前安", "レフト前ヒット\n無死1塁", UIImage(named: "0-1,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("左前安", "レフト前ヒット\n1死1塁", UIImage(named: "1-1,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("左前安", "レフト前ヒット\n2死1塁", UIImage(named: "2-1,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("左前安", "レフト前ヒット\n無死満塁", UIImage(named: "0-1,2,3")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("左前安", "レフト前ヒット\n1死満塁", UIImage(named: "1-1,2,3")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("左前安", "レフト前ヒット\n2死満塁", UIImage(named: "2-1,2,3")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("左前安", "レフト前ヒット\n無死1,2塁", UIImage(named: "0-1,2,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("左前安", "レフト前ヒット\n1死1,2塁", UIImage(named: "1-1,2,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("左前安", "レフト前ヒット\n2死1,2塁", UIImage(named: "2-1,2,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("左前安", "レフト前ヒット\n無死1,3塁", UIImage(named: "0-1,3,4_1")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("左前安", "レフト前ヒット\n1死1,3塁", UIImage(named: "1-1,3,4_1")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("左前安", "レフト前ヒット\n2死1,3塁", UIImage(named: "2-1,3,4_1")!)
            }
            else if noOutFullBase{
                return ("左前安", "レフト前ヒット\n無死満塁", UIImage(named: "0-1,2,3,4_1")!)
            }
            else if oneOutFullBase{
                return ("左前安", "レフト前ヒット\n1死満塁", UIImage(named: "1-1,2,3,4_1")!)
            }
            else if twoOutFullBase{
                return ("左前安", "レフト前ヒット\n2死満塁", UIImage(named: "2-1,2,3,4_1")!)
            }
        case .centerSingleHit:
            if noOutNoRunner {
                return ("中前安", "センター前ヒット\n無死1塁", UIImage(named: "0-1")!)
            }else if oneOutNoRunner{
                return ("中前安", "センター前ヒット\n1死1塁", UIImage(named: "1-1")!)
            }
            else if twoOutNoRunner{
                return ("中前安", "センター前ヒット\n2死1塁", UIImage(named: "2-1")!)
            }
            else if noOutRunnerOnFirst{
                return ("中前安", "センター前ヒット\n無死1,2塁", UIImage(named: "0-1,2")!)
            }
            else if oneOutRunnerOnFirst{
                return ("中前安", "センター前ヒット\n1死1,2塁", UIImage(named: "1-1,2")!)
            }
            else if twoOutRunnerOnFirst{
                return ("中前安", "センター前ヒット\n2死1,2塁", UIImage(named: "2-1,2")!)
            }
            else if noOutRunnerOnSecond{
                return ("中前安", "センター前ヒット\n無死1,3塁", UIImage(named: "0-1,3")!)
            }
            else if oneOutRunnerOnSecond{
                return ( "中前安", "センター前ヒット\n1死1,3塁", UIImage(named: "1-1,3")!)
            }
            else if twoOutRunnerOnSecond{
                return ("中前安", "センター前ヒット\n2死1,3塁", UIImage(named: "2-1,3")!)
            }
            else if noOutRunnerOnThird{
                return ("中前安", "センター前ヒット\n無死1塁", UIImage(named: "0-1,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("中前安", "センター前ヒット\n1死1塁", UIImage(named: "1-1,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("中前安", "センター前ヒット\n2死1塁", UIImage(named: "2-1,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("中前安", "センター前ヒット\n無死満塁", UIImage(named: "0-1,2,3")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("中前安", "センター前ヒット\n1死満塁", UIImage(named: "1-1,2,3")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("中前安", "センター前ヒット\n2死満塁", UIImage(named: "2-1,2,3")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("中前安", "センター前ヒット\n無死1,2塁", UIImage(named: "0-1,2,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("中前安", "センター前ヒット\n1死1,2塁", UIImage(named: "1-1,2,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("中前安", "センター前ヒット\n2死1,2塁", UIImage(named: "2-1,2,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("中前安", "センター前ヒット\n無死1,3塁", UIImage(named: "0-1,3,4_1")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("中前安", "センター前ヒット\n1死1,3塁", UIImage(named: "1-1,3,4_1")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("中前安", "センター前ヒット\n2死1,3塁", UIImage(named: "2-1,3,4_1")!)
            }
            else if noOutFullBase{
                return ("中前安", "センター前ヒット\n無死満塁", UIImage(named: "0-1,2,3,4_1")!)
            }
            else if oneOutFullBase{
                return ("中前安", "センター前ヒット\n1死満塁", UIImage(named: "1-1,2,3,4_1")!)
            }
            else if twoOutFullBase{
                return ("中前安", "センター前ヒット\n2死満塁", UIImage(named: "2-1,2,3,4_1")!)
            }
        case .rightSingleHit:
            if noOutNoRunner {
                return ("右前安", "ライト前ヒット\n無死1塁", UIImage(named: "0-1")!)
            }else if oneOutNoRunner{
                return ("右前安", "ライト前ヒット\n1死1塁", UIImage(named: "1-1")!)
            }
            else if twoOutNoRunner{
                return ("右前安", "ライト前ヒット\n2死1塁", UIImage(named: "2-1")!)
            }
            else if noOutRunnerOnFirst{
                return ("右前安", "ライト前ヒット\n無死1,2塁", UIImage(named: "0-1,2")!)
            }
            else if oneOutRunnerOnFirst{
                return ("右前安", "ライト前ヒット\n1死1,2塁", UIImage(named: "1-1,2")!)
            }
            else if twoOutRunnerOnFirst{
                return ("右前安", "ライト前ヒット\n2死1,2塁", UIImage(named: "2-1,2")!)
                
            }
            else if noOutRunnerOnSecond{
                return ("右前安", "ライト前ヒット\n無死1,3塁", UIImage(named: "0-1,3")!)
            }
            else if oneOutRunnerOnSecond{
                return ( "右前安", "ライト前ヒット\n1死1,3塁", UIImage(named: "1-1,3")!)
                
            }
            else if twoOutRunnerOnSecond{
                return ("右前安", "ライト前ヒット\n2死1,3塁", UIImage(named: "2-1,3")!)
                
            }
            else if noOutRunnerOnThird{
                return ("右前安", "ライト前ヒット\n無死1塁", UIImage(named: "0-1,4_1")!)
                
            }
            else if oneOutRunnerOnThird{
                return ("右前安", "ライト前ヒット\n1死1塁", UIImage(named: "1-1,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("右前安", "ライト前ヒット\n2死1塁", UIImage(named: "2-1,4_1")!)
                
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("右前安", "ライト前ヒット\n無死満塁", UIImage(named: "0-1,2,3")!)
                
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("右前安", "ライト前ヒット\n1死満塁", UIImage(named: "1-1,2,3")!)
                
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("右前安", "ライト前ヒット\n2死満塁", UIImage(named: "2-1,2,3")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("右前安", "ライト前ヒット\n無死1,2塁", UIImage(named: "0-1,2,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("右前安", "ライト前ヒット\n1死1,2塁", UIImage(named: "1-1,2,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("右前安", "ライト前ヒット\n2死1,2塁", UIImage(named: "2-1,2,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("右前安", "ライト前ヒット\n無死1,3塁", UIImage(named: "0-1,3,4_1")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("右前安", "ライト前ヒット\n1死1,3塁", UIImage(named: "1-1,3,4_1")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("右前安", "ライト前ヒット\n2死1,3塁", UIImage(named: "2-1,3,4_1")!)
            }
            else if noOutFullBase{
                return ("右前安", "ライト前ヒット\n無死満塁", UIImage(named: "0-1,2,3,4_1")!)
            }
            else if oneOutFullBase{
                return ("右前安", "ライト前ヒット\n1死満塁", UIImage(named: "1-1,2,3,4_1")!)
            }
            else if twoOutFullBase{
                return ("右前安", "ライト前ヒット\n2死満塁", UIImage(named: "2-1,2,3,4_1")!)
                
            }
        case .pitcherOrCatcherHit:
            if noOutNoRunner {
                return ("投前安", "ピッチャー内野安打\n無死1塁", UIImage(named: "0-1")!)
            }else if oneOutNoRunner{
                return ("投前安", "ピッチャー内野安打\n1死1塁", UIImage(named: "1-1")!)
            }
            else if twoOutNoRunner{
                return ("投前安", "ピッチャー内野安打\n2死1塁", UIImage(named: "2-1")!)
            }
            else if noOutRunnerOnFirst{
                return ("投前安", "ピッチャー内野安打\n無死1,2塁", UIImage(named: "0-1,2")!)
            }
            else if oneOutRunnerOnFirst{
                return ("投前安", "ピッチャー内野安打\n1死1,2塁", UIImage(named: "1-1,2")!)
            }
            else if twoOutRunnerOnFirst{
                return ("投前安", "ピッチャー内野安打\n2死1,2塁", UIImage(named: "2-1,2")!)
            }
            else if noOutRunnerOnSecond{
                return ("投前安", "ピッチャー内野安打\n無死1,3塁", UIImage(named: "0-1,3")!)
            }
            else if oneOutRunnerOnSecond{
                return ( "投前安", "ピッチャー内野安打\n1死1,3塁", UIImage(named: "1-1,3")!)
            }
            else if twoOutRunnerOnSecond{
                return ("投前安", "ピッチャー内野安打\n2死1,3塁", UIImage(named: "2-1,3")!)
                
            }
            else if noOutRunnerOnThird{
                return ("投前安", "ピッチャー内野安打\n無死1塁", UIImage(named: "0-1,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("投前安", "ピッチャー内野安打\n1死1塁", UIImage(named: "1-1,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("投前安", "ピッチャー内野安打\n2死1塁", UIImage(named: "2-1,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("投前安", "ピッチャー内野安打\n無死満塁", UIImage(named: "0-1,2,3")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("投前安", "ピッチャー内野安打\n1死満塁", UIImage(named: "1-1,2,3")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("投前安", "ピッチャー内野安打\n2死満塁", UIImage(named: "2-1,2,3")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("投前安", "ピッチャー内野安打\n無死1,2塁", UIImage(named: "0-1,2,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("投前安", "ピッチャー内野安打\n1死1,2塁", UIImage(named: "1-1,2,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("投前安", "ピッチャー内野安打\n2死1,2塁", UIImage(named: "2-1,2,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("投前安", "ピッチャー内野安打\n無死1,3塁", UIImage(named: "0-1,3,4_1")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("投前安", "ピッチャー内野安打\n1死1,3塁", UIImage(named: "1-1,3,4_1")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("投前安", "ピッチャー内野安打\n2死1,3塁", UIImage(named: "2-1,3,4_1")!)
            }
            else if noOutFullBase{
                return ("投前安", "ピッチャー内野安打\n無死満塁", UIImage(named: "0-1,2,3,4_1")!)
            }
            else if oneOutFullBase{
                return ("投前安", "ピッチャー内野安打\n1死満塁", UIImage(named: "1-1,2,3,4_1")!)
            }
            else if twoOutFullBase{
                return ("投前安", "ピッチャー内野安打\n2死満塁", UIImage(named: "2-1,2,3,4_1")!)
                
            }
        case .firstHit:
            if noOutNoRunner {
                return ("一前安", "ファースト内野安打\n無死1塁", UIImage(named: "0-1")!)
            }else if oneOutNoRunner{
                return ("一前安", "ファースト内野安打\n1死1塁", UIImage(named: "1-1")!)
            }
            else if twoOutNoRunner{
                return ("一前安", "ファースト内野安打\n2死1塁", UIImage(named: "2-1")!)
            }
            else if noOutRunnerOnFirst{
                return ("一前安", "ファースト内野安打\n無死1,2塁", UIImage(named: "0-1,2")!)
            }
            else if oneOutRunnerOnFirst{
                return ("一前安", "ファースト内野安打\n1死1,2塁", UIImage(named: "1-1,2")!)
            }
            else if twoOutRunnerOnFirst{
                return ("一前安", "ファースト内野安打\n2死1,2塁", UIImage(named: "2-1,2")!)
            }
            else if noOutRunnerOnSecond{
                return ("一前安", "ファースト内野安打\n無死1,3塁", UIImage(named: "0-1,3")!)
            }
            else if oneOutRunnerOnSecond{
                return ( "一前安", "ファースト内野安打\n1死1,3塁", UIImage(named: "1-1,3")!)
            }
            else if twoOutRunnerOnSecond{
                return ("一前安", "ファースト内野安打\n2死1,3塁", UIImage(named: "2-1,3")!)
                
            }
            else if noOutRunnerOnThird{
                return ("一前安", "ファースト内野安打\n無死1塁", UIImage(named: "0-1,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("一前安", "ファースト内野安打\n1死1塁", UIImage(named: "1-1,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("一前安", "ファースト内野安打\n2死1塁", UIImage(named: "2-1,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("一前安", "ファースト内野安打\n無死満塁", UIImage(named: "0-1,2,3")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("一前安", "ファースト内野安打\n1死満塁", UIImage(named: "1-1,2,3")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("一前安", "ファースト内野安打\n2死満塁", UIImage(named: "2-1,2,3")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("一前安", "ファースト内野安打\n無死1,2塁", UIImage(named: "0-1,2,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("一前安", "ファースト内野安打\n1死1,2塁", UIImage(named: "1-1,2,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("一前安", "ファースト内野安打\n2死1,2塁", UIImage(named: "2-1,2,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("一前安", "ファースト内野安打\n無死1,3塁", UIImage(named: "0-1,3,4_1")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("一前安", "ファースト内野安打\n1死1,3塁", UIImage(named: "1-1,3,4_1")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("一前安", "ファースト内野安打\n2死1,3塁", UIImage(named: "2-1,3,4_1")!)
            }
            else if noOutFullBase{
                return ("一前安", "ファースト内野安打\n無死満塁", UIImage(named: "0-1,2,3,4_1")!)
            }
            else if oneOutFullBase{
                return ("一前安", "ファースト内野安打\n1死満塁", UIImage(named: "1-1,2,3,4_1")!)
            }
            else if twoOutFullBase{
                return ("一前安", "ファースト内野安打\n2死満塁", UIImage(named: "2-1,2,3,4_1")!)
            }
            
        case .secondHit:
            if noOutNoRunner {
                return ("二前安", "セカンド内野安打\n無死1塁", UIImage(named: "0-1")!)
            }else if oneOutNoRunner{
                return ("二前安", "セカンド内野安打\n1死1塁", UIImage(named: "1-1")!)
            }
            else if twoOutNoRunner{
                return ("二前安", "セカンド内野安打\n2死1塁", UIImage(named: "2-1")!)
            }
            else if noOutRunnerOnFirst{
                return ("二前安", "セカンド内野安打\n無死1,2塁", UIImage(named: "0-1,2")!)
            }
            else if oneOutRunnerOnFirst{
                return ("二前安", "セカンド内野安打\n1死1,2塁", UIImage(named: "1-1,2")!)
            }
            else if twoOutRunnerOnFirst{
                return ("二前安", "セカンド内野安打\n2死1,2塁", UIImage(named: "2-1,2")!)
            }
            else if noOutRunnerOnSecond{
                return ("二前安", "セカンド内野安打\n無死1,3塁", UIImage(named: "0-1,3")!)
            }
            else if oneOutRunnerOnSecond{
                return ( "二前安", "セカンド内野安打\n1死1,3塁", UIImage(named: "1-1,3")!)
            }
            else if twoOutRunnerOnSecond{
                return ("二前安", "セカンド内野安打\n2死1,3塁", UIImage(named: "2-1,3")!)
            }
            else if noOutRunnerOnThird{
                return ("二前安", "セカンド内野安打\n無死1塁", UIImage(named: "0-1,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("二前安", "セカンド内野安打\n1死1塁", UIImage(named: "1-1,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("二前安", "セカンド内野安打\n2死1塁", UIImage(named: "2-1,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("二前安", "セカンド内野安打\n無死満塁", UIImage(named: "0-1,2,3")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("二前安", "セカンド内野安打\n1死満塁", UIImage(named: "1-1,2,3")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("二前安", "セカンド内野安打\n2死満塁", UIImage(named: "2-1,2,3")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("二前安", "セカンド内野安打\n無死1,2塁", UIImage(named: "0-1,2,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("二前安", "セカンド内野安打\n1死1,2塁", UIImage(named: "1-1,2,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("二前安", "セカンド内野安打\n2死1,2塁", UIImage(named: "2-1,2,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("二前安", "セカンド内野安打\n無死1,3塁", UIImage(named: "0-1,3,4_1")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("二前安", "セカンド内野安打\n1死1,3塁", UIImage(named: "1-1,3,4_1")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("二前安", "セカンド内野安打\n2死1,3塁", UIImage(named: "2-1,3,4_1")!)
            }
            else if noOutFullBase{
                return ("二前安", "セカンド内野安打\n無死満塁", UIImage(named: "0-1,2,3,4_1")!)
            }
            else if oneOutFullBase{
                return ("二前安", "セカンド内野安打\n1死満塁", UIImage(named: "1-1,2,3,4_1")!)
            }
            else if twoOutFullBase{
                return ("二前安", "セカンド内野安打\n2死満塁", UIImage(named: "2-1,2,3,4_1")!)
            }
        case .thirdHit:
            if noOutNoRunner {
                return ("三前安", "サード内野安打\n無死1塁", UIImage(named: "0-1")!)
            }else if oneOutNoRunner{
                return ("三前安", "サード内野安打\n1死1塁", UIImage(named: "1-1")!)
            }
            else if twoOutNoRunner{
                return ("三前安", "サード内野安打\n2死1塁", UIImage(named: "2-1")!)
            }
            else if noOutRunnerOnFirst{
                return ("三前安", "サード内野安打\n無死1,2塁", UIImage(named: "0-1,2")!)
            }
            else if oneOutRunnerOnFirst{
                return ("三前安", "サード内野安打\n1死1,2塁", UIImage(named: "1-1,2")!)
            }
            else if twoOutRunnerOnFirst{
                return ("三前安", "サード内野安打\n2死1,2塁", UIImage(named: "2-1,2")!)
            }
            else if noOutRunnerOnSecond{
                return ("三前安", "サード内野安打\n無死1,3塁", UIImage(named: "0-1,3")!)
            }
            else if oneOutRunnerOnSecond{
                return ( "三前安", "サード内野安打\n1死1,3塁", UIImage(named: "1-1,3")!)
            }
            else if twoOutRunnerOnSecond{
                return ("三前安", "サード内野安打\n2死1,3塁", UIImage(named: "2-1,3")!)
            }
            else if noOutRunnerOnThird{
                return ("三前安", "サード内野安打\n無死1塁", UIImage(named: "0-1,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("三前安", "サード内野安打\n1死1塁", UIImage(named: "1-1,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("三前安", "サード内野安打\n2死1塁", UIImage(named: "2-1,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("三前安", "サード内野安打\n無死満塁", UIImage(named: "0-1,2,3")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("三前安", "サード内野安打\n1死満塁", UIImage(named: "1-1,2,3")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("三前安", "サード内野安打\n2死満塁", UIImage(named: "2-1,2,3")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("三前安", "サード内野安打\n無死1,2塁", UIImage(named: "0-1,2,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("三前安", "サード内野安打\n1死1,2塁", UIImage(named: "1-1,2,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("三前安", "サード内野安打\n2死1,2塁", UIImage(named: "2-1,2,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("三前安", "サード内野安打\n無死1,3塁", UIImage(named: "0-1,3,4_1")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("三前安", "サード内野安打\n1死1,3塁", UIImage(named: "1-1,3,4_1")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("三前安", "サード内野安打\n2死1,3塁", UIImage(named: "2-1,3,4_1")!)
            }
            else if noOutFullBase{
                return ("三前安", "サード内野安打\n無死満塁", UIImage(named: "0-1,2,3,4_1")!)
            }
            else if oneOutFullBase{
                return ("三前安", "サード内野安打\n1死満塁", UIImage(named: "1-1,2,3,4_1")!)
            }
            else if twoOutFullBase{
                return ("三前安", "サード内野安打\n2死満塁", UIImage(named: "2-1,2,3,4_1")!)
            }
        case .shortHit:
            if noOutNoRunner {
                return ("遊前安", "ショート内野安打\n無死1塁", UIImage(named: "0-1")!)
            }else if oneOutNoRunner{
                return ("遊前安", "ショート内野安打\n1死1塁", UIImage(named: "1-1")!)
            }
            else if twoOutNoRunner{
                return ("遊前安", "ショート内野安打\n2死1塁", UIImage(named: "2-1")!)
                
            }
            else if noOutRunnerOnFirst{
                return ("遊前安", "ショート内野安打\n無死1,2塁", UIImage(named: "0-1,2")!)
            }
            else if oneOutRunnerOnFirst{
                return ("遊前安", "ショート内野安打\n1死1,2塁", UIImage(named: "1-1,2")!)
            }
            else if twoOutRunnerOnFirst{
                return ("遊前安", "ショート内野安打\n2死1,2塁", UIImage(named: "2-1,2")!)
            }
            else if noOutRunnerOnSecond{
                return ("遊前安", "ショート内野安打\n無死1,3塁", UIImage(named: "0-1,3")!)
            }
            else if oneOutRunnerOnSecond{
                return ( "遊前安", "ショート内野安打\n1死1,3塁", UIImage(named: "1-1,3")!)
            }
            else if twoOutRunnerOnSecond{
                return ("遊前安", "ショート内野安打\n2死1,3塁", UIImage(named: "2-1,3")!)
            }
            else if noOutRunnerOnThird{
                return ("遊前安", "ショート内野安打\n無死1塁", UIImage(named: "0-1,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("遊前安", "ショート内野安打\n1死1塁", UIImage(named: "1-1,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("遊前安", "ショート内野安打\n2死1塁", UIImage(named: "2-1,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("遊前安", "ショート内野安打\n無死満塁", UIImage(named: "0-1,2,3")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("遊前安", "ショート内野安打\n1死満塁", UIImage(named: "1-1,2,3")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("遊前安", "ショート内野安打\n2死満塁", UIImage(named: "2-1,2,3")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("遊前安", "ショート内野安打\n無死1,2塁", UIImage(named: "0-1,2,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("遊前安", "ショート内野安打\n1死1,2塁", UIImage(named: "1-1,2,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("遊前安", "ショート内野安打\n2死1,2塁", UIImage(named: "2-1,2,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("遊前安", "ショート内野安打\n無死1,3塁", UIImage(named: "0-1,3,4_1")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("遊前安", "ショート内野安打\n1死1,3塁", UIImage(named: "1-1,3,4_1")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("遊前安", "ショート内野安打\n2死1,3塁", UIImage(named: "2-1,3,4_1")!)
            }
            else if noOutFullBase{
                return ("遊前安", "ショート内野安打\n無死満塁", UIImage(named: "0-1,2,3,4_1")!)
            }
            else if oneOutFullBase{
                return ("遊前安", "ショート内野安打\n1死満塁", UIImage(named: "1-1,2,3,4_1")!)
            }
            else if twoOutFullBase{
                return ("遊前安", "ショート内野安打\n2死満塁", UIImage(named: "2-1,2,3,4_1")!)
            }
        case .leftOverHit:
            if noOutNoRunner {
                return ("左越二", "レフトオーバーツーベース\n無死2塁", UIImage(named: "0-2")!)
            }else if oneOutNoRunner{
                return ("左越二", "レフトオーバーツーベース\n1死2塁", UIImage(named: "1-2")!)
            }
            else if twoOutNoRunner{
                return ("左越二", "レフトオーバーツーベース\n2死2塁", UIImage(named: "2-2")!)
            }
            else if noOutRunnerOnFirst{
                return ("左越二", "レフトオーバーツーベース\n無死2,3塁", UIImage(named: "0-2,3")!)
            }
            else if oneOutRunnerOnFirst{
                return ("左越二", "レフトオーバーツーベース\n1死2,3塁", UIImage(named: "1-2,3")!)
            }
            else if twoOutRunnerOnFirst{
                return ("左越二", "レフトオーバーツーベース\n２死2死2,3塁", UIImage(named: "2-2,3")!)
            }
            else if noOutRunnerOnSecond{
                return ("左越二", "レフトオーバーツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnSecond{
                return ("左越二", "レフトオーバーツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnSecond{
                return ("左越二", "レフトオーバーツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnerOnThird{
                return ("左越二", "レフトオーバーツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("左越二", "レフトオーバーツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("左越二", "レフトオーバーツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("左越二", "レフトオーバーツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("左越二", "レフトオーバーツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("左越二", "レフトオーバーツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("左越二", "レフトオーバーツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("左越二", "レフトオーバーツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("左越二", "レフトオーバーツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("左越二", "レフトオーバーツーベース\n無死2塁", UIImage(named: "0-2,4_2")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("左越二", "レフトオーバーツーベース\n1死2塁", UIImage(named: "1-2,4_2")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("左越二", "レフトオーバーツーベース\n2死2塁", UIImage(named: "2-2,4_2")!)
            }
            else if noOutFullBase{
                return ("左越二", "レフトオーバーツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_2")!)
            }
            else if oneOutFullBase{
                return ("左越二", "レフトオーバーツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_2")!)
            }
            else if twoOutFullBase{
                return ("左越二", "レフトオーバーツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_2")!)
            }
            
        case .centerOverHit:
            if noOutNoRunner {
                return ("中越二", "センターオーバーツーベース\n無死2塁", UIImage(named: "0-2")!)
            }else if oneOutNoRunner{
                return ("中越二", "センターオーバーツーベース\n1死2塁", UIImage(named: "1-2")!)
            }
            else if twoOutNoRunner{
                return ("中越二", "センターオーバーツーベース\n2死2塁", UIImage(named: "2-2")!)
            }
            else if noOutRunnerOnFirst{
                return ("中越二", "センターオーバーツーベース\n無死2,3塁", UIImage(named: "0-2,3")!)
            }
            else if oneOutRunnerOnFirst{
                return ("中越二", "センターオーバーツーベース\n1死2,3塁", UIImage(named: "1-2,3")!)
            }
            else if twoOutRunnerOnFirst{
                return ("中越二", "センターオーバーツーベース\n２死2死2,3塁", UIImage(named: "2-2,3")!)
            }
            else if noOutRunnerOnSecond{
                return ("中越二", "センターオーバーツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnSecond{
                return ("中越二", "センターオーバーツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnSecond{
                return ("中越二", "センターオーバーツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnerOnThird{
                return ("中越二", "センターオーバーツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("中越二", "センターオーバーツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("中越二", "センターオーバーツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("中越二", "センターオーバーツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("中越二", "センターオーバーツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("中越二", "センターオーバーツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("中越二", "センターオーバーツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("中越二", "センターオーバーツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("中越二", "センターオーバーツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("中越二", "センターオーバーツーベース\n無死2塁", UIImage(named: "0-2,4_2")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("中越二", "センターオーバーツーベース\n1死2塁", UIImage(named: "1-2,4_2")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("中越二", "センターオーバーツーベース\n2死2塁", UIImage(named: "2-2,4_2")!)
            }
            else if noOutFullBase{
                return ("中越二", "センターオーバーツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_2")!)
            }
            else if oneOutFullBase{
                return ("中越二", "センターオーバーツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_2")!)
            }
            else if twoOutFullBase{
                return ("中越二", "センターオーバーツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_2")!)
            }
            
        case .rightOverHit:
            if noOutNoRunner {
                return ("右越二", "ライトオーバーツーベース\n無死2塁", UIImage(named: "0-2")!)
            }else if oneOutNoRunner{
                return ("右越二", "ライトオーバーツーベース\n1死2塁", UIImage(named: "1-2")!)
            }
            else if twoOutNoRunner{
                return ("右越二", "ライトオーバーツーベース\n2死2塁", UIImage(named: "2-2")!)
            }
            else if noOutRunnerOnFirst{
                return ("右越二", "ライトオーバーツーベース\n無死2,3塁", UIImage(named: "0-2,3")!)
            }
            else if oneOutRunnerOnFirst{
                return ("右越二", "ライトオーバーツーベース\n1死2,3塁", UIImage(named: "1-2,3")!)
            }
            else if twoOutRunnerOnFirst{
                return ("右越二", "ライトオーバーツーベース\n２死2死2,3塁", UIImage(named: "2-2,3")!)
            }
            else if noOutRunnerOnSecond{
                return ("右越二", "ライトオーバーツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnSecond{
                return ("右越二", "ライトオーバーツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnSecond{
                return ("右越二", "ライトオーバーツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnerOnThird{
                return ("右越二", "ライトオーバーツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("右越二", "ライトオーバーツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("右越二", "ライトオーバーツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("右越二", "ライトオーバーツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("右越二", "ライトオーバーツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("右越二", "ライトオーバーツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)            }
            else if noOutRunnersOnFirstAndThird{
                return ("右越二", "ライトオーバーツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("右越二", "ライトオーバーツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("右越二", "ライトオーバーツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("右越二", "ライトオーバーツーベース\n無死2塁", UIImage(named: "0-2,4_2")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("右越二", "ライトオーバーツーベース\n1死2塁", UIImage(named: "1-2,4_2")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("右越二", "ライトオーバーツーベース\n2死2塁", UIImage(named: "2-2,4_2")!)
            }
            else if noOutFullBase{
                return ("右越二", "ライトオーバーツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_2")!)
            }
            else if oneOutFullBase{
                return ("右越二", "ライトオーバーツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_2")!)
            }
            else if twoOutFullBase{
                return ("右越二", "ライトオーバーツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_2")!)
            }
            
        case .thirdBaseLineHit:
            if noOutNoRunner {
                return ("三線二", "三塁線ツーベース\n無死2塁", UIImage(named: "0-2")!)
            }else if oneOutNoRunner{
                return ("三線二", "三塁線ツーベース\n1死2塁", UIImage(named: "1-2")!)
            }
            else if twoOutNoRunner{
                return ("三線二", "三塁線ツーベース\n2死2塁", UIImage(named: "2-2")!)
            }
            else if noOutRunnerOnFirst{
                return ("三線二", "三塁線ツーベース\n無死2,3塁", UIImage(named: "0-2,3")!)
            }
            else if oneOutRunnerOnFirst{
                return ("三線二", "三塁線ツーベース\n1死2,3塁", UIImage(named: "1-2,3")!)
            }
            else if twoOutRunnerOnFirst{
                return ("三線二", "三塁線ツーベース\n２死2死2,3塁", UIImage(named: "2-2,3")!)
            }
            else if noOutRunnerOnSecond{
                return ("三線二", "三塁線ツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnSecond{
                return ("三線二", "三塁線ツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnSecond{
                return ("三線二", "三塁線ツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnerOnThird{
                return ("三線二", "三塁線ツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("三線二", "三塁線ツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("三線二", "三塁線ツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("三線二", "三塁線ツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("三線二", "三塁線ツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("三線二", "三塁線ツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("三線二", "三塁線ツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("三線二", "三塁線ツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("三線二", "三塁線ツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("三線二", "三塁線ツーベース\n無死2塁", UIImage(named: "0-2,4_2")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("三線二", "三塁線ツーベース\n1死2塁", UIImage(named: "1-2,4_2")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("三線二", "三塁線ツーベース\n2死2塁", UIImage(named: "2-2,4_2")!)
            }
            else if noOutFullBase{
                return ("三線二", "三塁線ツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_2")!)
            }
            else if oneOutFullBase{
                return ("三線二", "三塁線ツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_2")!)
            }
            else if twoOutFullBase{
                return ("三線二", "三塁線ツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_2")!)
            }
            
        case .firstBaseLineHit:
            if noOutNoRunner {
                return ("一線二", "一塁線ツーベース\n無死2塁", UIImage(named: "0-2")!)
            }else if oneOutNoRunner{
                return ("一線二", "一塁線ツーベース\n1死2塁", UIImage(named: "1-2")!)
            }
            else if twoOutNoRunner{
                return ("一線二", "一塁線ツーベース\n2死2塁", UIImage(named: "2-2")!)
            }
            else if noOutRunnerOnFirst{
                return ("一線二", "一塁線ツーベース\n無死2,3塁", UIImage(named: "0-2,3")!)
            }
            else if oneOutRunnerOnFirst{
                return ("一線二", "一塁線ツーベース\n1死2,3塁", UIImage(named: "1-2,3")!)
            }
            else if twoOutRunnerOnFirst{
                return ("一線二", "一塁線ツーベース\n２死2死2,3塁", UIImage(named: "2-2,3")!)
            }
            else if noOutRunnerOnSecond{
                return ("一線二", "一塁線ツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnSecond{
                return ("一線二", "一塁線ツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnSecond{
                return ("一線二", "一塁線ツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnerOnThird{
                return ("一線二", "一塁線ツーベース\n無死2塁", UIImage(named: "0-2,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("一線二", "一塁線ツーベース\n1死2塁", UIImage(named: "1-2,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("一線二", "一塁線ツーベース\n2死2塁", UIImage(named: "2-2,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("一線二", "一塁線ツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("一線二", "一塁線ツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("一線二", "一塁線ツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("一線二", "一塁線ツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("一線二", "一塁線ツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("一線二", "一塁線ツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("一線二", "一塁線ツーベース\n無死2塁", UIImage(named: "0-2,4_2")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("一線二", "一塁線ツーベース\n1死2塁", UIImage(named: "1-2,4_2")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("一線二", "一塁線ツーベース\n2死2塁", UIImage(named: "2-2,4_2")!)
            }
            else if noOutFullBase{
                return ("一線二", "一塁線ツーベース\n無死2,3塁", UIImage(named: "0-2,3,4_2")!)
            }
            else if oneOutFullBase{
                return ("一線二", "一塁線ツーベース\n1死2,3塁", UIImage(named: "1-2,3,4_2")!)            }
            else if twoOutFullBase{
                return ("一線二", "一塁線ツーベース\n2死2,3塁", UIImage(named: "2-2,3,4_2")!)
            }
        case .fourBall:
            if noOutNoRunner {
                return ("四球", "フォアボール\n無死1塁", UIImage(named: "0-1")! )
            }else if oneOutNoRunner{
                return ("四球", "フォアボール\n1死1塁", UIImage(named: "1-1")! )
            }
            else if twoOutNoRunner{
                return ("四球", "フォアボール\n2死1塁", UIImage(named: "2-1")! )
            }
            else if noOutRunnerOnFirst{
                return ("四球", "フォアボール\n無死1,2塁", UIImage(named: "0-1,2")! )
            }
            else if oneOutRunnerOnFirst{
                return ("四球", "フォアボール\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if twoOutRunnerOnFirst{
                return ("四球", "フォアボール\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if noOutRunnerOnSecond{
                return ("四球", "フォアボール\n無死1,2塁", UIImage(named: "0-1,2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("四球", "フォアボール\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("四球", "フォアボール\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if noOutRunnerOnThird{
                return ("四球", "フォアボール\n無死1,3塁", UIImage(named: "0-1,3")! )
            }
            else if oneOutRunnerOnThird{
                return ("四球", "フォアボール\n1死1,3塁", UIImage(named: "1-1,3")! )
            }
            else if twoOutRunnerOnThird{
                return ("四球", "フォアボール\n2死1,3塁", UIImage(named: "2-1,3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("四球", "フォアボール\n無死満塁", UIImage(named: "0-1,2,3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("四球", "フォアボール\n1死満塁", UIImage(named: "1-1,2,3")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("四球", "フォアボール\n2死満塁", UIImage(named: "2-1,2,3")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("四球", "フォアボール\n無死満塁", UIImage(named: "0-1,2,3")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("四球", "フォアボール\n1死満塁", UIImage(named: "1-1,2,3")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("四球", "フォアボール\n2死満塁", UIImage(named: "2-1,2,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("四球", "フォアボール\n無死満塁", UIImage(named: "0-1,2,3")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("四球", "フォアボール\n1死満塁", UIImage(named: "1-1,2,3")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("四球", "フォアボール\n2死満塁", UIImage(named: "2-1,2,3")! )
            }
            else if noOutFullBase{
                return ("四球", "フォアボール\n無死満塁", UIImage(named: "0-1,2,3,4_1")! )
            }
            else if oneOutFullBase{
                return ("四球", "フォアボール\n1死満塁", UIImage(named: "1-1,2,3,4_1")! )
            }
            else if twoOutFullBase{
                return ("四球", "フォアボール\n2死満塁", UIImage(named: "2-1,2,3,4_1")! )
            }
            
        case .deadBall:
            if noOutNoRunner {
                return ("死球", "デッドボール\n無死1塁", UIImage(named: "0-1")! )
            }else if oneOutNoRunner{
                return ("死球", "デッドボール\n1死1塁", UIImage(named: "1-1")! )
            }
            else if twoOutNoRunner{
                return ("死球", "デッドボール\n2死1塁", UIImage(named: "2-1")! )
            }
            else if noOutRunnerOnFirst{
                return ("死球", "デッドボール\n無死1,2塁", UIImage(named: "0-1,2")! )
            }
            else if oneOutRunnerOnFirst{
                return ("死球", "デッドボール\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if twoOutRunnerOnFirst{
                return ("死球", "デッドボール\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if noOutRunnerOnSecond{
                return ("死球", "デッドボール\n無死1,2塁", UIImage(named: "0-1,2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("死球", "デッドボール\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("死球", "デッドボール\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if noOutRunnerOnThird{
                return ("死球", "デッドボール\n無死1,3塁", UIImage(named: "0-1,3")! )
            }
            else if oneOutRunnerOnThird{
                return ("死球", "デッドボール\n1死1,3塁", UIImage(named: "1-1,3")! )
            }
            else if twoOutRunnerOnThird{
                return ("死球", "デッドボール\n2死1,3塁", UIImage(named: "2-1,3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("死球", "デッドボール\n無死満塁", UIImage(named: "0-1,2,3")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("死球", "デッドボール\n1死満塁", UIImage(named: "1-1,2,3")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("死球", "デッドボール\n2死満塁", UIImage(named: "2-1,2,3")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("死球", "デッドボール\n無死満塁", UIImage(named: "0-1,2,3")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("死球", "デッドボール\n1死満塁", UIImage(named: "1-1,2,3")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("死球", "デッドボール\n2死満塁", UIImage(named: "2-1,2,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("死球", "デッドボール\n無死満塁", UIImage(named: "0-1,2,3")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("死球", "デッドボール\n1死満塁", UIImage(named: "1-1,2,3")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("死球", "デッドボール\n2死満塁", UIImage(named: "2-1,2,3")! )
            }
            else if noOutFullBase{
                return ("死球", "デッドボール\n無死満塁", UIImage(named: "0-1,2,3,4_1")! )
            }
            else if oneOutFullBase{
                return ("死球", "デッドボール\n1死満塁", UIImage(named: "1-1,2,3,4_1")! )
            }
            else if twoOutFullBase{
                return ("死球", "デッドボール\n2死満塁", UIImage(named: "2-1,2,3,4_1")! )
            }
        default:
            return ("", "", UIImage(named: "")! )
        }
        //なんかエラーでるから仮置き
        return ("", "", UIImage(named: "")! )
    }
    
//Ohashi:*※※*＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    func childOptionTwo() -> (resultTitle: String,resultString: String, resultImage: UIImage){
        switch Situation.result!{
            
        case .pitcherFly:
            if oneOutNoRunner {
                return ("投直", "ピッチャーライナー\n２死走者なし", UIImage(named: "2-0")!)
            }else if twoOutNoRunner{
                return ("投直", "ピッチャーライナー\n３アウトチェンジ", UIImage(named: "3-0")!)
            }
            else if noOutNoRunner{
                return ("投直", "ピッチャーライナー\n1死走者なし", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("投直", "ピッチャーライナー\n1死1塁", UIImage(named: "1-1")!)
            }
            else if oneOutRunnerOnFirst{
                return ("投直", "ピッチャーライナー\n2死走者1塁", UIImage(named: "2-1")!)
            }
            else if twoOutRunnerOnFirst{
                return ("投直", "ピッチャーライナー\n3アウトチェンジ", UIImage(named: "3-1")!)
            }
            else if noOutRunnerOnSecond{
                return ("投直", "ピッチャーライナー\n1死2塁", UIImage(named: "1-2")!)
            }
            else if oneOutRunnerOnSecond{
                return ("投直", "ピッチャーライナー\n2死2塁", UIImage(named: "2-2")!)
            }
            else if twoOutRunnerOnSecond{
                return ("投直", "ピッチャーライナー\n3アウトチェンジ", UIImage(named: "3-2")!)
            }
            else if noOutRunnerOnThird{
                return ("投直", "ピッチャーライナー\n1死3塁", UIImage(named: "1-3")!)
            }
            else if oneOutRunnerOnThird{
                return ("投直", "ピッチャーライナー\n2死3塁", UIImage(named: "2-3")!)
            }
            else if twoOutRunnerOnThird{
                return ("投直", "ピッチャーライナー\n3アウトチェンジ", UIImage(named: "3-3")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("投直", "ピッチャーライナー\n1死走者1,2塁", UIImage(named: "1-1,2")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("投直", "ピッチャーライナー\n2死1,2塁", UIImage(named: "2-1,2")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("投直", "ピッチャーライナー\n3アウトチェンジ", UIImage(named: "3-1,2")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("投直", "ピッチャーライナー\n1死1,3塁", UIImage(named: "1-1,3")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("投直", "ピッチャーライナー\n2死1,３塁", UIImage(named: "2-1,3")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("投直", "ピッチャーライナー\n3アウトチェンジ", UIImage(named: "3-1,3")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("投直", "ピッチャーライナー\n1死2,3塁", UIImage(named: "1-2,3")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("投直", "ピッチャーライナー\n2死2,3塁", UIImage(named: "2-2,3")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("投直", "ピッチャーライナー\n3アウトチェンジ", UIImage(named: "3-2,3")!)
            }
            else if noOutFullBase{
                return ("投直", "ピッチャーライナー\n1死満塁", UIImage(named: "1-1,2,3")!)
            }
            else if oneOutFullBase{
                return ("投直", "ピッチャーライナー\n2死満塁", UIImage(named: "2-1,2,3")!)
            }
            else if twoOutFullBase{
                return ("投直", "ピッチャーライナー\n3アウトチェンジ", UIImage(named: "3-1,2,3")!)
            }
        case .catcherFly:
            return ("", "", UIImage(named: "")! )
            
        case .firstFly:
            if noOutNoRunner {
                return ("一直", "ファーストライナー\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("一直", "ファーストライナー\n2死走者なし", UIImage(named: "1-0")! )
            }
            else if twoOutNoRunner{
                return ("一直", "ファーストライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("一直", "ファーストライナー\n1死1塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("一直", "ファーストライナー\n2死1塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnFirst{
                return ("一直", "ファーストライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("一直", "ファーストライナー\n1死2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnSecond{
                return ("一直", "ファーストライナー\n2死2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnSecond{
                return ("一直", "ファーストライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnThird{
                return ("一直", "ファーストライナー\n1死3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnThird{
                return ("一直", "ファーストライナー\n2死3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnThird{
                return ("一直", "ファーストライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("一直", "ファーストライナー\n1死1,2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("一直", "ファーストライナー\n2死1,2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("一直", "ファーストライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("一直", "ファーストライナー\n1死1,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("一直", "ファーストライナー\n2死1,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("一直", "ファーストライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("一直", "ファーストライナー\n1死2,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("一直", "ファーストライナー\n2死2,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("一直", "ファーストライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutFullBase{
                return ("一直", "ファーストライナー\n1死満塁", UIImage(named: "1-0")! )
            }
            else if oneOutFullBase{
                return ("一直", "ファーストライナー\n2死満塁", UIImage(named: "1-0")! )
            }
            else if twoOutFullBase{
                return ("一直", "ファーストライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            
        case .secondFly:
            if noOutNoRunner {
                return ("二直", "セカンドライナー\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("二直", "セカンドライナー\n2死走者なし", UIImage(named: "1-0")! )
            }
            else if twoOutNoRunner{
                return ("二直", "セカンドライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("二直", "セカンドライナー\n1死1塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("二直", "セカンドライナー\n2死1塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnFirst{
                return ("二直", "セカンドライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("二飛", "セカンドライナー\n1死2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnSecond{
                return ("二飛", "セカンドライナー\n2死2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnSecond{
                return ("二直", "セカンドライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnThird{
                return ("二直", "セカンドライナー\n1死3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnThird{
                return ("二直", "セカンドライナー\n2死3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnThird{
                return ("二直", "セカンドライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("二直", "セカンドライナー\n1死1,2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("二直", "セカンドライナー\n2死1,2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("二直", "セカンドライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("二直", "セカンドライナー\n1死1,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("二直", "セカンドライナー\n2死1,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("二直", "セカンドライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("二直", "セカンドライナー\n1死2,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("二直", "セカンドライナー\n2死2,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("二直", "セカンドライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutFullBase{
                return ("二直", "セカンドライナー\n1死満塁", UIImage(named: "1-0")! )
            }
            else if oneOutFullBase{
                return ("二直", "セカンドライナー\n2死満塁", UIImage(named: "1-0")! )
            }
            else if twoOutFullBase{
                return ("二直", "セカンドライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            
        case .thirdFly:
            if noOutNoRunner {
                return ("三直", "サードライナー\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("三直", "サードライナー\n2死走者なし", UIImage(named: "1-0")! )
            }
            else if twoOutNoRunner{
                return ("三直", "サードライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("三直", "サードライナー\n1死1,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("三直", "サードライナー\n2死1,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnFirst{
                return ("三直", "サードフライ\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("三直", "サードライナー\n1死2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnSecond{
                return ("三直", "サードライナー\n2死2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnSecond{
                return ("三直", "サードライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnThird{
                return ("三直", "サードライナー\n1死3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnThird{
                return ("三直", "サードライナー\n2死3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnThird{
                return ("三直", "サードライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("三直", "サードライナー\n1死1,2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("三直", "サードライナー\n2死1,2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("三直", "サードライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("三直", "サードライナー\n1死1,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("三直", "サードライナー\n2死1,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("三直", "サードライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("三直", "サードライナー\n1死2,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("三直", "サードライナー\n2死2,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("三直", "サードライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutFullBase{
                return ("三直", "サードライナー\n1死満塁", UIImage(named: "1-0")! )
            }
            else if oneOutFullBase{
                return ("三直", "サードライナー\n2死満塁", UIImage(named: "1-0")! )
            }
            else if twoOutFullBase{
                return ("三直", "サードライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            
        case .shortFly:
            if noOutNoRunner {
                return ("遊直", "ショートライナー\n一死なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("遊直", "ショートライナー\n2死走者なし", UIImage(named: "1-0")! )
            }
            else if twoOutNoRunner{
                return ("遊直", "ショートライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("遊直", "ショートライナー\n1死1塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnFirst{
                return ("遊直", "ショートライナー\n2死1塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnFirst{
                return ("遊飛", "ショートライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnSecond{
                return ("遊直", "ショートライナー\n1死2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnSecond{
                return ("遊直", "ショートライナー\n2死2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnSecond{
                return ("遊直", "ショートライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnerOnThird{
                return ("遊直", "ショートライナー\n1死3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnerOnThird{
                return ("遊直", "ショートライナー\n2死3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnerOnThird{
                return ("遊直", "ショートライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("遊直", "ショートライナー\n1死1,2塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("遊直", "ショートライナー\n2死1,2塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("遊直", "ショートライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("遊直", "ショートライナー\n1死1,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("遊直", "ショートライナー\n2死1,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("遊直", "ショートライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("遊直", "ショートライナー\n1死2,3塁", UIImage(named: "1-0")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("遊直", "ショートライナー\n2死2,3塁", UIImage(named: "1-0")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("遊直", "ショートライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
            else if noOutFullBase{
                return ("遊直", "ショートライナー\n1死満塁", UIImage(named: "1-0")! )
            }
            else if oneOutFullBase{
                return ("遊直", "ショートライナー\n2死満塁", UIImage(named: "1-0")! )
            }
            else if twoOutFullBase{
                return ("遊直", "ショートライナー\n3アウトチェンジ", UIImage(named: "1-0")! )
            }
        case .leftFly:
            if noOutNoRunner {
                return ("左直", "レフトライナー\n1死走者なし", UIImage(named: "1-0")!)
            }else if oneOutNoRunner{
                return ("左直", "レフトライナー\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("左直", "レフトライナー\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("左直", "レフトライナー\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return ("左直", "レフトライナー\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("左直", "レフトライナー\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("左直", "レフトライナー\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("左直", "レフトライナー\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("左直", "レフトライナー\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("左犠直", "ライナー、タッチアップ\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("左犠直", "ライナー、タッチアップ\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("左直", "レフトライナー\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("左直", "レフトライナー\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("左直", "レフトライナー\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("左直", "レフトライナー\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("左犠直", "ライナー、タッチアップ\n1死1塁\n1点", UIImage(named: "1-1,4_1")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("左犠直", "ライナー、タッチアップ\n2死1塁\n1点", UIImage(named: "2-1,4_1")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("左直", "レフトライナー\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("左犠直", "ライナー、タッチアップ\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("左犠直", "ライナー、タッチアップ\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("左直", "レフトライナー\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("左犠直", "ライナー、タッチアップ\n1死1,2塁\n1点", UIImage(named: "1-1,2,4_1")! )
            }
            else if oneOutFullBase{
                return ("左犠直", "ライナー、タッチアップ\n2死1,2塁\n1点", UIImage(named: "2-1,2,4_1")! )
            }
            else if twoOutFullBase{
                return ("左直", "レフトライナー\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        case .centerFly:
            if noOutNoRunner {
                return ("中直", "センターライナー\n一死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("中直", "センターライナー\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("中直", "センターライナー\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("中直", "センターライナー\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return("中直", "センターライナー\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("中直", "センターライナー\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("中直", "センターライナー\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("中直", "センターライナー\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("中直", "センターライナー\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("中犠直", "ライナー、タッチアップ\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("中犠直", "ライナー、タッチアップ\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("中直", "センターライナー\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("中直", "センターライナー\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("中直", "センターライナー\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("中飛", "センターライナー\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("中犠直", "ライナー、タッチアップ\n1死1塁\n1点", UIImage(named: "1-1,4_1")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("中犠直", "ライナー、タッチアップ\n2死1塁\n1点", UIImage(named: "2-1,4_1")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("中直", "センターライナー\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                return ("中犠直", "ライナー、タッチアップ\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("中犠直", "ライナー、タッチアップ\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("中直", "センターライナー\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                return ("中犠直", "ライナー、タッチアップ\n1死1,2塁", UIImage(named: "1-1,2,4_1")! )
            }
            else if oneOutFullBase{
                return ("中犠直", "ライナー、タッチアップ\n2死1,2塁", UIImage(named: "2-1,2,4_1")! )
            }
            else if twoOutFullBase{
                return ("中直", "センターライナー\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        case .rightFly:
            if noOutNoRunner {
                return ("右直", "ライトライナー\n1死走者なし", UIImage(named: "1-0")! )
            }else if oneOutNoRunner{
                return ("右直", "ライトライナー\n2死走者なし", UIImage(named: "2-0")! )
            }
            else if twoOutNoRunner{
                return ("右直", "ライトライナー\n3アウトチェンジ", UIImage(named: "3-0")! )
            }
            else if noOutRunnerOnFirst{
                return ("右直", "ライトライナー\n1死1塁", UIImage(named: "1-1")! )
            }
            else if oneOutRunnerOnFirst{
                return ("右直", "ライトライナー\n2死1塁", UIImage(named: "2-1")! )
            }
            else if twoOutRunnerOnFirst{
                return ("右直", "ライトライナー\n3アウトチェンジ", UIImage(named: "3-1")! )
            }
            else if noOutRunnerOnSecond{
                return ("右直", "ライトライナー\n1死2塁", UIImage(named: "1-2")! )
            }
            else if oneOutRunnerOnSecond{
                return ("右直", "ライトライナー\n2死2塁", UIImage(named: "2-2")! )
            }
            else if twoOutRunnerOnSecond{
                return ("右直", "ライトライナー\n3アウトチェンジ", UIImage(named: "3-2")! )
            }
            else if noOutRunnerOnThird{
                return ("右犠直", "ライナー、タッチアップ\n1死走者なし\n1点", UIImage(named: "1-4_1")! )
            }
            else if oneOutRunnerOnThird{
                return ("右犠直", "ライナー、タッチアップ\n2死走者なし\n1点", UIImage(named: "2-4_1")! )
            }
            else if twoOutRunnerOnThird{
                return ("右直", "ライトライナー\n3アウトチェンジ", UIImage(named: "3-3")! )
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("右直", "ライトライナー\n1死1,2塁", UIImage(named: "1-1,2")! )
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("右直", "ライトライナー\n2死1,2塁", UIImage(named: "2-1,2")! )
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("右直", "ライトライナー\n3アウトチェンジ", UIImage(named: "3-1,2")! )
            }
            else if noOutRunnersOnFirstAndThird{
                return ("右直", "ライナー、タッチアップ\n1死1塁\n1点", UIImage(named: "1-1,4_1")! )
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("右犠直", "ライナー、タッチアップ\n2死1塁\n1点", UIImage(named: "2-1,4_1")! )
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("右直", "ライトライナー\n3アウトチェンジ", UIImage(named: "3-1,3")! )
            }
            else if noOutRunnersOnSecondAndThird{
                //oohashi:23塁のがいいか？
                return ("右犠直", "ライナー、タッチアップ\n1死2塁\n1点", UIImage(named: "1-2,4_1")! )
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("右犠直", "ライナー、タッチアップ\n2死2塁\n1点", UIImage(named: "2-2,4_1")! )
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("右直", "ライトライナー\n3アウトチェンジ", UIImage(named: "3-2,3")! )
            }
            else if noOutFullBase{
                //13塁のがいいか
                return ("右犠直", "ライナー、タッチアップ\n1死1,2塁\n1点", UIImage(named: "1-1,2,4_1")! )
            }
            else if oneOutFullBase{
                return ("右犠直", "ライナー、タッチアップ\n2死1,2塁\n1点", UIImage(named: "2-1,2,4_1")! )
            }
            else if twoOutFullBase{
                return ("右直", "ライトライナー\n3アウトチェンジ", UIImage(named: "3-1,2,3")! )
            }
        case .struckOutSwinging:
            return ("", "", UIImage(named: "")! )
        case .missedStruckOut:
            return ("", "", UIImage(named: "")! )
        case .leftIntermediateHit:
            return ("", "", UIImage(named: "")! )
        case .leftSingleHit:
            return ("", "", UIImage(named: "")! )
        case .rightIntermediateHit:
            return ("", "", UIImage(named: "")! )
        case .pitcherOrCatcherHit:
            if noOutNoRunner {
                return ("捕前安", "キャッチャー内野安打\n無死1塁", UIImage(named: "0-1")!)
            }else if oneOutNoRunner{
                return ("捕前安", "キャッチャー内野安打\n1死1塁", UIImage(named: "1-1")!)
            }
            else if twoOutNoRunner{
                return ("捕前安", "キャッチャー内野安打\n2死1塁", UIImage(named: "2-1")!)
            }
            else if noOutRunnerOnFirst{
                return ("捕前安", "キャッチャー内野安打\n無死1,2塁", UIImage(named: "0-1,2")!)
            }
            else if oneOutRunnerOnFirst{
                return ("捕前安", "キャッチャー内野安打\n1死1,2塁", UIImage(named: "1-1,2")!)
            }
            else if twoOutRunnerOnFirst{
                return ("捕前安", "キャッチャー内野安打\n2死1,2塁", UIImage(named: "2-1,2")!)
            }
            else if noOutRunnerOnSecond{
                return ("捕前安", "キャッチャー内野安打\n無死1,3塁", UIImage(named: "0-1,3")!)
            }
            else if oneOutRunnerOnSecond{
                return ( "捕前安", "キャッチャー内野安打\n1死1,3塁", UIImage(named: "1-1,3")!)
            }
            else if twoOutRunnerOnSecond{
                return ("捕前安", "キャッチャー内野安打\n2死1,3塁", UIImage(named: "2-1,3")!)
                
            }
            else if noOutRunnerOnThird{
                return ("捕前安", "キャッチャー内野安打\n無死1塁", UIImage(named: "0-1,4_1")!)
            }
            else if oneOutRunnerOnThird{
                return ("捕前安", "キャッチャー内野安打\n1死1塁", UIImage(named: "1-1,4_1")!)
            }
            else if twoOutRunnerOnThird{
                return ("捕前安", "キャッチャー内野安打\n2死1塁", UIImage(named: "2-1,4_1")!)
            }
            else if noOutRunnersOnFirstAndSecond{
                return ("捕前安", "キャッチャー内野安打\n無死満塁", UIImage(named: "0-1,2,3")!)
            }
            else if oneOutRunnersOnFirstAndSecond{
                return ("捕前安", "キャッチャー内野安打\n1死満塁", UIImage(named: "1-1,2,3")!)
            }
            else if twoOutRunnersOnFirstAndSecond{
                return ("捕前安", "キャッチャー内野安打\n2死満塁", UIImage(named: "2-1,2,3")!)
            }
            else if noOutRunnersOnFirstAndThird{
                return ("捕前安", "キャッチャー内野安打\n無死1,2塁", UIImage(named: "0-1,2,4_1")!)
            }
            else if oneOutRunnersOnFirstAndThird{
                return ("捕前安", "キャッチャー内野安打\n1死1,2塁", UIImage(named: "1-1,2,4_1")!)
            }
            else if twoOutRunnersOnFirstAndThird{
                return ("捕前安", "キャッチャー内野安打\n2死1,2塁", UIImage(named: "2-1,2,4_1")!)
            }
            else if noOutRunnersOnSecondAndThird{
                return ("捕前安", "キャッチャー内野安打\n無死1,3塁", UIImage(named: "0-1,3,4_1")!)
            }
            else if oneOutRunnersOnSecondAndThird{
                return ("捕前安", "キャッチャー内野安打\n1死1,3塁", UIImage(named: "1-1,3,4_1")!)
            }
            else if twoOutRunnersOnSecondAndThird{
                return ("捕前安", "キャッチャー内野安打\n2死1,3塁", UIImage(named: "2-1,3,4_1")!)
            }
            else if noOutFullBase{
                return ("捕前安", "キャッチャー内野安打\n無死満塁", UIImage(named: "0-1,2,3,4_1")!)
            }
            else if oneOutFullBase{
                return ("捕前安", "キャッチャー内野安打\n1死満塁", UIImage(named: "1-1,2,3,4_1")!)
            }
            else if twoOutFullBase{
                return ("捕前安", "キャッチャー内野安打\n2死満塁", UIImage(named: "2-1,2,3,4_1")!)
                
            }
        case .firstHit:
            return ("", "", UIImage(named: "")! )
        case .secondHit:
            return ("", "", UIImage(named: "")! )
        case .thirdHit:
            return ("", "", UIImage(named: "")! )
        case .shortHit:
            return ("", "", UIImage(named: "")! )
        case .centerSingleHit:
            return ("", "", UIImage(named: "")! )
        case .rightSingleHit:
            return ("", "", UIImage(named: "")! )
        case .leftOverHit:
            return ("", "", UIImage(named: "")! )
        case .centerOverHit:
            return ("", "", UIImage(named: "")! )
        case .rightOverHit:
            return ("", "", UIImage(named: "")! )
        case .thirdBaseLineHit:
            return ("", "", UIImage(named: "")! )
        case .firstBaseLineHit:
            return ("", "", UIImage(named: "")! )
        case .fourBall:
            return ("", "", UIImage(named: "")! )
        case .deadBall:
            return ("", "", UIImage(named: "")! )
        case .pitcherGoroThrowToHome:
            return ("", "", UIImage(named: "")! )
        case .pitcherGoroThrowToFirst:
            return ("", "", UIImage(named: "")! )
        case .pitcherGorothrowToSecond:
            return ("", "", UIImage(named: "")! )
        case .pitcherGoroThrowToThird:
            return ("", "", UIImage(named: "")! )
        case .catcherGoroThrowToHome:
            return ("", "", UIImage(named: "")! )
        case .catcherGoroThrowToFirst:
            return ("", "", UIImage(named: "")! )
        case .catcherGoroThrowToSecond:
            return ("", "", UIImage(named: "")! )
        case .catcherGoroThrowToThird:
            return ("", "", UIImage(named: "")! )
        case .firstGoroThrowToHome:
            return ("", "", UIImage(named: "")! )
        case .firstGoroThrowToFirst:
            return ("", "", UIImage(named: "")! )
        case .firstGoroThrowToSecond:
            return ("", "", UIImage(named: "")! )
        case .firstGoroThrowToThird:
            return ("", "", UIImage(named: "")! )
        case .secondGoroThrowToHome:
            return ("", "", UIImage(named: "")! )
        case .secondGoroThrowToFirst:
            return ("", "", UIImage(named: "")! )
        case .secondGoroThrowToSecond:
            return ("", "", UIImage(named: "")! )
        case .secondGoroThrowToThird:
            return ("", "", UIImage(named: "")! )
        case .thirdGoroThrowToHome:
            return ("", "", UIImage(named: "")! )
        case .thirdGoroThrowToFirst:
            return ("", "", UIImage(named: "")! )
        case .thirdGoroThrowToSecond:
            return ("", "", UIImage(named: "")! )
        case .thirdGoroThrowToThird:
            return ("", "", UIImage(named: "")! )
        case .shortGoroThrowToHome:
            return ("", "", UIImage(named: "")! )
        case .shortGoroThrowToFirst:
            return ("", "", UIImage(named: "")! )
        case .shortGoroThrowToSecond:
            return ("", "", UIImage(named: "")! )
        case .shortGoroThrowToThird:
            return ("", "", UIImage(named: "")! )
        }
        
        //なんかエラーでるから仮置き
        return ("", "", UIImage(named: "")! )
    }
    //Ohashi:＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    //Ohashi:フライはファウルフライで
    func childOptionThree() -> String{
        switch Situation.result!{
            
        case .pitcherFly:
            if oneOutNoRunner{
                return "ピッチャーエラー/n１死走者２塁"
            }
            else if twoOutNoRunner{
                return ""
            }
        case .catcherFly:
            return ""
        case .firstFly:
            return ""
        case .secondFly:
            return ""
        case .thirdFly:
            return ""
        case .shortFly:
            return ""
        case .leftFly:
            return ""
        case .centerFly:
            return ""
        case .rightFly:
            return ""
        case .struckOutSwinging:
            return ""
        case .missedStruckOut:
            return ""
        case .leftIntermediateHit:
            return ""
        case .leftSingleHit:
            return ""
        case .rightIntermediateHit:
            return ""
        case .pitcherOrCatcherHit:
            return ""
        case .firstHit:
            return ""
        case .secondHit:
            return ""
        case .thirdHit:
            return ""
        case .shortHit:
            return ""
        case .centerSingleHit:
            return ""
        case .rightSingleHit:
            return ""
        case .leftOverHit:
            return ""
        case .centerOverHit:
            return ""
        case .rightOverHit:
            return ""
        case .thirdBaseLineHit:
            return ""
        case .firstBaseLineHit:
            return ""
        case .fourBall:
            return ""
        case .deadBall:
            return ""
        case .pitcherGoroThrowToHome:
            return ""
        case .pitcherGoroThrowToFirst:
            return ""
        case .pitcherGorothrowToSecond:
            return ""
        case .pitcherGoroThrowToThird:
            return ""
        case .catcherGoroThrowToHome:
            return ""
        case .catcherGoroThrowToFirst:
            return ""
        case .catcherGoroThrowToSecond:
            return ""
        case .catcherGoroThrowToThird:
            return ""
        case .firstGoroThrowToHome:
            return ""
        case .firstGoroThrowToFirst:
            return ""
        case .firstGoroThrowToSecond:
            return ""
        case .firstGoroThrowToThird:
            return ""
        case .secondGoroThrowToHome:
            return ""
        case .secondGoroThrowToFirst:
            return ""
        case .secondGoroThrowToSecond:
            return ""
        case .secondGoroThrowToThird:
            return ""
        case .thirdGoroThrowToHome:
            return ""
        case .thirdGoroThrowToFirst:
            return ""
        case .thirdGoroThrowToSecond:
            return ""
        case .thirdGoroThrowToThird:
            return ""
        case .shortGoroThrowToHome:
            return ""
        case .shortGoroThrowToFirst:
            return ""
        case .shortGoroThrowToSecond:
            return ""
        case .shortGoroThrowToThird:
            return ""
        }
        
        //なんかエラーでるから仮置き
        return ""
    }
    
    //ボタンを押したときの関数3つ
    //oohashi: 得点入った時アニメーション処理

    
    func batterOut(){
        if Situation.topOrBottom == "Top"{
            if Situation.topBattingOrder == 8{
                Situation.topBattingOrder = 0
            }else{
                Situation.topBattingOrder += 1
            }
            if Situation.outCounts == 2{
                Situation.outCounts = 0
                Situation.topOrBottom = "Bottom"
            }else{
                Situation.outCounts += 1
            }
        }else{
            if Situation.bottomBattingOrder == 8{
                Situation.bottomBattingOrder = 0
            }else{
                Situation.bottomBattingOrder += 1
            }
            if Situation.outCounts == 2{
                Situation.outCounts = 0
                Situation.inning += 1
                Situation.topOrBottom = "top"
            }else{
                Situation.outCounts += 1
            }
        }
        Situation.strikeCounts = 0
        Situation.ballCounts = 0
    }
    
    func batterOnBaseSingle(){
        if Situation.topOrBottom == "Top"{
            if let thirdRunner = Situation.thirdRunner{
                Situation.topScore += 1
                //Ohashi:TODOサードランナーに得点処理
            }
            if let secondRunner = Situation.secondRunner{
                Situation.thirdRunner = secondRunner
            }
            if let firstRunner = Situation.firstRunner{
                Situation.secondRunner = firstRunner
            }
            
            let ranner:FIRPlayer = Situation.topPlayerArray[Situation.topBattingOrder]
            Situation.firstRunner = ranner
            if Situation.topBattingOrder == 8{
                Situation.topBattingOrder = 0
            }else{
                Situation.topBattingOrder += 1
            }
        }else{
            if let thirdRunner = Situation.thirdRunner{
                Situation.bottomScore += 1
                //Ohashi:TODOサードランナーに得点処理
            }
            if let secondRunner = Situation.secondRunner{
                Situation.thirdRunner = secondRunner
            }
            if let firstRunner = Situation.firstRunner{
                Situation.secondRunner = firstRunner
            }
            
            let runner: FIRPlayer = Situation.bottomPlayerArray[Situation.bottomBattingOrder]
                        Situation.firstRunner = runner
            
            if Situation.bottomBattingOrder == 8{
                Situation.bottomBattingOrder = 0
            }else{
                Situation.bottomBattingOrder += 1
            }

        }
        Situation.strikeCounts = 0
        Situation.ballCounts = 0
    }
    
    func noRunner(){
        
    }
}
