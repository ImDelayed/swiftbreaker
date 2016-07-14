//
//  File.swift
//  SwiftBreaker
//
//  Created by Dan Porter on 7/11/16.
//  Copyright © 2016 Jake Januzelli. All rights reserved.
//

import Foundation
import SpriteKit

class Wall {
    var bricks = [Brick]()
    var xPositionBrick = 0
    var xPosition = 0
    init(numberOfBricks:Int, let scene:SKScene){
        for _ in 0...numberOfBricks - 1 {
            xPositionBrick += 1
            xPosition = (320 - xPositionBrick * 40) - (xPositionBrick * 5) + 5
            let currentBrick = Brick(atLocation: CGPoint(x: xPosition, y: 224), scene:scene)
            let currentBrick2 = Brick(atLocation: CGPoint(x: xPosition, y: 238), scene:scene)
            let currentBrick3 = Brick(atLocation: CGPoint(x: xPosition, y: 252), scene:scene)
            let currentBrick4 = Brick(atLocation: CGPoint(x: xPosition, y: 266), scene:scene)
            print("WALL")
            bricks.append(currentBrick)
            bricks.append(currentBrick2)
            bricks.append(currentBrick3)
            bricks.append(currentBrick4)
    }
    
    
}
}