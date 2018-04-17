//
//  ButtonSprite.swift
//  Blackjack is Back
//
//  Created by Ian Stewart on 12/04/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

import SpriteKit

class ButtonSprite : SKSpriteNode {
    
    enum ButtonType : String, Codable {
        case Full,
        Left,
        Right
    }
    
    var delegate : ButtonSpriteDelegate?
    
    private var enabled = true
    
    static let baseFullTexture = SKTexture(image: #imageLiteral(resourceName: "GoldButtonImage"))
    static let pressedFullTexture = SKTexture(image: #imageLiteral(resourceName: "RedButtonImage"))
    static let disabledFullTexture = SKTexture(image: #imageLiteral(resourceName: "GreyButtonImage"))
    
    static let baseLeftTexture = SKTexture(image: #imageLiteral(resourceName: "LeftGoldButtonImage"))
    static let pressedLeftTexture = SKTexture(image: #imageLiteral(resourceName: "LeftRedButtonImage"))
    static let disabledLeftTexture = SKTexture(image: #imageLiteral(resourceName: "LeftGreyButtonImage"))
    
    static let baseRightTexture = SKTexture(image: #imageLiteral(resourceName: "RightGoldButtonImage"))
    static let pressedRightTexture = SKTexture(image: #imageLiteral(resourceName: "RightRedButtonImage"))
    static let disabledRightTexture = SKTexture(image: #imageLiteral(resourceName: "RightGreyButtonImage"))
    
    var baseTexture : SKTexture!
    var pressedTexture : SKTexture!
    var disabledTexture : SKTexture!
    
    init(text : String, size : CGSize, buttonType : ButtonType) {
        super.init(texture: ButtonSprite.baseFullTexture, color: .clear, size: size)
        
        zPosition = 5
        
        setupLabel(text: text)
        
        isUserInteractionEnabled = true
        
        setTextures(buttonType: buttonType)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setTextures(buttonType: .Full)
        
        isUserInteractionEnabled = true
    }
    
    /**
        Set the textures to display for this button type.
     
        - Parameters:
            - buttonType: The type of button to retrieve textures for.
    */
    func setTextures(buttonType : ButtonType) {
        switch buttonType {
        case .Full:
            baseTexture = ButtonSprite.baseFullTexture
            pressedTexture = ButtonSprite.pressedFullTexture
            disabledTexture = ButtonSprite.disabledFullTexture
        case .Left:
            baseTexture = ButtonSprite.baseLeftTexture
            pressedTexture = ButtonSprite.pressedLeftTexture
            disabledTexture = ButtonSprite.disabledLeftTexture
        case .Right:
            baseTexture = ButtonSprite.baseRightTexture
            pressedTexture = ButtonSprite.pressedRightTexture
            disabledTexture = ButtonSprite.disabledRightTexture
        }
    }
    
    /**
        Sets whether this button is enabled for touch interactions.
     
        - Parameters:
            - enabled: True for enabled, otherwise false.
    */
    func setButtonEnabled(enabled : Bool) {
        self.enabled = enabled
        texture = self.enabled ? baseTexture : disabledTexture
    }
    
    /**
        Sets up the label to display on the button.
     
        - Parameters:
            - text: The text to display on the label.
    */
    func setupLabel(text : String) {
        let label = SKLabelNode(text: text)
        label.fontColor = .black
        label.fontName = C.Fonts.HN_BOLD
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.zPosition = 5
        addChild(label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if enabled {
            texture = pressedTexture
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if enabled {
            texture = baseTexture
        }
        for t in touches {
            let location = t.location(in: self)
            if location.x.magnitude < self.size.width / 2 && location.y.magnitude < self.size.height / 2 {
                delegate?.buttonHit(sender: self)
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if enabled {
            texture = pressedTexture
        }
    }
}
