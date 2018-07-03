//
//  PasswordPolicyTipView.swift
//  PasswordPolicyTipView
//
//  Created by MANISH PATHAK on 7/3/18.
//  Copyright © 2018 MANISH PATHAK. All rights reserved.
//

import Foundation
import UIKit

class PasswordPolicyTipView : UIView {
    
    //    public struct Preferences {
    
    //        public struct Drawing {
    //            public var cornerRadius        = CGFloat(5)
    //            public var arrowHeight         = CGFloat(5)
    //            public var arrowWidth          = CGFloat(10)
    //            public var foregroundColor     = UIColor.white
    //            public var backgroundColor     = UIColor.red
    //            public var arrowPosition       = ArrowPosition.any
    //            public var textAlignment       = NSTextAlignment.center
    //            public var borderWidth         = CGFloat(0)
    //            public var borderColor         = UIColor.clear
    //            public var font                = UIFont.systemFont(ofSize: 15)
    //        }
    //
    //        public struct Positioning {
    //            public var bubbleHInset         = CGFloat(1)
    //            public var bubbleVInset         = CGFloat(1)
    //            public var textHInset           = CGFloat(10)
    //            public var textVInset           = CGFloat(10)
    //            public var maxWidth             = CGFloat(200)
    //        }
    //
    //        public struct Animating {
    //            public var dismissTransform     = CGAffineTransform(scaleX: 0.1, y: 0.1)
    //            public var showInitialTransform = CGAffineTransform(scaleX: 0, y: 0)
    //            public var showFinalTransform   = CGAffineTransform.identity
    //            public var springDamping        = CGFloat(0.7)
    //            public var springVelocity       = CGFloat(0.7)
    //            public var showInitialAlpha     = CGFloat(0)
    //            public var dismissFinalAlpha    = CGFloat(0)
    //            public var showDuration         = 0.7
    //            public var dismissDuration      = 0.7
    //            public var dismissOnTap         = true
    //        }
    //
    //        public var drawing      = Drawing()
    //        public var positioning  = Positioning()
    //        public var animating    = Animating()
    //        public var hasBorder : Bool {
    //            return drawing.borderWidth > 0 && drawing.borderColor != UIColor.clear
    //        }
    
//    var xibView: UIView!
    
    @IBOutlet weak var toolTipView: TooltipView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var eightCharacterLabel : UILabel!
    @IBOutlet weak var eightCharacterImgView : UIImageView!
    
    @IBOutlet weak var shouldContainLabel : UILabel!
    @IBOutlet weak var shouldContainImgView : UIImageView!
    
    @IBOutlet weak var upperLowerLabel : UILabel!
    @IBOutlet weak var upperLowerImgView : UIImageView!
    
    @IBOutlet weak var numberLabel : UILabel!
    @IBOutlet weak var numberImgView : UIImageView!
    
    @IBOutlet weak var specialCharLabel : UILabel!
    @IBOutlet weak var specialCharImgView : UIImageView!
    
    var passwordValidator: PasswordValidator!
    
    let greenImage = UIImage(named: "green_tick")
    let redImage = UIImage(named: "red_cross")
    let blackImage = UIImage(named: "black_dot")
    
    func xibSetup() {
        Bundle.main.loadNibNamed("PasswordPolicyTipView", owner: self, options: nil)

        containerView.frame = bounds
        containerView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(containerView)
        
        passwordValidator = PasswordValidator()
    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        xibSetup()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        xibSetup()
    }
    
    func make(label: UILabel, imgView: UIImageView, color: UIColor) {
        label.textColor = color
        
        switch color {
        case .red:
            imgView.image = redImage
        case .green:
            imgView.image = greenImage
        case .black:
            imgView.image = blackImage
        default:
            imgView.image = blackImage
        }
    }
    
    func validatePassword(text: String) {
        if(text.characters.count > 7){
            // green
            self.make(label: eightCharacterLabel, imgView: eightCharacterImgView, color: .green)
            
            
            let hasNumLetters = passwordValidator.isMixOfLettersAndNumbers(text)
            let hasUpperLowerChars = passwordValidator.isMixOfUpperLowercase(text)
            let hasSpecialChars = passwordValidator.hasSpecialCharacter(text)
            //
            if ((hasUpperLowerChars && hasNumLetters) || (hasNumLetters && hasSpecialChars) || (hasUpperLowerChars && hasSpecialChars)) {
                // green should contain
                self.make(label: shouldContainLabel, imgView: shouldContainImgView, color: .green)
                self.isHidden = true
                return
            } else {
                self.make(label: shouldContainLabel, imgView: shouldContainImgView, color: .red)
                self.isHidden = false
            }
            
            if hasUpperLowerChars {
                self.make(label: upperLowerLabel, imgView: upperLowerImgView, color: .green)
            } else {
                self.make(label: upperLowerLabel, imgView: upperLowerImgView, color: .black)
            }
            
            if hasNumLetters {
                self.make(label: numberLabel, imgView: numberImgView, color: .green)
            } else {
                self.make(label: numberLabel, imgView: numberImgView, color: .black)
            }
            
            if hasSpecialChars {
                self.make(label: specialCharLabel, imgView: specialCharImgView, color: .green)
            } else {
                self.make(label: specialCharLabel, imgView: specialCharImgView, color: .black)
            }
            
        } else {
            // red
            self.make(label: eightCharacterLabel, imgView: eightCharacterImgView, color: .red)
        }
        self.isHidden = false
    }
}
