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

class GameScene: SKScene {
    
    let motionManager = CMMotionManager()
    var spaceShip: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        motionManager.startAccelerometerUpdates()
        print("starting up the acceleromter")
        
        spaceShip = self.childNode(withName: "node") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if spaceShip.position.x < 59 {
            borders(side: "left")
        }
        if spaceShip.position.x > 690 {
            borders(side: "right")
        }
        
        if let data = motionManager.accelerometerData {
            print("turbines to speed")
            spaceShip.physicsBody?.applyForce(CGVector(dx: 300 * CGFloat(data.acceleration.x), dy: 0))
            print(data.acceleration.x)
        }
        
    }
    
    func stopUpdates() {
        print("stop updating the data")
        motionManager.stopAccelerometerUpdates()
    }
    
    func borders(side: String) {
        if side == "left" {
            spaceShip.position.x = 59
        } else if side == "right" {
            spaceShip.position.x = 690
        }
        
    }
}
