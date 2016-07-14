//
//  File.swift
//  SwiftBreaker
//
//  Created by Alex Saltstein on 7/12/16.
//  Copyright © 2016 Jake Januzelli. All rights reserved.
//

import Foundation
import SpriteKit

class Ball{
    
    init(let name:String, let scale:CGFloat, let scene:SKScene, let startY:CGFloat, let color:UIColor){
        let sprite = SKShapeNode(circleOfRadius: scale*3)
        let ballCategory:UInt32 = 0x1 << 0              // 000000001
        let brickCategory:UInt32 = 0x1 << 2             // 000000100
        let paddleCategory:UInt32 = 0x1 << 3            // 000001000
        
        sprite.position = CGPoint(x: CGRectGetMidX(scene.frame), y: startY)
        sprite.name = name
        sprite.xScale = scale
        sprite.yScale = scale
        sprite.fillColor = color
        sprite.strokeColor = UIColor.clearColor()
        
        // these properties are neccesary for the ball to go forever
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: 3)
        sprite.physicsBody!.mass = 1
        sprite.physicsBody!.friction = 0
        sprite.physicsBody!.restitution = 1
        sprite.physicsBody!.linearDamping = 0
        sprite.physicsBody!.usesPreciseCollisionDetection = true
        sprite.physicsBody!.dynamic = true
        sprite.physicsBody!.categoryBitMask = ballCategory
        sprite.physicsBody!.contactTestBitMask = brickCategory
        
        scene.addChild(sprite)
    }
}