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
var loanAmount:Int!


class ViewControllerE: UIViewController {
    
    
    @IBOutlet weak var continueButton: UIButton!
    //@IBOutlet weak var debtField: UITextField!
    @IBOutlet weak var questionLabel: UIView!
    @IBOutlet weak var upperConst: NSLayoutConstraint!
    
    @IBOutlet weak var debtFieldKaede: KaedeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        continueButton.layer.cornerRadius = 20  // Make continueButton have an elliptic shape
        continueButton.isHidden = true
        //debtField.textAlignment = .center
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.debtFieldKaede.becomeFirstResponder()
        }
        
        // animate label text:
        self.upperConst.constant = 120
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.43, initialSpringVelocity: 5.0, animations: {
            self.questionLabel.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func hideButton(_ sender: UITextField) {            //Continue continueButton only shows when text field not empty
        if (sender.text!.isEmpty) {
            continueButton.isHidden = true
        }
        else {
            continueButton.isHidden = false
        }
    }
    
    
    
    @IBAction func setDebt(_ sender: Any) {
        loanAmount = Int(debtFieldKaede.text!)
    }

}

