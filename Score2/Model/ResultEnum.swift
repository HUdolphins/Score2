
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
    case pitcherGoro
    case struckOutSwinging
    case missedStruckOut
    //    case pitcherGoroThrowToHome
    //    case pithergoroThrowToFirst
    //    case pitcherGorothrowToSecond
    //    case pitcherGoroThrowToThird
    //    case catcherGoroThrowToHome
    //    case catcherGoroThrowToFirst
    //    case catcherGoroThrowToSecond
    //    case catcherGoroThrowToThird
    //    case firstGoroThrowToHome
    //    case firstGoroThrowToFirst
    //    case firstGoroThrowToSecond
    //    case firstGoroThrowToThird
    //    case secondGoroThrowToHome
    //    case secondGoroThrowToFirst
    //    case secondGoroThrowToSecond
    //    case secondGoroThrowToThird
    //    case thirdGoroThrowToHome
    //    case thirdGoroThrowToFirst
    //    case thirdGoroThrowToSecond
    //    case thirdGoroThrowToThird
    //    case shortGoroThrowToHome
    //    case shortGoroThrowToFirst
    //    case shortGoroThrowToSecond
    //    case shortGoroThrowToThird
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



