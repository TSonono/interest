//
//  ViewController.swift
//  interest
//
//  Created by Tofik Sonono on 2018-01-15.
//  Copyright © 2018 Tofik Sonono. All rights reserved.
//

import UIKit
import TextFieldEffects

// Global Variables:
var interest:Double!

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var upper: NSLayoutConstraint!
    
    @IBOutlet weak var testKaede: KaedeTextField!
    
    var interestConvert:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        button.layer.cornerRadius = 20  // Make button have an elliptic shape
        button.isHidden = true
        //textField.textAlignment = .center
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.testKaede.becomeFirstResponder()
        }
            // show keyboard directly by default
        
        // animate label text:
        self.upper.constant = 120
        UIView.animate(withDuration: 2.5, delay: 0, usingSpringWithDamping: 0.60, initialSpringVelocity: 3.70, animations: {
            self.labelView.layoutIfNeeded()
        }, completion: nil)
    }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func hideButton(_ sender: UITextField) {            //Continue button only shows when text field not empty
        if (sender.text?.isEmpty == true) {
            button.isHidden = true
        }
        else {
            button.isHidden = false
        }
    }
    
    
    @IBAction func decOrNo(_ sender: UITextField) {
        let cont = ","
        let field = sender.text
        if (field!.contains(cont)) {
            sender.keyboardType = UIKeyboardType.numberPad
        }
        else {
            sender.keyboardType = UIKeyboardType.decimalPad
        }
        sender.reloadInputViews()
    }
    
    @IBAction func setInterest(_ sender: Any) {
        interestConvert = testKaede.text!
        interestConvert = interestConvert.replacingOccurrences(of: ",", with: ".")
        interest = Double(interestConvert)!
    }
    
    

}

