//
//  Deck.swift
//  Blackjack is Back
//
//  Created by Ian Stewart on 05/04/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

import Foundation
import GameplayKit

class Deck {
    
    fileprivate let suits = [ CardSuit.Diamonds, CardSuit.Clubs, CardSuit.Hearts, CardSuit.Spades]
    fileprivate let symbols = [ "2" : 2, "3" : 3, "4" : 4, "5" : 5, "6" : 6, "7" : 7, "8" : 8, "9" : 9, "10" : 10, "J" : 10, "Q" : 10, "K" : 10, "A" : 11 ]
    
    private var deck = [Card]()
    private var used = [Card]()
    
    init() {
        for _ in 0 ..< C.Deck.DECK_COUNT {
            for x in suits {
                for (y, z) in symbols {
                    let card = Card(value: z, symbol: y, cardSuit: x)
                    deck.append(card)
                }
            }
        }
        shuffle()
    }
    
    var isEmpty : Bool { return deck.isEmpty }
    
    var count : Int { return deck.count }
    
    /**
        Returns next card in deck to display.
     
        - Returns: CardView representing next card in deck.
    */
    func nextCard() -> CardView {
        if count < C.Deck.RESHUFFLE_COUNT {
            shuffle()
        }
        let cardView = CardView(card: deck.removeFirst())
        return cardView
    }
    
    /**
        Return a collection of cards to the used pile in the deck.
     
        - Parameters:
            - cards: The cards to return to the deck.
    */
    func returnCards(cards : [CardView]) {
        for cardView in cards {
            used.append(cardView.card)
        }
    }
    
    /**
        Shuffles the deck, also returning any cards from the used pile to the main deck.
    */
    func shuffle() {
        if !used.isEmpty {
            deck.append(contentsOf: used)
            used.removeAll()
        }
        deck = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: deck) as! [Card]
    }
}
