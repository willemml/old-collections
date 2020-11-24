//
//  GameScene.swift
//  Old Collections
//
//  Created by Willem Leitso on 2020-11-21.
//

import SpriteKit

class GameScene<T: Game>: SKScene {
    fileprivate var game : T?
    fileprivate var buttons : [Button]?
    
    class func newGameScene() -> GameScene<T> {
        let screenSize = UIScreen.main.bounds.size
        let sceneSize = CGSize(width: screenSize.width * 2, height: screenSize.height * 2)
        let scene = GameScene(size: sceneSize)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.game = scene.startGame()
        return scene
    }
    
    func startGame() -> T {
        self.removeAllActions()
        self.removeAllChildren()
        if let instance = game {
            self.game = instance
        }
        return T(scene: self)
    }
    
    override func didMove(to view: SKView) {
        self.game = self.startGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let game = self.game {
            game.touchesBegan(touches, with: event)
        } else {
            if let buttons = self.buttons {
                for button in buttons {
                    for touch in touches {
                        button.tryTouch(touch: touch)
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let game = self.game {
            game.touchesMoved(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let game = self.game {
            game.touchesEnded(touches, with: event)
        }
    }
}

