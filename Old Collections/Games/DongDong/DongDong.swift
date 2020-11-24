//
//  DongDong.swift
//  Old Collections
//
//  Created by Willem Leitso on 2020-11-22.
//

import SpriteKit

class DongDong : Game {
    fileprivate let leftRod : Rod
    fileprivate let rightRod : Rod
    fileprivate let unit : CGFloat
    fileprivate let distanceRodWall : CGFloat
    fileprivate let walls : [SKShapeNode]
    fileprivate let blocks : [SKShapeNode]
    
    
    public required init(scene: SKScene) {
        let screenSize = UIScreen.main.bounds.size
        leftRod = Rod(color: .red, screenSize: screenSize, poke: PokeDirection.RIGHT, scene: scene)
        rightRod = Rod(color: .blue, screenSize: screenSize, poke: PokeDirection.LEFT, scene: scene)
        unit = screenSize.height * 2 / 18
        print(unit)
        distanceRodWall = abs(screenSize.width / 2 - 20 - unit * 1.5)
        print(distanceRodWall)
        let centered = unit * -1.5
        walls = [
            DongDong.createWall(x: centered, y: -screenSize.height, width: unit * 3, height: unit * 6, scene: scene),
            DongDong.createWall(x: centered, y: -unit, width: unit * 3, height: unit * 2, scene: scene),
            DongDong.createWall(x: centered, y: unit * 3, width: unit * 3, height: unit * 2, scene: scene),
            DongDong.createWall(x: centered, y: unit * 7, width: unit * 3, height: unit * 2, scene: scene)
        ]
        blocks = [
            DongDong.createBlock(x: centered, y: unit * -3, unit: unit, scene: scene),
            DongDong.createBlock(x: centered, y: unit, unit: unit, scene: scene),
            DongDong.createBlock(x: centered, y: unit * 5, unit: unit, scene: scene)
        ]
        leftRod.moveVertical()
        rightRod.moveVertical()
        super.init(scene: scene)
    }
    
    class func createWall(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, scene: SKScene) -> SKShapeNode {
        let rect = CGRect(x: x, y: y, width: width, height: height)
        let wall = SKShapeNode(rect: rect)
        wall.name = "Wall"
        wall.fillColor = .gray
        wall.strokeColor = .gray
        wall.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
        wall.physicsBody?.categoryBitMask = 0b0001
        wall.move(toParent: scene)
        return wall
    }
    
    class func createBlock(x: CGFloat, y: CGFloat, unit: CGFloat, scene: SKScene) -> SKShapeNode {
        let width = unit * 3
        let height = unit * 2
        let block = SKShapeNode(rect: CGRect(x: x, y: y, width: width, height: height))
        block.name = "Block"
        block.fillColor = .orange
        block.strokeColor = .orange
        block.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height), center: CGPoint(x: x + width / 2, y: y + height / 2))
        block.physicsBody?.collisionBitMask = 0b0001
        block.physicsBody?.allowsRotation = false
        block.move(toParent: scene)
        return block
    }
    
    func atBlock(rod: Rod, side: Side) -> CGFloat {
        for block in blocks {
            if rod.rod.frame.minY > block.frame.minY && rod.rod.frame.minY + rod.rodHeight < block.frame.minY + unit * 2 {
                let blockX = block.position.x - unit * 1.5
                if side == Side.LEFT {
                    if blockX >= 0 {
                        return unit * 3.1
                    } else if blockX >= unit * -1.6 {
                        return unit * 1.6
                    }
                } else {
                    if blockX <= unit * -2.9 {
                        return unit * 3.1
                    } else if blockX <= unit * -1.4 {
                        return unit * 1.6
                    }
                }
            }
        }
        return 0
    }
    
    func poke(side: Side) {
        if side == Side.LEFT {
            leftRod.poke(amount: distanceRodWall + atBlock(rod: leftRod, side: Side.LEFT))
        } else {
            rightRod.poke(amount: distanceRodWall + atBlock(rod: rightRod, side: Side.RIGHT))
        }
    }
}

#if os(iOS) || os(tvOS)
extension DongDong {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch.location(in: scene).x < 0 {
                poke(side: Side.LEFT)
            } else {
                poke(side: Side.RIGHT)
            }
        }
    }
}
#endif

enum Side {
    case LEFT
    case RIGHT
}
