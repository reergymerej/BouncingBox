//
//  Box.swift
//  BouncingBox
//
//  Created by Jeremy Greer on 8/12/18.
//  Copyright © 2018 Grizzle. All rights reserved.
//

import Foundation
import SpriteKit

class Box {
    var node : SKShapeNode
    var half : CGFloat
    var xSpeed : CGFloat
    var ySpeed : CGFloat
    
    init(size: CGFloat, xSpeed: CGFloat, ySpeed: CGFloat, position: CGPoint) {
        self.xSpeed = xSpeed
        self.ySpeed = ySpeed
        self.half = size / 2
        node = SKShapeNode(rect: CGRect(x: -half, y: -half, width: size, height: size))
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
        let limit = CGFloat(0) + half
        let beyond = limit - x
        if beyond > 0 {
            node.position.x = limit + beyond
            return true
        }
        return false
    }
    
    func maybeBounceRight(right: CGFloat) -> Bool {
        let x = node.position.x
        let limit = right - half
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
        let limit = CGFloat(0) + half
        let beyond = limit - y
        if beyond > 0 {
            node.position.y = limit + beyond
            return true
        }
        return false
    }
    
    func maybeBounceTop(top: CGFloat) -> Bool {
        let y = node.position.y
        let limit = top - half
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
