//
//  ViewController.swift
//  PasswordPolicyTipView
//
//  Created by MANISH PATHAK on 7/3/18.
//  Copyright © 2018 MANISH PATHAK. All rights reserved.
//

import UIKit

class TipViewControllerSample2: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    var passwordPolicyTipView : PasswordPolicyTipView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initPasswordPolicy()
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.becomeFirstResponder()

    }
    
    func initPasswordPolicy() {
        self.passwordPolicyTipView = PasswordPolicyTipView.init(frame: CGRect.init(x: 0, y: textField.frame.origin.y - 178, width: 248, height: 168))
        self.view.addSubview(passwordPolicyTipView)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text!
        passwordPolicyTipView.validatePassword(text: text)
    }
}

