//
//  Bricks.swift
//  SwiftBreaker
//
//  Created by Dan Porter on 7/11/16.
//  Copyright © 2016 Jake Januzelli. All rights reserved.
//

import Foundation
import SpriteKit

    class Brick {
        var sprite:SKShapeNode
    
        init(let atLocation:CGPoint, let scene:SKScene){
            let location = atLocation
  
            sprite = SKShapeNode(rectOfSize: CGSize(width: 40, height: 10))
            sprite.position = location
            sprite.lineWidth = 0
            sprite.fillColor = SKColor(colorLiteralRed: 0/255, green: 0/255, blue: 200/255, alpha: 1.0)
            sprite.strokeColor = SKColor.clearColor()
            scene.addChild(sprite)
//            sprite.physicsBody! = SKPhysicsBody(rectOfSize: CGSize(width: 40, height: 10))
//            sprite.physicsBody!.dynamic = true
}

//        func randomEffects() {
//            if oneToTen == 1 {
//                GameScene.paddle!.size = CGSize(width: 120, height: 10)
//                print("Large Paddle")
//                SKAction [waitForDuration, 3]
//                GaneScene.paddle!.size = CGSize(width: 80, height: 10)
//                
//            }
//            else if oneToTen == 2 {
//                GameScene.paddle!.size = CGSize(width: 40, height: 10)
//                print("Small Paddle")
//                SKAction [waitForDuration, 3]
//                GaneScene.paddle!.size = CGSize(width: 80, height: 10)
//            }
//            else if oneToTen == 3 {
//                GameScene.xScale = 1.2
//                GameScene.yScale = 1.2
//                GameScene.ball!.circleOfRadius = 6
//                print("Large Ball")
//            }
//            else if oneToTen == 4 {
//                GameScene.xScale = 0.2
//                GameScene.yScale = 0.2
//                GameScene.ball!.circleOfRadius = 1
//                print("Small Ball")
//              }
//              else if oneToTen == 5 {
//                  GameScene.paddle2.size = CGSize(width: 40, height: 10)
//              }

}

