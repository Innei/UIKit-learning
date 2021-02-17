//
//  GameViewController.swift
//  Project-9
//
//  Created by Innei on 2021/2/6.
//

import GameplayKit
import SpriteKit
import UIKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }

//        if view.alpha == 1.0 {
//            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 1, options: .curveEaseInOut) {
//                self.view.alpha = 0.0
//            } completion: { _ in
//                if self.view.alpha == 0.0 {
//                    self.view.removeFromSuperview()
//                }
//            }
//            print(view.alpha)
//        }
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
