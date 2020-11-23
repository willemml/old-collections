//
//  GameScene.swift
//  Dong vs Dong Shared
//
//  Created by Willem Leitso on 2020-11-21.
//

import SpriteKit

class GameScene: SKScene {
    fileprivate var dongDong : DongDong?
    
    class func newGameScene() -> GameScene {
        let screenSize = UIScreen.main.bounds.size
        let sceneSize = CGSize(width: screenSize.width * 2, height: screenSize.height * 2)
        let scene = GameScene(size: sceneSize)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return scene
    }
    
    func setUpScene() {
        dongDong = DongDong(scene: self)
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
}

#if os(iOS) || os(tvOS)
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let game = dongDong {
            game.touchesBegan(touches, with: event)
        }
    }
}
#endif

