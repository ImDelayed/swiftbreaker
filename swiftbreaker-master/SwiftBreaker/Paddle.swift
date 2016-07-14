//
//  File.swift
//  SwiftBreaker
//
//  Created by Alex Saltstein on 7/12/16.
//  Copyright © 2016 Jake Januzelli. All rights reserved.
//

import Foundation
import SpriteKit

class Paddle{
    
    init(let name:String, let color:UIColor, let size:CGSize, let startY:CGFloat, let scene:SKScene){
        let sprite = SKSpriteNode(color: color, size: size)
        let paddleCategory:UInt32 = 0x1 << 3            // 000001000
        let ballCategory:UInt32 = 0x1 << 0              // 000000001
        
        sprite.position = CGPoint(x: CGRectGetMidX(scene.frame), y: startY)
        sprite.name = name
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        sprite.physicsBody!.categoryBitMask = paddleCategory
        sprite.physicsBody!.contactTestBitMask = ballCategory
        sprite.physicsBody!.usesPreciseCollisionDetection = true
        sprite.physicsBody!.friction = 0
        sprite.physicsBody!.restitution = 1
        sprite.physicsBody!.dynamic = false
        scene.addChild(sprite)
    }
}