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
        
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.1
        print("starting up the acceleromter")
        
        spaceShip = self.childNode(withName: "node") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
       
        spaceShip.position.x.clamp(v1: 0, 543.6)
        spaceShip.position.y.clamp(v1: 0, 289.6)
        
        print("turbines to speed")
        guard let data = motionManager.accelerometerData else { return }
        
        spaceShip.physicsBody?.applyForce(CGVector(dx: 500 * CGFloat(data.acceleration.y), dy: -500 * CGFloat(data.acceleration.x)))
        print("other \(data)")
    }
    
    func stopUpdates() {
        print("stop updating the data")
        motionManager.stopAccelerometerUpdates()
    }
    
    func borders(side: String) {
        if side == "down" {
            spaceShip.position.y = 59
        } else if side == "up" {
            spaceShip.position.y = 250
        }
        
    }
}

