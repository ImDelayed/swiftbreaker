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
            let ballCategory:UInt32 = 0x1 << 0              // 000000001
            let brickCategory:UInt32 = 0x1 << 2             // 000000100
  
            sprite = SKShapeNode(rectOfSize: CGSize(width: 40, height: 10))
            sprite.position = location
            sprite.lineWidth = 0
            sprite.name = "Brick"
            sprite.fillColor = SKColor(colorLiteralRed: 0/255, green: 0/255, blue: 200/255, alpha: 1.0)
            sprite.strokeColor = SKColor.clearColor()
            sprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 40, height: 10))
            sprite.physicsBody!.friction = 0
            sprite.physicsBody!.restitution = 1
            sprite.physicsBody!.dynamic = false
            sprite.physicsBody!.usesPreciseCollisionDetection = true
            sprite.physicsBody!.categoryBitMask = brickCategory
            sprite.physicsBody!.contactTestBitMask = ballCategory
            scene.addChild(sprite)
        }
        
}

