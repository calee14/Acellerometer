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
    case up, down, right, left, still
}

class GameScene: SKScene {
    
    let motionManager = CMMotionManager()
    var spaceShip: SKSpriteNode!
    var dir: Direction = .still
    
    override func didMove(to view: SKView) {
        
        //Declaring swipe gestures
        //Creating the Swipe Right
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(GameScene().swiped(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view?.addGestureRecognizer(swipeRight)
        //Creating the Swipe Down
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(GameScene().swiped(_:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view?.addGestureRecognizer(swipeDown)
        //Creating the SwipeUp
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(GameScene().swiped(_:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view?.addGestureRecognizer(swipeUp)
        //Creating the SwipeLeft
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(GameScene().swiped(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view?.addGestureRecognizer(swipeLeft)
        
        //Creates a border the size of the frame
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        //self.physicsBody = border
        
        //Starts the accelerometer updates
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.1
        print("starting up the acceleromter")
        
        //Connect spaceShip
        spaceShip = self.childNode(withName: "node") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //Warp thingy
        warpy()
        
        //The accelerometer
        //updateAcellerometerData()
        //addSwipe()
        
        //Check direction
        checkDirection()
        
    }
    
    func swiped(_ gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            //Switch function if the player swiped up, down, left, right
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                dir = .right
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
                dir = .down
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                dir = .left
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
                dir = .up
            default:
                break
            }
        }
    }
    
    func checkDirection() {
        if dir == .right {
            spaceShip.position.x += 5
        } else if dir == .left {
            spaceShip.position.x -= 5
        } else if dir == .up {
            spaceShip.position.y += 5
        } else if dir == .down {
            spaceShip.position.y -= 5
        } else if dir == .still {
            return
        }
    }
    
    func updateAcellerometerData() {
        //While accelerometerData is active Clamp speed
        spaceShip.physicsBody?.velocity.dx.clamp(v1: -600, 600)
        spaceShip.physicsBody?.velocity.dy.clamp(v1: -600, 600)
        
        //TODO: Check the data
        print("turbines to speed")
        guard let data = motionManager.accelerometerData else { return }
        
        //Applying the force to the spaceShip
        spaceShip.physicsBody?.applyForce(CGVector(dx: 500 * CGFloat(data.acceleration.y), dy: -500 * CGFloat(data.acceleration.x)))
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

