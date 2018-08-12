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
    
    private var squareNode = SKShapeNode()
    private var squareNode2 = SKShapeNode()
    private var xSpeed = CGFloat(3.0)
    private var ySpeed = CGFloat(3.0)
    private var xSpeed2 = CGFloat(2.0)
    private var ySpeed2 = CGFloat(-3.5)
    
    override func didMove(to view: SKView) {
        squareNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 50, height: 50))
        addChild(squareNode)

        squareNode2 = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 50, height: 50))
        squareNode2.position.x = 100
        squareNode2.position.y = size.height - 50
        addChild(squareNode2)
    }

    override func update(_ currentTime: TimeInterval) {
        // calculate new position
        var nextX = squareNode.position.x + xSpeed
        var nextY = squareNode.position.y + ySpeed
        var nextX2 = squareNode2.position.x + xSpeed2
        var nextY2 = squareNode2.position.y + ySpeed2
        
        // handle collisions
        let right = size.width - 50
        let left = CGFloat(0)
        let top = size.height - 50
        let bottom = CGFloat(0)
        
        if nextX > right {
            nextX = right
            xSpeed = -xSpeed
        }
        if nextX < left {
            nextX = left
            xSpeed = -xSpeed
        }
        
        if nextY > top {
            nextY = top
            ySpeed = -ySpeed
        }
        if nextY < bottom {
            nextY = bottom
            ySpeed = -ySpeed
        }
        
        //
        
        if nextX2 > right {
            nextX2 = right
            xSpeed2 = -xSpeed2
        }
        if nextX2 < left {
            nextX2 = left
            xSpeed2 = -xSpeed2
        }
        
        if nextY2 > top {
            nextY2 = top
            ySpeed2 = -ySpeed2
        }
        if nextY2 < bottom {
            nextY2 = bottom
            ySpeed2 = -ySpeed2
        }

        // update position
        squareNode.position.x = nextX
        squareNode.position.y = nextY
        squareNode2.position.x = nextX2
        squareNode2.position.y = nextY2
    }
}
