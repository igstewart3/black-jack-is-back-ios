//
//  ButtonSpriteDelegate.swift
//  Blackjack is Back
//
//  Created by Ian Stewart on 12/04/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

import Foundation

protocol ButtonSpriteDelegate {
    /**
        The button has been tapped and needs to initiate an action.
     
        - Parameters:
            - sender: The button that has been tapped.
    */
    func buttonHit(sender : ButtonSprite)
}
