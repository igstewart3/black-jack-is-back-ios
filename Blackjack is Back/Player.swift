//
//  Player.swift
//  Blackjack is Back
//
//  Created by Ian Stewart on 10/04/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

import SceneKit

enum PlayerType {
    case User,
    Dealer
}

class Player {
    
    let playerType : PlayerType
    
    var cards = [CardView]()
    
    var cardCount : Int { return cards.count }
    
    var xValue : CGFloat {
        set {
            startX = newValue
            currentX = newValue
        }
        get {
            return currentX
        }
    }
    
    var yValue : CGFloat {
        set {
            startY = newValue
        }
        get {
            return startY
        }
    }
    
    private var startX : CGFloat
    private var startY : CGFloat
    private var currentX : CGFloat
    private var currentZ : CGFloat
    
    init(playerType : PlayerType) {
        self.playerType = playerType
        startX = 0.0
        startY = 0.0
        currentX = 0.0
        currentZ = 10.0
    }
    
    /**
        Add a card to the player's hand.
 
        - Parameters:
            - cardView: The card to add to the player's hand.
    */
    func addCard(cardView : CardView) {
        let flip = (playerType != .Dealer || cards.count > 0)
        cards.append(cardView)
        cardView.zPosition = currentZ
        currentZ += 10
        cardView.moveCard(x: currentX, y: startY, flip: flip, remove: false)
        currentX += (cardView.size.width - C.Cards.NEXT_CARD_OFFSET)
    }
    
    /**
        Return all cards currently in player's hand.
     
        - Returns: Array containing all cards currently in the player's hand.
     */
    func returnCards() -> [CardView] {
        let cardViews = [CardView](cards)
        cards.removeAll()
        for card in cardViews.reversed() {
            currentX -= (card.size.width - 20)
            card.moveCard(x: 0, y: 0, flip: true, remove: true)
        }
        currentX = startX
        currentZ = 10.0
        return cardViews
    }
    
    /**
        Return the current total for the user's hand.
     
        - Returns: Int representing the player's current total.
     */
    func handTotal() -> Int {
        var total = 0
        var aceCount = 0;
        for cardView in cards {
            total += cardView.card.value
            if cardView.card.symbol == "A" {
                aceCount += 1
            }
        }
        for _ in 0..<aceCount {
            if total > 21 {
                total -= 10
            } else {
                break
            }
        }
        return total
    }
}
