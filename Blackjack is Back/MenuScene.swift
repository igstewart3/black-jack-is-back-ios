//
//  MenuScene.swift
//  Blackjack is Back
//
//  Created by Ian Stewart on 13/04/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

import SpriteKit

class MenuScene : SKScene, ButtonSpriteDelegate {
    
    var justBlackjackButton : ButtonSprite!
    
    override func didMove(to view: SKView) {
        // Setup just blackjack button
        guard let justBlackjack = childNode(withName: "JustBlackjack") as? ButtonSprite else {
            fatalError("Just Blackjack button not found")
        }
        justBlackjackButton = justBlackjack
        justBlackjackButton.delegate = self
    }
    
    func buttonHit(sender: ButtonSprite) {
        // Load the SKScene from 'GameScene.sks'
        if let gameScene = SKScene(fileNamed: "GameScene") {
            
            // Set the scale mode to scale to fit the window
            gameScene.scaleMode = .aspectFill
            
            let transition = SKTransition.crossFade(withDuration: 0.5)
            transition.pausesOutgoingScene = false
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                gameScene.size.width = self.size.width
                gameScene.size.height = self.size.height
            }
            
            // Present the scene
            view!.presentScene(gameScene, transition: transition)
        }
    }
}
