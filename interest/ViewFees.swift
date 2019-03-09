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
    var initialTextColor:UIColor!
    
    
    @IBOutlet weak var kaedeToBottom: NSLayoutConstraint!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var kaedeFeeField: KaedeTextField!
    @IBOutlet weak var buttonFromBottom: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialTextColor = kaedeFeeField.textColor
        
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
    
    @IBAction func buttonDrop(_ sender: KaedeTextField) {
        if (sender.text! == "Avgift") {
            self.kaedeToBottom.constant = 0
        }
        else {
            self.buttonFromBottom.constant = 120
        }
        UIView.animate(withDuration: 0.45, delay: 0.15, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func buttonRise(_ sender: Any) {
        self.buttonFromBottom.constant = 325
        
        self.kaedeToBottom.constant = 440

    }
    
    @IBAction func testKeepText(_ sender: KaedeTextField) {
        if (sender.text?.contains("A") == true || sender.text?.contains("v") == true || sender.text?.contains("g") == true || sender.text?.contains("i") == true || sender.text?.contains("f") == true || sender.text?.contains("t") == true) {
            if let selectedRange = sender.selectedTextRange {
                //This is to detect the cursor position. From stackoverflow
                let cursorPosition = sender.offset(from: sender.beginningOfDocument, to: selectedRange.start)
                sender.text = String(sender.text![cursorPosition-1])
                sender.textColor = UIColor.black
            }
        }
        else if (sender.text?.isEmpty == true) {
            sender.text = "Avgift"
            sender.textColor = initialTextColor
            sender.selectedTextRange = sender.textRange(from: sender.beginningOfDocument, to: sender.beginningOfDocument)
        }
    }
    
    @IBAction func switchTextFee(_ sender: KaedeTextField) {
        if (sender.text == "Avgift") {
            sender.selectedTextRange = sender.textRange(from: sender.beginningOfDocument, to: sender.beginningOfDocument)
        }
        sender.placeholder = "kr"
    }
    
    @IBAction func backTextFee(_ sender: KaedeTextField) {
        if ((sender.text?.isEmpty)!) {
            sender.placeholder = ""
            sender.text = "Avgift"
            sender.textColor = initialTextColor
        }
        else if (sender.text == "Avgift") {
            sender.placeholder = ""
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


