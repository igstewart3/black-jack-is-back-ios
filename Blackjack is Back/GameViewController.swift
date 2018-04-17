//
//  GameViewController.swift
//  Blackjack is Back
//
//  Created by Ian Stewart on 05/04/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene
            if let menuScene = SKScene(fileNamed: "MenuScene") {
                
                // Set the scale mode to scale to fit the window
                menuScene.scaleMode = .aspectFill
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    menuScene.size.width = self.view.bounds.width
                    menuScene.size.height = self.view.bounds.height
                }
                
                // Present the scene
                view.presentScene(menuScene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
