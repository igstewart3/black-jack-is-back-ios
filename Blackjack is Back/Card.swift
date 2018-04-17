//
//  Card.swift
//  Blackjack is Back
//
//  Created by Ian Stewart on 11/04/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

import Foundation

enum CardSuit {
    case Diamonds,
    Clubs,
    Hearts,
    Spades
}

class Card {
    
    let value : Int
    let symbol : String
    let cardSuit : CardSuit
    
    init(value : Int, symbol : String, cardSuit : CardSuit) {
        self.value = value
        self.symbol = symbol
        self.cardSuit = cardSuit
    }
}
