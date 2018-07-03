//
//  PasswordValidator.swift
//  PasswordPolicyTipView
//
//  Created by MANISH PATHAK on 7/3/18.
//  Copyright © 2018 MANISH PATHAK. All rights reserved.
//

import Foundation

class PasswordValidator {
    
    func isMixOfLettersAndNumbers(_ text: String) -> Bool {
        let regEx = "(?=.*[A-Za-z])(?=.*\\d).*"
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: text)
    }
    
    func isMixOfUpperLowercase(_ text: String) -> Bool {
        let regEx = "(?=.*[A-Z])(?=.*[a-z]).*"
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: text)
    }
    
    func hasSpecialCharacter(_ text: String) -> Bool {
        let regEx = "(?=.*[$@$!%*#?&]).*"
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: text)
    }
}
