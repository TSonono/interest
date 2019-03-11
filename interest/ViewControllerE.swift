//
//  ViewControllerE.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-05.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//

import UIKit
import TextFieldEffects


// Global Variables:
var loanDebt:Int!


class ViewControllerE: UIViewController {
    
    var loanTerms = Terms()
    
    @IBOutlet weak var buttonFromBottom: NSLayoutConstraint!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    //@IBOutlet weak var debtField: UITextField!
    
    @IBOutlet weak var debtFieldKaede: KaedeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        continueButton.layer.cornerRadius = 20  // Make continueButton have an elliptic shape
        tipLabel.layer.masksToBounds = true
        tipLabel.layer.cornerRadius = 20
        
        addDoneButtonOnKeyboard()
        //debtField.textAlignment = .center
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            self.debtFieldKaede.becomeFirstResponder()
        }
        
        // animate label text:

        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.80, initialSpringVelocity: 4.0, animations: {
            self.tipLabel.frame.origin.x = 4
        }, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func hideButton(_ sender: UITextField) {            //Continue continueButton only shows when text field not empty
        var currentVal:Int
        if (sender.text?.isEmpty == false) {
            currentVal = Int(sender.text!)!
        }
        else {
            currentVal = 0
        }
        if (currentVal > loanAmount) {
            continueButton.isHidden = true
        }
        else {
            continueButton.isHidden = false
        }
    }
    
    @IBAction func buttonDrop(_ sender: Any) {
        self.buttonFromBottom.constant = 150
    }
    
    @IBAction func buttonRise(_ sender: Any) {
        self.buttonFromBottom.constant = 270
    }
    
    
    
    @IBAction func hideTip(_ sender: KaedeTextField) {
        var currentVal:Int
        if (sender.text?.isEmpty == false) {
            currentVal = Int(sender.text!)!
        }
        else {
            currentVal = 0
        }
        
        if (sender.text?.isEmpty == true) {
            self.tipLabel.frame.origin.x = 390
            tipLabel.text = "Tips: Lämna fältet tomt om du planerar att ta lån!"
            tipLabel.backgroundColor = UIColor(red: 87/255, green: 95/255, blue: 207/255, alpha: 1.0)
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.80, initialSpringVelocity: 4.0, animations: {
                self.tipLabel.frame.origin.x = 4
            }, completion: nil)
        }
        else if (currentVal > loanAmount) {
            if (self.tipLabel.frame.origin.x != 4) {
                self.tipLabel.frame.origin.x = -390
                tipLabel.text = "Skulden får inte vara större än lånebeloppet!"
                tipLabel.backgroundColor = UIColor(red: 245/255, green: 59/255, blue: 87/255, alpha: 1.0)
                UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.80, initialSpringVelocity: 4.0, animations: {
                    self.tipLabel.frame.origin.x = 4
                }, completion: nil)
            }

        }
        else {
            UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                if (self.tipLabel.text == "Skulden får inte vara större än lånebeloppet!") {
                    self.tipLabel.frame.origin.x = -390
                }
                else {
                    self.tipLabel.frame.origin.x = 390
                }

            }, completion: nil)
        }
    }
    
    
    @IBAction func setDebt(_ sender: Any) {
        if ((debtFieldKaede.text?.isEmpty)!) {
            loanDebt = loanAmount
        }
        else {
            loanDebt = Int(debtFieldKaede.text!)
        }
        performSegue(withIdentifier: "toResult", sender: self)
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(ViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.debtFieldKaede.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.debtFieldKaede.resignFirstResponder()
    }
    
    @IBAction func switchTextFee(_ sender: KaedeTextField) {
        debtFieldKaede.placeholder = "kr"
    }
    
    @IBAction func backTextFee(_ sender: KaedeTextField) {
        if ((debtFieldKaede.text?.isEmpty)!) {
            debtFieldKaede.placeholder = ""
        }
    }

}

