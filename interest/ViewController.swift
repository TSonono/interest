//
//  ViewController.swift
//  interest
//
//  Created by Tofik Sonono on 2018-01-15.
//  Copyright © 2018 Tofik Sonono. All rights reserved.
//

import UIKit

// Global Variables:
var interest:Double!

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var upper: NSLayoutConstraint!
    
    var interestConvert:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button.layer.cornerRadius = 20  // Make button have an elliptic shape
        button.isHidden = true
        textField.textAlignment = .center
        textField.becomeFirstResponder()    // show keyboard directly by default
        
        // animate label text:
        self.upper.constant = 120
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.43, initialSpringVelocity: 5.0, animations: {
            self.labelView.layoutIfNeeded()
        }, completion: nil)
    }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func show(_ sender: Any) {            //Continue button only shows when text field not empty
        if (textField.text?.isEmpty == true) {
            button.isHidden = true
        }
        else {
            button.isHidden = false
        }
    }
    

    
    @IBAction func bindning(_ sender: Any) {
        interestConvert = textField.text!
        interestConvert = interestConvert.replacingOccurrences(of: ",", with: ".")
        interest = Double(interestConvert)!
    }
    
    

}

