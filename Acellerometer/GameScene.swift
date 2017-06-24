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
    var dir: Direction!
    
    override func didMove(to view: SKView) {
        
        motionManager.startAccelerometerUpdates()
        print("starting up the acceleromter")
        
        spaceShip = self.childNode(withName: "node") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if let data = motionManager.accelerometerData {
            if data.acceleration.z < 0 {
                dir = .up
            } else if data.acceleration.z > 0 {
                dir = .down
            }
        }
        
        if let data = motionManager.accelerometerData {
            print(data)
        }
        
        if let data = motionManager.accelerometerData {
            print("turbines to speed")
            spaceShip.physicsBody?.applyForce(CGVector(dx: 0, dy: -1000 * CGFloat(data.acceleration.z)))
            print(data.acceleration.x)
        }
        
        if spaceShip.position.y < 59 {
            borders(side: "down")
        }
        if spaceShip.position.y > 250 {
            borders(side: "up")
        }
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
