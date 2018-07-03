//
//  ViewController.swift
//  PasswordPolicyTipView
//
//  Created by MANISH PATHAK on 7/3/18.
//  Copyright © 2018 MANISH PATHAK. All rights reserved.
//

import UIKit

class TipViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var toolTipView : TooltipView!
    
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
    
    let greenImage = UIImage(named: "green_tick")
    let redImage = UIImage(named: "red_cross")
    let blackImage = UIImage(named: "black_dot")
    
    var passwordValidator: PasswordValidator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initPasswordPolicy()
        passwordValidator = PasswordValidator()
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.becomeFirstResponder()

    }
    
    func initPasswordPolicy() {
        self.eightCharacterImgView.image = redImage
        self.shouldContainImgView.image = redImage
        self.upperLowerImgView.image = blackImage
        self.numberImgView.image = blackImage
        self.specialCharImgView.image = blackImage
        
        self.eightCharacterLabel.textColor = .red
        self.shouldContainLabel.textColor = .red
        self.upperLowerLabel.textColor = .black
        self.numberLabel.textColor = .black
        self.specialCharLabel.textColor = .black
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
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let text = textField.text!
        
//        let (isValid, msg) = isValidPassword(textField.text!)
        
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
                self.toolTipView.isHidden = true
            } else {
                self.make(label: shouldContainLabel, imgView: shouldContainImgView, color: .red)
                self.toolTipView.isHidden = false
                self.toolTipView.setNeedsDisplay()
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

    }


}

