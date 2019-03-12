//
//  ViewController.swift
//  interest
//
//  Created by Tofik Sonono on 2018-01-15.
//  Copyright © 2018 Tofik Sonono. All rights reserved.
//

import UIKit

class ViewFees: ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is ViewControllerLoan) {
            let nextController = segue.destination as! ViewControllerLoan
            nextController.loanTerms = self.loanTerms
        }
    }
    
    @IBAction override func setOutput(_ sender: Any) {
        loanTerms.fees = Int(inputField.text!)!
        timer.invalidate()
        self.inputField.resignFirstResponder()
        performSegue(withIdentifier: "toLoanAmount", sender: self)
    }
}

