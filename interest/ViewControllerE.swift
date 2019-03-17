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
    
    
    @IBOutlet weak var tipLabelToLeft: NSLayoutConstraint!
    @IBOutlet weak var tipLabelToRight: NSLayoutConstraint!
    @IBOutlet weak var tipLabel: UILabel!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if (self.tipLabel.text == "Skulden får inte vara större än lånebeloppet!") {
            self.tipLabelToLeft.constant = -915
            self.tipLabelToRight.constant = 925
        }
        else {
            self.tipLabelToLeft.constant = 425
            self.tipLabelToRight.constant = -405
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideTip(inputField)
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.80, initialSpringVelocity: 4.0, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipLabel.layer.masksToBounds = true
        tipLabel.layer.cornerRadius = 20
                
        //Animate label text:

        
        buttonToField.isActive = false
        buttonToBottom.isActive = true
        buttonTwo.isHidden = false
    }
    
    @IBAction func hideTip(_ sender: UITextField) {
        var currentVal:Int
        if (sender.text?.isEmpty == false) {
            currentVal = Int(sender.text!)!
        }
        else {
            currentVal = 0
        }
        
        if (sender.text?.isEmpty == true) {
            self.tipLabelToLeft.constant = 425
            self.tipLabelToRight.constant = -405
            self.view.layoutIfNeeded()
            self.tipLabelToLeft.constant = 10
            self.tipLabelToRight.constant = 10
            
            tipLabel.text = "Tips: Lämna fältet tomt om du planerar att ta lån!"
            tipLabel.backgroundColor = UIColor(red: 87/255, green: 95/255, blue: 207/255, alpha: 1.0)
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.80, initialSpringVelocity: 4.0, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        else if (currentVal > loanTerms.loanAmount) {
            if (self.tipLabelToLeft.constant != 10) {
                self.tipLabelToLeft.constant = -405
                self.tipLabelToRight.constant = 425
                self.view.layoutIfNeeded()
                self.tipLabelToLeft.constant = 10
                self.tipLabelToRight.constant = 10
                
                tipLabel.text = "Skulden får inte vara större än lånebeloppet!"
                tipLabel.backgroundColor = UIColor(red: 245/255, green: 59/255, blue: 87/255, alpha: 1.0)
                UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.80, initialSpringVelocity: 4.0, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
            
        }
        else {
            if (self.tipLabel.text == "Skulden får inte vara större än lånebeloppet!") {
                self.tipLabelToLeft.constant = -915
                self.tipLabelToRight.constant = 925
            }
            else {
                self.tipLabelToLeft.constant = 425
                self.tipLabelToRight.constant = -405
            }
            UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
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

