//
//  ViewControllerLoan.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-07.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//


import UIKit

class ViewControllerLoan: ViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is ViewControllerE) {
            let nextController = segue.destination as! ViewControllerE
            nextController.loanTerms = self.loanTerms
        }
    }
    
    @IBAction override func setOutput(_ sender: Any) {
        loanTerms.loanAmount = Int(inputField.text!)!
        timer.invalidate()
        self.inputField.resignFirstResponder()
        performSegue(withIdentifier: "toDebt", sender: self)
    }
    
}

