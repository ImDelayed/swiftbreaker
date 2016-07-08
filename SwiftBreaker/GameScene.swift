//
//  GameScene.swift
//  SwiftBreaker
//
//  Created by Jake Januzelli on 6/9/14.
//  Copyright (c) 2014 Jake Januzelli. All rights reserved.
//

import SpriteKit

extension UIColor {
    class func randomColor() -> UIColor {
        let colors: Dictionary<UInt32, UIColor> = [
            1: UIColor.purpleColor(),
            2: UIColor.greenColor(),
            3: UIColor.redColor(),
            4: UIColor.orangeColor(),
            5: UIColor.grayColor(),
            6: UIColor.blueColor()
        ]
        let randomIndex = arc4random_uniform(6) + 1
        return colors[randomIndex]!
    }
}

class GameScene: SKScene {
    
    var gameGoing:Bool = false
    var debug:Bool = true
    
    override init(size: CGSize) {
        super.init(size: size)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        let edges = SKNode()
        edges.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        edges.physicsBody!.friction = 0
        edges.physicsBody!.restitution = 1
        addChild(edges)
        
        // I should probably make an extension with easy SKNode factory methods to get rid of this bloody boilerplate
        
        
        
        
        
        //        let brick = SKSpriteNode(color: UIColor.randomColor(), size: CGSize(width: 80, height: 10))
        //        brick.position = CGPoint(x: CGRectGetMidX(self.frame) , y: CGRectGetMidY(self.frame))
        //        brick.name = "Brick"
        //        brick.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 80, height: 10))
        //        brick.physicsBody!.friction = 0
        //        brick.physicsBody!.restitution = 1
        //        brick.physicsBody!.dynamic = false
        //        addChild(brick)
        
        let paddle = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 60, height: 10))
        paddle.position = CGPoint(x: CGRectGetMidX(self.frame), y: 10)
        paddle.name = "Paddle"
        paddle.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 60, height: 10))
        paddle.physicsBody!.friction = 0
        paddle.physicsBody!.restitution = 1
        paddle.physicsBody!.dynamic = false
        addChild(paddle)
        
        let paddle2 = SKSpriteNode(color: UIColor.greenColor(), size: CGSize(width: 60, height: 10))
        paddle2.position = CGPoint(x: CGRectGetMidX(self.frame), y: 470)
        paddle2.name = "Paddle2"
        paddle2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 60, height: 10))
        paddle2.physicsBody!.friction = 0
        paddle2.physicsBody!.restitution = 1
        paddle2.physicsBody!.dynamic = false
        addChild(paddle2)
        
        let ball = SKSpriteNode(imageNamed: "BallForBreaker")
        ball.position = CGPoint(x: CGRectGetMidX(self.frame), y: 20)
        ball.name = "Ball"
        //        ball.physicsBody.contactDelegate = ball
        
        // these properties are neccesary for the ball to go forever
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        ball.physicsBody!.mass = 1
        ball.physicsBody!.friction = 0
        ball.physicsBody!.restitution = 1
        ball.physicsBody!.linearDamping = 0
        ball.physicsBody!.usesPreciseCollisionDetection = true
        
        addChild(ball)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var lastTouch: CGPoint? = nil
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //        let touch = touches.first
        //        let touchLocation = touch?.locationInNode(self)
        //        lastTouch = touchLocation
        //
        let paddle = childNodeWithName("Paddle")
        /* Called when a touch begins */
        let touch = touches.first
        if let touchLocation = touch?.locationInNode(self) {
            if (touchLocation.x < paddle!.position.x && touchLocation.y < 240 && gameGoing == true) {
                paddle?.physicsBody?.dynamic = true
                paddle?.physicsBody?.velocity = CGVectorMake(-100.0,0)
                print("left")
                
                //                paddle!.physicsBody!.xVelocity = -10
            } else if (touchLocation.y < 240 && gameGoing == true){
                paddle?.physicsBody?.velocity = CGVectorMake(100.0,0)
                print("right")
                //paddle!.physicsBody!.xVelocity = 10
            }
        }
        let paddle2 = childNodeWithName("Paddle2")
        /* Called when a touch begins */
        if let touchLocation = touch?.locationInNode(self) {
            if (touchLocation.x < paddle2!.position.x && touchLocation.y > 240 && gameGoing == true) {
                paddle2?.physicsBody?.dynamic = true
                paddle2?.physicsBody?.velocity = CGVectorMake(-100.0,0)
                print("right2")
                
                //                paddle!.physicsBody!.xVelocity = -10
            } else if (touchLocation.y > 240 && gameGoing == true){
                paddle2?.physicsBody?.velocity = CGVectorMake(100.0,0)
                print("left2")
                //paddle!.physicsBody!.xVelocity = 10
            }
        }
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        Death()
    }
    //        for touch in touchesBegan(touches: NSSet, withEvent: UIEvent!) {
    //            let paddle = childNodeWithName("Paddle")
    //            /* Called when a touch begins */
    //            let touch = touches.anyObject() as! UITouch
    //            let touchLocation = touch.locationInNode(self)
    //
    //            if (touchLocation.x < paddle!.position.x) {
    //                paddle!.physicsBody!.xVelocity = -10
    //            } else {
    //                paddle!.physicsBody!.xVelocity = 10
    //            }
    //        }
    //    }
    
    
    
    
    
    func Death() {
        let ball = childNodeWithName("Ball")
        
        if (ball!.position.y < 10 || ball!.position.y > 470 && gameGoing == true) {
            print("death")
            ball!.physicsBody!.applyImpulse(CGVector(dx: 190, dy: 190))
            gameGoing = false
        }
        
    }
    //    //code runs if swipe right is registered
    //    func swipedRight(sender:UISwipeGestureRecognizer){
    //        let paddle = childNodeWithName("Paddle")
    //        if debug{
    //            print("swiped right")
    //        }
    //        paddle!.position = CGPoint(x: paddle!.position.x + 10, y: 10)
    //    }
    //
    //
    ////code runs if swipe left is registered
    //func swipedLeft(sender:UISwipeGestureRecognizer){
    //    let paddle = childNodeWithName("Paddle")
    //    if debug{
    //        print("swiped left")
    //    }
    //    paddle!.position = CGPoint(x: paddle!.position.x - 10, y: 10)
    //}
    
    func start() {
        let ball = childNodeWithName("Ball")
        ball!.position = CGPoint(x: CGRectGetMidX(self.frame), y: 20)
        ball!.physicsBody!.applyImpulse(CGVector(dx: 200, dy: 200))
        gameGoing = true
    }
    //   func didBeginContact
}
