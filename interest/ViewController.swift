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


extension UITextField {         //Ensures no ability to paste in the text fields
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.cut) || action == #selector(UIResponderStandardEditActions.copy)
    }
}

class ViewController: UIViewController {
    
    var timer = Timer()
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var buttonFromBottom: NSLayoutConstraint!
    @IBOutlet weak var testKaede: KaedeTextField!
    
    var interestConvert:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { //Delay because otherwise the keyboard will not load
            self.scheduledTimerWithTimeInterval()
        }
        
        button.layer.cornerRadius = 20  // Make button have an elliptic shape
        button.isHidden = true
        //textField.textAlignment = .center
        
        addDoneButtonOnKeyboard()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { //Delay because otherwise the keyboard will not load
            self.testKaede.becomeFirstResponder()
        }
            // show keyboard directly by default
        
    }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        button.pulsate()
    }
    

    @IBAction func hideButton(_ sender: UITextField) {            //Continue button only shows when text field not empty
        if (testKaede.text?.isEmpty == true || sender.text == ",") {
            button.isHidden = true
        }
        else {
            button.isHidden = false
        }
    }
    
    @IBAction func buttonDrop(_ sender: Any) {
        self.buttonFromBottom.constant = 150
    }
    
    @IBAction func buttonRise(_ sender: Any) {
        self.buttonFromBottom.constant = 270
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
    
    @IBAction func switchTextFee(_ sender: KaedeTextField) {
        testKaede.placeholder = "%"
    }
    
    @IBAction func backTextFee(_ sender: KaedeTextField) {
        if ((testKaede.text?.isEmpty)!) {
            testKaede.placeholder = ""
        }
    }
    
    @IBAction func setInterest(_ sender: Any) {
        interestConvert = testKaede.text!
        interestConvert = interestConvert.replacingOccurrences(of: ",", with: ".")
        interest = Double(interestConvert)!
        timer.invalidate()
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
    }
    
    @objc func doneButtonAction() {
        self.testKaede.resignFirstResponder()
    }

}

