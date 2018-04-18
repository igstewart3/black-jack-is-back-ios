//
//  Constants.swift
//  Blackjack is Back
//
//  Created by Ian Stewart on 16/04/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

import SpriteKit

/**
    Constants for the app.
 */
struct C {
    /**
        Constants for the outcome display.
    */
    struct Outcomes {
        static let WIN  = "You Win!"
        static let LOSE = "You Lose!"
        static let DRAW = "Draw!"
        static let BUST = "Bust!"
        
        static let LABEL_OFFSET = CGFloat(50.0)
        static let BUTTON_OFFSET = CGFloat(-30.0)
        
        static let FADE_IN = SKAction.fadeIn(withDuration: 0.25)
        static let FADE_OUT = SKAction.sequence([SKAction.fadeOut(withDuration: 0.25), SKAction.removeFromParent()])
    }
    
    /**
        Font names.
    */
    struct Fonts {
        static let HN_BOLD = "HelveticaNeue-Bold"
    }
    
    /**
        Blackjack number constants.
    */
    struct BlackJack {
        static let BLACK_JACK = 21
        static let DEALER_CUTOFF = 17
    }
    
    /**
        Constants for the button sprites.
    */
    struct Buttons {
        static let TEXT_HIT = "HIT"
        static let TEXT_STAY = "STAY"
        static let TEXT_RESTART = "Restart"
        static let MAIN_WIDTH = CGFloat(150.0)
        static let MAIN_HEIGHT = CGFloat(300.0)
        static let RESTART_WIDTH = CGFloat(200.0)
        static let RESTART_HEIGHT = CGFloat(100.0)
    }
    
    /**
        Constants for the deck image.
    */
    struct Deck {
        static let IMAGE_INCREASE = CGFloat(30.0)
        static let DECK_COUNT = 6
        static let RESHUFFLE_COUNT = 50
    }
    
    /**
        Constants for the card images.
    */
    struct Cards {
        static let NEXT_CARD_OFFSET = CGFloat(10.0)
        static let LAYOUT_OFFSET = CGFloat(40.0)
        static let WIDTH = CGFloat(120.0)
        static let HEIGHT = CGFloat(180.0)
    }
}
