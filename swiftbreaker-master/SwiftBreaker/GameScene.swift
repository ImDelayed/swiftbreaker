//
//  GameScene.swift
//  SwiftBreaker
//
//  Created by Jake Januzelli on 6/9/14.
//  Copyright (c) 2014 Jake Januzelli. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var firstWall:Wall = Wall(numberOfBricks:6, scene:SKScene())
    var gameGoing:Bool = false
    var debug:Bool = true
    var withinNode1:Bool = false
    var withinNode2:Bool = false
    var p1Score:Int = 0
    var p2Score:Int = 0
    var p1Bricks:Int = 0
    var p2Bricks:Int = 0
    
    let winnerLabel = SKLabelNode(text: "")
    let p1ScoreLabel = SKLabelNode(text: "")
    let p2ScoreLabel = SKLabelNode(text: "")
    
    let ballCategory:UInt32 = 0x1 << 0              // 000000001
    let bottomCategory:UInt32 = 0x1 << 1            // 000000010
    let brickCategory:UInt32 = 0x1 << 2             // 000000100
    let paddleCategory:UInt32 = 0x1 << 3            // 000001000
    
    var playerWin = 0 //0 for no winner; 1 for player1; 2 for player2;
    
    override init(size: CGSize) {
        super.init(size: size)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        winnerLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)/2)
        winnerLabel.setScale(0)
        self.addChild(winnerLabel)
        
        p1ScoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)*1.75)
        p1ScoreLabel.setScale(0)
        p1ScoreLabel.fontSize = 20
        self.addChild(p1ScoreLabel)
        
        p2ScoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)*1.5)
        p2ScoreLabel.setScale(0)
        p2ScoreLabel.fontSize = 20
        self.addChild(p2ScoreLabel)
        
        let edges = SKNode()
        edges.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        edges.physicsBody!.friction = 0
        edges.physicsBody!.restitution = 1
        addChild(edges)
        
        let startButton = SKLabelNode(text: "Start")
        startButton.name = "startButton"
        startButton.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(startButton)
        
        _ = Paddle(name: "Paddle", color: UIColor.redColor(), size: CGSize(width: 80, height: 10), startY: 10, scene: self)
        _ = Paddle(name: "Paddle2", color: UIColor.greenColor(), size: CGSize(width: 800, height: 10), startY: 460, scene: self)
        
        _ = Ball(name: "Ball", scale: 1.6, scene: self, startY: 15, color: UIColor.redColor())
        _ = Ball(name: "Ball2", scale: 1.6, scene: self, startY: 455, color: UIColor.greenColor())
    }
    
    //dont remove
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let paddle = childNodeWithName("Paddle")
        let paddle2 = childNodeWithName("Paddle2")
        let startButton = childNodeWithName("startButton")
        for touch in touches{
            let location = touch.locationInNode(self)
            if paddle!.containsPoint(location){
                print("touched inside paddle 1")
                withinNode1 = true
            }
            if paddle2!.containsPoint(location){
                print("touched inside paddle 2")
                withinNode2 = true
            }
            if startButton!.containsPoint(location){
                if debug{print("Start")}
                start()
            }
        }
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let paddle = childNodeWithName("Paddle")
        let paddle2 = childNodeWithName("Paddle2")
        for touch in touches{
            let location = touch.locationInNode(self)
            if withinNode1{
                paddle!.position.x = location.x
            }
            if withinNode2{
                paddle2!.position.x = location.x
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
            if withinNode1{
                withinNode1 = false
            }
            if withinNode2{
                withinNode2 = false
            }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if gameGoing{
                Death()}
    }
    
    func Death() {
        let ball = childNodeWithName("Ball")
        let ball2 = childNodeWithName("Ball2")
        
       if (ball!.position.y < 10 || ball!.position.y > 470 || ball2!.position.y < 10 || ball2!.position.y > 470 && gameGoing == true) {
        if ball!.position.y < 10 || ball2!.position.y < 10 {playerWin = 2}
        else {playerWin = 1}
        switch playerWin{
            case 1: if debug{print("player 1 win")}
                winnerLabel.text = "Player 1 WINS!"
                break
            case 2: if debug{print("player 2 win")}
                winnerLabel.text = "Player 2 WINS!"
                break
            default: print("something went wrong")
        }
        if debug{print("death")}
            gameGoing = false
        let ball = childNodeWithName("Ball")
        let ball2 = childNodeWithName("Ball2")
        ball!.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        ball2!.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        let startButton = childNodeWithName("startButton")
        startButton?.setScale(1)
        winnerLabel.setScale(1)
        for i in firstWall.bricks{
            i.sprite.removeFromParent()
        }
        firstWall.bricks.removeAll()
        }
        if !gameGoing{
            if playerWin == 1{p1Score += p1Bricks}
            if playerWin == 2{p2Score += p2Bricks}
            p1ScoreLabel.text = "Player 1 Score: " + "\(p1Score)" + " out of 100"
            p2ScoreLabel.text = "Player 2 Score: " + "\(p2Score)" + " out of 100"
            p1ScoreLabel.setScale(1)
            p2ScoreLabel.setScale(1)
        }
    }
    
    func start() {
        p1Bricks = 0
        p2Bricks = 0
        winnerLabel.setScale(0)
        p1ScoreLabel.setScale(0)
        p2ScoreLabel.setScale(0)
        firstWall = Wall(numberOfBricks: 6, scene: self)
        let ball = childNodeWithName("Ball")
        let ball2 = childNodeWithName("Ball2")
        let paddle = childNodeWithName("Paddle")
        let paddle2 = childNodeWithName("Paddle2")
        ball2!.position = CGPoint(x: CGRectGetMidX(self.frame), y: 455)
        ball2!.physicsBody!.applyImpulse(CGVector(dx: 125, dy: 125))
        ball!.position = CGPoint(x: CGRectGetMidX(self.frame), y: 15)
        ball!.physicsBody!.applyImpulse(CGVector(dx: 125, dy: 125))
        paddle!.position = CGPoint(x: CGRectGetMidX(self.frame), y: 10)
        paddle2!.position = CGPoint(x: CGRectGetMidX(self.frame), y: 460)
        gameGoing = true
        let startButton = childNodeWithName("startButton")
        startButton?.setScale(0)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if debug{print("contact")}
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        let ball = childNodeWithName("Ball") as! SKShapeNode
        let ball2 = childNodeWithName("Ball2") as! SKShapeNode
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == brickCategory {
            secondBody.node?.removeFromParent()
            if contact.bodyA.node?.name == "Ball" || contact.bodyB.node?.name == "Ball" {
                p1Bricks += 1
                print("P1 " + "\(p1Bricks)")
            }
            if contact.bodyA.node?.name == "Ball2" || contact.bodyB.node?.name == "Ball2" {
                p2Bricks += 1
                print("P2 " + "\(p2Bricks)")
            }
        
    }

}
}