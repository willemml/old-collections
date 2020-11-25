//
//  GameViewController.swift
//  Old Collections
//
//  Created by Willem Leitso on 2020-11-22.
//

import UIKit
import SpriteKit
import GameplayKit

class ViewController: UIViewController {
    override func viewDidDisappear(_ animated: Bool) {
        self.dismiss(animated: false, completion: nil)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

class GameView : SKView {
    var gameScene: SKScene? = nil
    
    deinit {
        leaveGame()
        removeFromSuperview()
    }
    
    @IBAction func leaveGame() {
        gameScene = nil
        scene?.removeAllActions()
        scene?.removeAllChildren()
        scene?.removeFromParent()
        presentScene(nil)
    }
    
    required init?(coder: NSCoder) {
        gameScene = GameScene<DongDong>.newGameScene()
        super.init(coder: coder)
        presentScene(gameScene)
    }
}
