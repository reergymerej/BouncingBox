//
//  GameScene.swift
//  BouncingBox
//
//  Created by Jeremy Greer on 8/9/18.
//  Copyright © 2018 Grizzle. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var boxes : [Box] = []
    
    override func didMove(to view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            addBox(location: touch.location(in: self.view))
        }
    }
    
    func addBox(location: CGPoint) {
        let x = location.x
        let y = size.height - location.y
        let box = Box(
            size: CGFloat(50),
            xSpeed: CGFloat(3.0),
            ySpeed: CGFloat(3.0),
            position: CGPoint(x: x, y: y)
        )
        addChild(box.node)
        box.node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        box.node.physicsBody?.restitution = 0.7
        
        boxes.append(box)
        // box.node.physicsBody?.applyImpulse(CGVector(dx: 2, dy: 3), at: location)
    }
    
}
