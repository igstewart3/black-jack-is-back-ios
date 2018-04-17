//
//  Card.swift
//  Blackjack is Back
//
//  Created by Ian Stewart on 05/04/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

import SpriteKit

class CardView : SKSpriteNode {
    
    // Card values
    let card : Card
    
    // Card variables
    var showFront : Bool = false
    
    // Display elements
    let suitTexture : SKTexture
    let backTexture : SKTexture
    let frontTexture : SKTexture
    let titleTexture : SKTexture
    let labelColour : UIColor
    
    // Nodes
    let topLeftSymbol : SKLabelNode
    let bottomRightSymbol : SKLabelNode
    let centreImage : SKSpriteNode
    
    // Animations
    let firstHalfFlip = SKAction.scaleX(to: 0.0, duration: 0.2)
    let secondHalfFlip = SKAction.scaleX(to: 1.0, duration: 0.2)
    var midFlipAction : SKAction! = nil
    var flipSequence : SKAction! = nil
    
    init(card : Card) {
        self.card = card
        
        // Setup animation modes
        firstHalfFlip.timingMode = .easeInEaseOut
        secondHalfFlip.timingMode = .easeInEaseOut
        
        // Setup node textures
        titleTexture = SKTexture(image: #imageLiteral(resourceName: "TitleImage"))
        frontTexture = SKTexture(image: #imageLiteral(resourceName: "CardBaseFront"))
        backTexture = SKTexture(image: #imageLiteral(resourceName: "CardBaseBack"))
        
        // Setup suit texture
        switch self.card.cardSuit {
        case .Diamonds:
            suitTexture = SKTexture(image: #imageLiteral(resourceName: "DiamondCard"))
            labelColour = .red
        case .Clubs:
            suitTexture = SKTexture(image: #imageLiteral(resourceName: "ClubCard"))
            labelColour = .black
        case .Hearts:
            suitTexture = SKTexture(image: #imageLiteral(resourceName: "HeartCard"))
            labelColour = .red
        case .Spades:
            suitTexture = SKTexture(image: #imageLiteral(resourceName: "SpadeCard"))
            labelColour = .black
        }
        
        // Setup display nodes
        centreImage = SKSpriteNode(texture: suitTexture)
        topLeftSymbol = SKLabelNode(text: self.card.symbol)
        bottomRightSymbol = SKLabelNode(text: self.card.symbol)
        
        // Setup card size and texture
        let size = CGSize(width: C.Cards.WIDTH, height: C.Cards.HEIGHT)
        let texture = showFront ? frontTexture : backTexture
        super.init(texture: texture, color: .black, size: size)
        
        // Setup flip animation sequence
        midFlipAction = SKAction.run { [weak self] in
            self?.showFront = !(self?.showFront)!
            self?.changeSideLayout()
        }
        flipSequence = SKAction.sequence([firstHalfFlip, midFlipAction, secondHalfFlip])
        
        self.zPosition = 10
        topLeftSymbol.zPosition = 5
        bottomRightSymbol.zPosition = 5
        centreImage.zPosition = 5
        
        topLeftSymbol.position = CGPoint(x: -38.0, y: 58.0)
        bottomRightSymbol.position = CGPoint(x: 38.0, y: -78.0)
        
        topLeftSymbol.fontColor = labelColour
        topLeftSymbol.fontName = C.Fonts.HN_BOLD
        bottomRightSymbol.fontColor = labelColour
        bottomRightSymbol.fontName = C.Fonts.HN_BOLD
        
        centreImage.size = CGSize(width: 60, height: 60)
        
        addChild(topLeftSymbol)
        addChild(bottomRightSymbol)
        addChild(centreImage)
        
        changeSideLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Code initialisation should not be used")
    }
    
    /**
        Changes the layout between the front and back layouts.
    */
    func changeSideLayout() {
        centreImage.isHidden = !showFront
        topLeftSymbol.isHidden = !showFront
        bottomRightSymbol.isHidden = !showFront
        texture = showFront ? frontTexture : backTexture
    }

    /**
        Animates flipping the card over.
    */
    func flip() {
        run(flipSequence)
    }
    
    /**
        Animates moving the card to the supplied coordinates, with optional flip.
 
        - Parameters:
            - x: The x coordinate to move to.
            - y: The y coordinate to move to.
            - flip: Whether to add a flip animation.
            - remove: Whether to remove the card after the animation
    */
    func moveCard(x : CGFloat, y : CGFloat, flip : Bool, remove : Bool) {
        let moveAction = SKAction.move(to: CGPoint(x: x, y: y), duration: 0.5)
        moveAction.timingMode = .easeOut
        if flip {
            if remove {
                zPosition = 1
                run(SKAction.sequence([SKAction.group([moveAction, flipSequence]), SKAction.removeFromParent()]))
            } else {
                run(SKAction.group([moveAction, flipSequence]))
            }
        } else {
            if remove {
                zPosition = 1
                run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
            } else {
                run(moveAction)
            }
        }
    }
    
    override func copy() -> Any {
        let copy = CardView(card: card)
        copy.showFront = self.showFront
        copy.changeSideLayout()
        copy.position = self.position
        return copy
    }
}

