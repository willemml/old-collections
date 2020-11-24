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
    @IBAction func goDong() {
        let skView = self.view as! SKView
        skView.presentScene(GameScene<DongDong>.newGameScene())
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
