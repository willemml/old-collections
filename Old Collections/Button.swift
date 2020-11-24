//
//  Button.swift
//  Old Collections
//
//  Created by Willem Leitso on 2020-11-23.
//

import Foundation
import SpriteKit

class Button {
    fileprivate let node : SKShapeNode
    fileprivate let scene : SKScene
    fileprivate let action : (SKScene) -> (Void)
    
    public init(parent: SKScene, center: CGPoint, text: String, action: @escaping (SKScene) -> (Void)) {
        let label = SKLabelNode()
        label.text = text
        self.action = action
        self.scene = parent
        node = SKShapeNode(rectOf: label.frame.size, cornerRadius: 15)
        label.move(toParent: node)
        node.move(toParent: parent)
    }
    
    public func tryTouch(touch: UITouch) {
        if node.contains(touch.location(in: scene)) {
            action(scene)
        }
    }
}
