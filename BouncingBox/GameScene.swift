//
//  GameScene.swift
//  BouncingBox
//
//  Created by Jeremy Greer on 8/9/18.
//  Copyright © 2018 Grizzle. All rights reserved.
//

import SpriteKit
import GameplayKit

class Box {
    var node : SKShapeNode
    var size : CGFloat
    var xSpeed : CGFloat
    var ySpeed : CGFloat
    
    init(size: CGFloat, xSpeed: CGFloat, ySpeed: CGFloat, position: CGPoint) {
        self.size = size
        self.xSpeed = xSpeed
        self.ySpeed = ySpeed
        node = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size, height: size))
        node.position = position
    }
    
    func setX(x: CGFloat) {
        node.position.x = x
    }
    
    func setY(y: CGFloat) {
        node.position.y = y
    }
    
    func move() {
        node.position = CGPoint(x: node.position.x + xSpeed,
                                y: node.position.y + ySpeed)
    }
    
    func maybeBounceLeft() -> Bool {
        let x = node.position.x
        let limit = CGFloat(0)
        let beyond = limit - x
        if beyond > 0 {
            node.position.x = limit + beyond
            return true
        }
        return false
    }
    
    func maybeBounceRight(right: CGFloat) -> Bool {
        let x = node.position.x
        let limit = right - size
        let beyond = x - limit
        if beyond > 0 {
            node.position.x = limit - beyond
            return true
        }
        return false
    }
    
    func maybeBounceX(right: CGFloat) {
        if maybeBounceLeft() || maybeBounceRight(right: right) {
            xSpeed = -xSpeed
        }
    }
    
    func maybeBounceBottom() -> Bool {
        let y = node.position.y
        let limit = CGFloat(0)
        let beyond = limit - y
        if beyond > 0 {
            node.position.y = limit + beyond
            return true
        }
        return false
    }
    
    func maybeBounceTop(top: CGFloat) -> Bool {
        let y = node.position.y
        let limit = top - size
        let beyond = y - limit
        if beyond > 0 {
            node.position.y = limit - beyond
            return true
        }
        return false
    }
    
    func maybeBounceY(top: CGFloat) {
        if maybeBounceBottom() || maybeBounceTop(top: top) {
            ySpeed = -ySpeed
        }
    }


    func maybeBounce(top: CGFloat, right: CGFloat) {
        maybeBounceX(right: right)
        maybeBounceY(top: top)
    }
}

class GameScene: SKScene {
    private var boxes : [Box] = []
    
    override func didMove(to view: SKView) {
        var box = Box(
            size: CGFloat(50),
            xSpeed: CGFloat(3.0),
            ySpeed: CGFloat(3.0),
            position: CGPoint(x: 0, y: 0)
        )
        addChild(box.node)
        boxes.append(box)
        
        box = Box(
            size: CGFloat(50),
            xSpeed: CGFloat(2.0),
            ySpeed: CGFloat(1.3),
            position: CGPoint(x: 80, y: 0)
        )
        addChild(box.node)
        boxes.append(box)
        
        box = Box(
            size: CGFloat(33),
            xSpeed: CGFloat(3.0),
            ySpeed: CGFloat(3.3),
            position: CGPoint(x: 23, y: 90)
        )
        addChild(box.node)
        boxes.append(box)
    }
    
    override func update(_ currentTime: TimeInterval) {
        let top = size.height
        let right = size.width

        for box in boxes {
            box.move()
            box.maybeBounce(top: top, right: right)
        }
    }
}
