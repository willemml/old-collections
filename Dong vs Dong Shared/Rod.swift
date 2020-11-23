//
//  Rod.swift
//  Dong vs Dong Shared
//
//  Created by Willem Leitso on 2020-11-22.
//

import Foundation
import SpriteKit

class Rod {
    fileprivate var movingVertical = false
    fileprivate var movingHorizontal = false
    fileprivate var direction = Direction.DOWN
    fileprivate let screenHeight : CGFloat
    fileprivate let pokeDirection : PokeDirection
    public let rodHeight : CGFloat
    public let rod : SKShapeNode
    
    public init(color: SKColor, screenSize: CGSize, poke: PokeDirection, scene: SKScene) {
        pokeDirection = poke
        screenHeight = screenSize.height * 2
        let width = screenSize.width / 2
        rodHeight = screenSize.height * 2 / 37.5
        let startX: CGFloat
        if pokeDirection == PokeDirection.RIGHT {
            startX = -(screenSize.width - 20)
        } else {
            startX = screenSize.width - 20 - width
        }
        let rect = CGRect(x: startX, y: 0, width: width, height: rodHeight)
        rod = SKShapeNode(rect: rect)
        rod.strokeColor = color
        rod.fillColor = color
        rod.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
        rod.physicsBody?.categoryBitMask = 0b0001
        scene.addChild(rod)
    }
    
    public func moveVertical() {
        if !movingHorizontal && !movingVertical {
            movingVertical = true
            let destination: CGFloat
            let nextDirection: Direction
            if direction == Direction.DOWN {
                destination = -(screenHeight / 2 - 20)
                nextDirection = Direction.UP
            } else {
                destination = screenHeight / 2 - 20 - rodHeight
                nextDirection = Direction.DOWN
            }
            let distance = destination - rod.position.y
            let time = abs(distance / (screenHeight / 4))
            rod.run(SKAction.sequence([SKAction.moveBy(x: 0, y: distance, duration: TimeInterval(time)), SKAction.run {
                self.direction = nextDirection
                self.movingVertical = false
                self.moveVertical()
            }]))
        }
    }
    
    public func poke(amount: CGFloat) {
        if !movingHorizontal {
            movingHorizontal = true
            if movingVertical {
                rod.removeAllActions()
                movingVertical = false
            }
            let time = amount / 400
            let delta: CGFloat
            if pokeDirection == PokeDirection.LEFT {
                delta = -amount
            } else {
                delta = amount
            }
            rod.run(SKAction.sequence([SKAction.moveBy(x: delta, y: 0, duration: TimeInterval(time)), SKAction.moveBy(x: -delta, y: 0, duration: TimeInterval(time)), SKAction.run({
                self.movingHorizontal = false
                self.moveVertical()
            })]))
        }
    }
}

public enum PokeDirection {
    case LEFT
    case RIGHT
}

enum Direction {
    case UP
    case DOWN
}
