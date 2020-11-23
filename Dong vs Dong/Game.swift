//
//  Game.swift
//  Dong vs Dong
//
//  Created by Willem Leitso on 2020-11-23.
//

import Foundation
import SpriteKit
open class Game {
    internal let scene : SKScene
    public init(scene: SKScene) {
        self.scene = scene
    }
}

#if os(iOS) || os(tvOS)
extension Game {
    @objc
    open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
    }
    
    @objc
    open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
    }
    
    @objc
    open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
    }
}
#endif
