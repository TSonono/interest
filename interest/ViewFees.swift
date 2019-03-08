//
//  ViewFees.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-07.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//


import UIKit
import TextFieldEffects

// Global Variables:


var fees:Double!


class ViewFees: UIViewController {
    
    var timer = Timer()
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var kaedeFeeField: KaedeTextField!
    @IBOutlet weak var buttonFromBottom: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { //Delay because otherwise the keyboard will not load
            self.scheduledTimerWithTimeInterval()
        }
        
        button.layer.cornerRadius = 20// Make button have an elliptic shape
        button.isHidden = true
        
        
        addDoneButtonOnKeyboard()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { //Delay because otherwise the keyboard will not load
            self.kaedeFeeField.becomeFirstResponder()
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
        if (kaedeFeeField.text?.isEmpty == true) {
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
    
    @IBAction func switchTextFee(_ sender: KaedeTextField) {
        kaedeFeeField.placeholder = "kr"
    }
    
    @IBAction func backTextFee(_ sender: KaedeTextField) {
        if ((kaedeFeeField.text?.isEmpty)!) {
            kaedeFeeField.placeholder = ""
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
    
    @IBAction func setFees(_ sender: Any) {
        fees = Double(kaedeFeeField.text!)
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
        
        self.kaedeFeeField.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction() {
        self.kaedeFeeField.resignFirstResponder()
    }
    
}


