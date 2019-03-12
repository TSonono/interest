//
//  ViewController.swift
//  interest
//
//  Created by Tofik Sonono on 2018-01-15.
//  Copyright © 2018 Tofik Sonono. All rights reserved.
//

import UIKit


// Global Variables:
//TODO: Get rid of this using the created struct
var fees:Int!

class ViewFees: ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    @IBAction override func setOutput(_ sender: Any) {
        fees = Int(inputField.text!)
        loanTerms.fees = Int(inputField.text!)!
        timer.invalidate()
        self.inputField.resignFirstResponder()
        performSegue(withIdentifier: "toLoanAmount", sender: self)
    }
}

