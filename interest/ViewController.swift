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
    
    var initialTextColor:UIColor!
    
    @IBOutlet weak var kaedeToBottom: NSLayoutConstraint!
    @IBOutlet weak var buttonToBottom: NSLayoutConstraint!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var testKaede: KaedeTextField!
    
    var interestConvert:String!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scheduledTimerWithTimeInterval()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testKaede.borderStyle = .none
        
        initialTextColor = testKaede.textColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { //Delay because otherwise the keyboard will not load
            //self.scheduledTimerWithTimeInterval()
        }

        buttonTwo.isHidden = true
        
        addDoneButtonOnKeyboard()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { //Delay because otherwise the keyboard will not load
            self.testKaede.becomeFirstResponder()
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 3.25, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        buttonTwo.pulsate()
    }
    

    @IBAction func hideButton(_ sender: UITextField) {            //Continue button only shows when text field not empty
        if (testKaede.text?.isEmpty == true || sender.text == ",") {
            buttonTwo.isHidden = true
        }
        else if (testKaede.text! == "Ränta") {
            buttonTwo.isHidden = true
            }
        else {
            buttonTwo.isHidden = false
        }
    }
    
    @IBAction func buttonDrop(_ sender: Any) {
        if (testKaede.text! != "Ränta") {
            self.buttonToBottom.constant = 55
        }
        UIView.animate(withDuration: 0.45, delay: 0.15, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @IBAction func buttonRise(_ sender: Any) {
        //buttonTwo.frame.origin.y = 266
        //self.kaedeToBottom.constant = -440
        self.buttonToBottom.constant = 305
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
    
    @IBAction func testKeepText(_ sender: KaedeTextField) {
        if (sender.text?.contains("R") == true || sender.text?.contains("ä") == true || sender.text?.contains("n") == true || sender.text?.contains("t") == true || sender.text?.contains("a") == true) {
            if let selectedRange = sender.selectedTextRange {
                //This is to detect the cursor position. From stackoverflow
                let cursorPosition = sender.offset(from: sender.beginningOfDocument, to: selectedRange.start)
                sender.text = String(sender.text![cursorPosition-1])
                sender.textColor = UIColor.black
            }
        }
        else if (sender.text?.isEmpty == true) {
            sender.text = "Ränta"
            sender.textColor = initialTextColor
            sender.selectedTextRange = sender.textRange(from: sender.beginningOfDocument, to: sender.beginningOfDocument)
        }
    }
    @IBAction func switchTextFee(_ sender: KaedeTextField) {
        if (sender.text == "Ränta") {
            sender.selectedTextRange = sender.textRange(from: sender.beginningOfDocument, to: sender.beginningOfDocument)
        }
        sender.placeholder = "%"
    }
    
    @IBAction func backTextFee(_ sender: KaedeTextField) {
        if ((sender.text?.isEmpty)!) {
            sender.placeholder = ""
            sender.text = "Ränta"
            sender.textColor = initialTextColor
        }
        else if (sender.text == "Ränta") {
            sender.placeholder = ""
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

