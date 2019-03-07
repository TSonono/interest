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
var fees:Double!



extension UITextField {         //Ensures no ability to paste in the text fields
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.cut) || action == #selector(UIResponderStandardEditActions.copy)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var upper: NSLayoutConstraint!
    
    @IBOutlet weak var testKaede: KaedeTextField!
    @IBOutlet weak var kaedeFeeField: KaedeTextField!
    
    var interestConvert:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        button.layer.cornerRadius = 20  // Make button have an elliptic shape
        button.isHidden = true
        //textField.textAlignment = .center
        
        addDoneButtonOnKeyboard()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { //Delay because otherwise the keyboard will not load
            self.kaedeFeeField.becomeFirstResponder()
        }
            // show keyboard directly by default
        
        // animate label text:
        self.upper.constant = 12
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.43, initialSpringVelocity: 5.0, animations: {
            self.labelView.layoutIfNeeded()
        }, completion: nil)
    }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func hideButton(_ sender: UITextField) {            //Continue button only shows when text field not empty
        if (testKaede.text?.isEmpty == true || kaedeFeeField.text?.isEmpty == true || sender.text == ",") {
            button.isHidden = true
        }
        else {
            button.isHidden = false
        }
    }
    
    @IBAction func switchTextFee(_ sender: KaedeTextField) {
        kaedeFeeField.placeholder = "kr"
    }
    
    @IBAction func backTextFee(_ sender: KaedeTextField) {
        if ((kaedeFeeField.text?.isEmpty)!) {
        kaedeFeeField.placeholder = "Fees"
        }
    }
    
    @IBAction func switchTextInterest(_ sender: KaedeTextField) {
        testKaede.placeholder = "%"
    }
    
    @IBAction func backTextInterest(_ sender: KaedeTextField) {
        if ((testKaede.text?.isEmpty)!) {
            testKaede.placeholder = "Interest"
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
        fees = Double(kaedeFeeField.text!)
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
        
        self.testKaede.inputAccessoryView = doneToolbar
        self.kaedeFeeField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.testKaede.resignFirstResponder()
        self.kaedeFeeField.resignFirstResponder()
    }

}

