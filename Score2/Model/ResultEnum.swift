
import UIKit

enum ResultEnum: Int{
    
    case pitcherFly = 1
    case catcherFly
    case firstFly
    case secondFly
    case thirdFly
    case shortFly
    case leftFly
    case centerFly
    case rightFly
    
    case pitcherGoroThrowToFirst
    case pitcherGorothrowToSecond
    case pitcherGoroThrowToThird
    case pitcherGoroThrowToHome
    
    case catcherGoroThrowToFirst
    case catcherGoroThrowToSecond
    case catcherGoroThrowToThird
    case catcherGoroThrowToHome
    
    case firstGoroThrowToFirst
    case firstGoroThrowToSecond
    case firstGoroThrowToThird
    case firstGoroThrowToHome
    
    case secondGoroThrowToFirst
    case secondGoroThrowToSecond
    case secondGoroThrowToThird
    case secondGoroThrowToHome
    
    case thirdGoroThrowToFirst
    case thirdGoroThrowToSecond
    case thirdGoroThrowToThird
    case thirdGoroThrowToHome
    
    case shortGoroThrowToFirst
    case shortGoroThrowToSecond
    case shortGoroThrowToThird
    case shortGoroThrowToHome
    
    case struckOutSwinging
    case missedStruckOut
    //    //oohashi:外野ゴロヒットとライナーヒットで場合分け
    case pitcherOrCatcherHit //ohashi:ボタン一つで投手と捕手
    case firstHit
    case secondHit
    case thirdHit
    case shortHit
    case leftSingleHit
    case centerSingleHit
    case rightSingleHit
    case leftOverHit
    case centerOverHit
    case rightOverHit
    case thirdBaseLineHit
    case firstBaseLineHit
    case leftIntermediateHit  //左中間
    case rightIntermediateHit //右中間
    case fourBall
    case deadBall
}



