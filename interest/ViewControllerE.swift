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
    
    @IBAction override func hideButton(_ sender: UITextField) {
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

