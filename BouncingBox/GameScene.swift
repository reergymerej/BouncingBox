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
    }
    
    override func update(_ currentTime: TimeInterval) {
        let top = size.height
        let right = size.width

        for box in boxes {
            box.move()
            box.maybeBounce(top: top, right: right)
        }
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
        boxes.append(box)
    }
    
}
