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
        addObstacles()
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
        
        let boxSize = CGSize(width: CGFloat(50), height: CGFloat(50))
        let xOffset = CGFloat(-boxSize.width / 2)
        let yOffset = CGFloat(-boxSize.height / 2)
        
        let node = SKShapeNode(rect: CGRect(x: xOffset,
                                            y: yOffset,
                                            width: boxSize.width,
                                            height: boxSize.height))
        
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        node.physicsBody?.restitution = 0.7
        
        node.position = CGPoint(x: x, y: y)
        addChild(node)
        // box.node.physicsBody?.applyImpulse(CGVector(dx: 2, dy: 3), at: location)
    }
   
    func addObstacles() {
        let rect = CGRect(x: -100, y: -25, width: 200, height: 50)
        let node = SKShapeNode(rect: rect)
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 50))
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.restitution = 0
        // node.physicsBody?.isDynamic = false
        
        node.position = CGPoint(x: 200, y: 100)
        addChild(node)
        
        node.physicsBody?.applyImpulse(CGVector(dx: 49, dy: 29), at: node.position)
        // node.physicsBody?.applyForce(CGVector(dx: 49, dy: 29))
    }
}
