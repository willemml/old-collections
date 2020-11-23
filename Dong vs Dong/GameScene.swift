//
//  GameScene.swift
//  Dong vs Dong Shared
//
//  Created by Willem Leitso on 2020-11-21.
//

import SpriteKit

class GameScene: SKScene {
    fileprivate var game : Game?
    fileprivate var buttons : [Button]?
    
    class func newGameScene() -> GameScene {
        let screenSize = UIScreen.main.bounds.size
        let sceneSize = CGSize(width: screenSize.width * 2, height: screenSize.height * 2)
        let scene = GameScene(size: sceneSize)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return scene
    }
    
    func setUpScene() {
        var buttonPrep : [Button] = []
        for game in Games.allCases {
            buttonPrep.append(Button(parent: self, center: CGPoint(x: 0, y: 0), text: game.rawValue, action: { _ in self.startGame(game: game) }))
        }
        buttons = buttonPrep
    }
    
    func startGame(game: Games) {
        self.removeAllActions()
        self.removeAllChildren()
        switch game {
        case Games.DongDong:
            self.game = DongDong(scene: self)
        }
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
}

enum Games : String, CaseIterable {
    case DongDong
}

#if os(iOS) || os(tvOS)
extension GameScene {
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
#endif

