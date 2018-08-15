//
//  GameScene.swift
//  BouncingBox
//
//  Created by Jeremy Greer on 8/9/18.
//  Copyright © 2018 Grizzle. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var boxes : [Box] = []
    
    override func didMove(to view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        self.physicsWorld.contactDelegate = self
        addObstacles()
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            // if we click a body, do something
            let point = touch.location(in: self.view)
            let x = point.x
            let y = size.height - point.y
            let altPoint = CGPoint(x: x, y: y)
            if let body = physicsWorld.body(at: altPoint) {
                let shove = CGVector(dx: -77, dy: 100)
                body.applyImpulse(shove, at: altPoint)
                // body.applyImpulse(impulse: shove, at: altPoint)
            } else {
                // otherwise, add a new box
                addBox(location: altPoint)
            }
        }
    }
    
    func addBox(location: CGPoint) {
        let boxSize = CGSize(width: CGFloat(50), height: CGFloat(50))
        let xOffset = CGFloat(-boxSize.width / 2)
        let yOffset = CGFloat(-boxSize.height / 2)
        
        let node = SKShapeNode(rect: CGRect(x: xOffset,
                                            y: yOffset,
                                            width: boxSize.width,
                                            height: boxSize.height))
        node.name = "box"
        
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        node.physicsBody?.restitution = 0.5
        node.physicsBody?.contactTestBitMask = 0b0001
        
        node.position = location
        addChild(node)
        // box.node.physicsBody?.applyImpulse(CGVector(dx: 2, dy: 3), at: location)
    }
   
    func addObstacles() {
        let rect = CGRect(x: -100, y: -25, width: 200, height: 50)
        let node = SKShapeNode(rect: rect)
        node.fillColor = .green
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 50))
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.restitution = 0
        node.physicsBody?.mass = 10
        node.physicsBody?.contactTestBitMask = 0b0001

        node.position = CGPoint(x: 200, y: 100)
        addChild(node)
        
        node.physicsBody?.applyImpulse(CGVector(dx: 49, dy: 29), at: node.position)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let name = contact.bodyA.node?.name {
            if let bNode = contact.bodyB.node {
                if name == "box" && bNode.name == "box" {
                    self.removeChildren(in: [bNode])
                }

            }
        }

    }
}
