//
//  CardTests.swift
//  Blackjack is BackTests
//
//  Created by Ian Stewart on 16/04/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

import XCTest

class CardTests: XCTestCase {
    
    let card = Card(value: 5, symbol: "Y", cardSuit: .Clubs)
    
    override func setUp() {
        super.setUp()
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCardValue() {
        XCTAssertEqual(5, card.value)
    }
    
    func testCardSymbol() {
        XCTAssertEqual("Y", card.symbol)
    }
    
    func testCardSuit() {
        XCTAssertEqual(CardSuit.Clubs, card.cardSuit)
    }
    
}
