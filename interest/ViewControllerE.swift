//
//  ViewControllerE.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-05.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//

//TODO: Add the tip and warning animation from the previous version of this page

import UIKit

class ViewControllerE: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if (modelName.contains("5") || modelName.contains("SE")) {
            fieldToTopLabel.constant = 200
            percentToTopLabel.constant = 200
        }
        else if (modelName == "iPhone 6" || modelName == "iPhone 6s" || modelName == "iPhone 7" || modelName == "Simulator iPhone 8") {
            fieldToTopLabel.constant = 230
            percentToTopLabel.constant = 230
        }
        else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "Simulator iPhone 8 Plus") {
            fieldToTopLabel.constant = 190
            percentToTopLabel.constant = 190
        }
        
        buttonTwo.isHidden = false
        inputField.addDoneButtonOnKeyboard()
        
        buttonToBottom.constant = 50
        buttonToBottom.isActive = false
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            //Prevent first responder automation if user does it manually
            if (self.hasBecomeFirstResponder == false) {
                self.inputField.becomeFirstResponder()
            }
        }
    }
    
    override func hideButton(_ sender: UITextField) {
        var currentVal:Int!
        if (sender.text?.isEmpty == false) {
            currentVal = Int(sender.text!)!
        }
        else {
            currentVal = 0
        }
        if (currentVal > loanTerms.loanAmount) {
            buttonTwo.isHidden = true
        }
        else {
            buttonTwo.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is ViewController2) {
            let nextController = segue.destination as! ViewController2
            nextController.loanTerms = self.loanTerms
        }
    }
    
    @IBAction override func setOutput(_ sender: Any) {
        if ((self.inputField.text?.isEmpty)!) {
            loanTerms.loanDebt = loanTerms.loanAmount
        }
        else {
            loanTerms.loanDebt = Int(inputField.text!)!
        }
        timer.invalidate()
        self.inputField.resignFirstResponder()
        performSegue(withIdentifier: "toResult", sender: self)
    }

}

