//
//  GameScene.swift
//  Blackjack is Back
//
//  Created by Ian Stewart on 05/04/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, ButtonSpriteDelegate {
    
    // Players
    private let user = Player(playerType: .User)
    private let dealer = Player(playerType: .Dealer)
    
    // Card Deck
    private let deck = Deck()
    
    // Timer to pace dealer turn
    var dealerTimer : Timer? = nil
    
    // Sprites for scene
    let hitButton = ButtonSprite(text: C.Buttons.TEXT_HIT, size: CGSize(width: C.Buttons.MAIN_WIDTH, height: C.Buttons.MAIN_HEIGHT), buttonType: .Right)
    let stayButton = ButtonSprite(text: C.Buttons.TEXT_STAY, size: CGSize(width: C.Buttons.MAIN_WIDTH, height: C.Buttons.MAIN_HEIGHT), buttonType: .Left)
    let outcomeDisplay = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "OutcomeDisplay")))
    let restartButton = ButtonSprite(text: C.Buttons.TEXT_RESTART, size: CGSize(width: C.Buttons.RESTART_WIDTH, height: C.Buttons.RESTART_HEIGHT), buttonType: .Full)
    let outcomeLabel = SKLabelNode(text: "")
    let cardDeckImage = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "CardDeck")), size: CGSize(width: (C.Cards.WIDTH + C.Deck.IMAGE_INCREASE), height: (C.Cards.HEIGHT + C.Deck.IMAGE_INCREASE)))
    
    override func didMove(to view: SKView) {

        let startX = 0 - self.size.width / 2 + (C.Cards.WIDTH / 2 + C.Cards.LAYOUT_OFFSET)
        let dealerStartY = self.size.height / 2 - (C.Cards.HEIGHT / 2 + C.Cards.LAYOUT_OFFSET)
        let userStartY = dealerStartY * -1
        
        user.xValue = startX
        user.yValue = userStartY
        
        dealer.xValue = startX
        dealer.yValue = dealerStartY
        
        // Setup card deck image
        cardDeckImage.zPosition = 5
        addChild(cardDeckImage)
        
        // Add buttons
        addButtons()
        
        // Setup outcome display
        setupOutcomeNode()
        
        startGame()
    }
    
    /**
        Sets up the node for displaying the outcome of the game to the user.
    */
    func setupOutcomeNode() {
        outcomeDisplay.zPosition = 100.0
        outcomeDisplay.alpha = 0
        
        // Setup child nodes
        setupOutcomeLabel()
        setupRestartButton()
    }
    
    /**
        Sets up the label to display the outcome.
    */
    func setupOutcomeLabel() {
        outcomeLabel.fontColor = .black
        outcomeLabel.fontName = C.Fonts.HN_BOLD
        outcomeLabel.position = CGPoint(x: 0.0, y: C.Outcomes.LABEL_OFFSET)
        outcomeLabel.zPosition = 5
        
        outcomeDisplay.addChild(outcomeLabel)
    }
    
    /**
        Sets up the restart button for the outcome display.
    */
    func setupRestartButton() {
        // Setup button
        restartButton.position = CGPoint(x: 0.0, y: C.Outcomes.BUTTON_OFFSET)
        restartButton.delegate = self
        outcomeDisplay.addChild(restartButton)
    }
    
    /**
        Add buttons to the scene to allow the user to interact with the game.
    */
    func addButtons() {
        let buttonX = 0 - self.size.width / 2 + (C.Buttons.MAIN_WIDTH / 2)
        
        // Hit button
        hitButton.position = CGPoint(x: buttonX, y: 0)
        hitButton.delegate = self
        addChild(hitButton)
        
        // Stay button
        stayButton.position = CGPoint(x: -buttonX, y: 0)
        stayButton.delegate = self
        addChild(stayButton)
    }
    
    /**
        Sets up the supplied button with a label.
    */
    func setupButtonLabel(button : SKSpriteNode, label : String) {
        let label = SKLabelNode(text: label)
        label.fontColor = .black
        label.fontName = C.Fonts.HN_BOLD
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.zPosition = 1
        
        button.addChild(label)
    }
    
    /**
        Starts a game of Blackjack
    */
    func startGame() {
        setButtonsEnabled(enabled: true)
        
        for _ in 0..<2 {
            let userCard = deck.nextCard()
            addChild(userCard)
            user.addCard(cardView: userCard)
            
            let dealerCard = deck.nextCard()
            addChild(dealerCard)
            dealer.addCard(cardView: dealerCard)
        }
    }
    
    /**
      Handle button hits on the screen.
     
      - Parameters:
        - sender: The button hit by the user.
    */
    func buttonHit(sender: ButtonSprite) {
        if sender == hitButton {
            hit()
        } else if sender == stayButton {
            stay()
        } else if sender == restartButton {
            restart()
        }
    }
    
    /**
        User has chosen to add another card to their hand.
    */
    func hit() {
        let userCard = deck.nextCard()
        addChild(userCard)
        user.addCard(cardView: userCard)
        if user.handTotal() > C.BlackJack.BLACK_JACK {
            stay()
        }
    }
    
    /**
        User has chosen to stay, start the dealer's turn.
     
        - Parameters:
            - bust: True if the user is bust, otherwise false.
    */
    func stay() {
        setButtonsEnabled(enabled: false)
        dealerPlay()
    }
    
    /**
        Enables/disables game buttons.
     
        - Parameters:
            - enabled: True to enable buttons, otherwise false
    */
    func setButtonsEnabled(enabled : Bool) {
        hitButton.setButtonEnabled(enabled: enabled)
        stayButton.setButtonEnabled(enabled: enabled)
    }
    
    /**
        Play out the dealer's turn.
    */
    func dealerPlay() {
        // Show dealer's hidden card
        if let firstCard = dealer.cards[0] as CardView? {
            firstCard.flip()
        }
        
        // Start timer to handle dealer cards
        dealerTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(dealerTurn), userInfo: nil, repeats: true)
    }
    
    /**
        Work through the dealers turn until he is either bust or >= 17.
    */
    @objc func dealerTurn() {
        // Add cards to hand until either bust or 17 is reached
        if dealer.handTotal() >= C.BlackJack.DEALER_CUTOFF || user.handTotal() > C.BlackJack.BLACK_JACK {
            if dealerTimer != nil {
                dealerTimer?.invalidate()
                dealerTimer = nil
                endGame()
            }
        } else {
            let dealerCard = deck.nextCard()
            addChild(dealerCard)
            dealer.addCard(cardView: dealerCard)
        }
    }
    
    /**
        Ends the game, displaying the result to the user.
    */
    func endGame() {
        var outcome : String
        let userTotal = user.handTotal()
        let dealerTotal = dealer.handTotal()
        
        if userTotal <= C.BlackJack.BLACK_JACK && (userTotal > dealerTotal || dealerTotal > C.BlackJack.BLACK_JACK) {
            outcome = C.Outcomes.WIN
        } else if userTotal < dealerTotal {
            outcome = C.Outcomes.LOSE
        } else if userTotal == dealerTotal {
            outcome = C.Outcomes.DRAW
        } else {
            outcome = C.Outcomes.BUST
        }
        outcomeLabel.text = outcome
        addChild(outcomeDisplay)
        outcomeDisplay.run(C.Outcomes.FADE_IN)
        restartButton.setButtonEnabled(enabled: true)
    }
    
    /**
        Sets up the UI to start the next game.
    */
    func restart() {
        restartButton.setButtonEnabled(enabled: false)
        outcomeDisplay.run(C.Outcomes.FADE_OUT)
        
        deck.returnCards(cards: user.returnCards())
        deck.returnCards(cards: dealer.returnCards())
        
        startGame()
    }
}
