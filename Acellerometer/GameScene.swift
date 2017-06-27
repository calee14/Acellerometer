//
//  GameScene.swift
//  Acellerometer
//
//  Created by Cappillen on 6/23/17.
//  Copyright © 2017 Cappillen. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion
import Foundation

enum Direction {
    case up, down
}

class GameScene: SKScene {
    
    let motionManager = CMMotionManager()
    var spaceShip: SKSpriteNode!
    var dir: Direction = .up
    
    override func didMove(to view: SKView) {
        
        //Creates a border the size of the frame
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        //self.physicsBody = border
        
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.1
        print("starting up the acceleromter")
        
        spaceShip = self.childNode(withName: "node") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //Warp thingy
        warpy()
        
        //Clamp speed
        spaceShip.physicsBody?.velocity.dx.clamp(v1: -400, 400)
        spaceShip.physicsBody?.velocity.dy.clamp(v1: -400, 400)
        
        print("turbines to speed")
        guard let data = motionManager.accelerometerData else { return }
        
        spaceShip.physicsBody?.applyForce(CGVector(dx: 250 * CGFloat(data.acceleration.y), dy: -250 * CGFloat(data.acceleration.x)))
        print("other \(data)")
    }
    
    func warpy() {
        //Creates the warp 
        if spaceShip.position.x < 0 {
            spaceShip.position.x = 583
        } else if spaceShip.position.x > 583 {
            spaceShip.position.x = 0
        }
        if spaceShip.position.y < 0 {
            spaceShip.position.y = 320
        } else if spaceShip.position.y > 320{
            spaceShip.position.y = 0
        }
    }
    
    func stopUpdates() {
        print("stop updating the data")
        motionManager.stopAccelerometerUpdates()
    }
}

