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


extension UITextField {         //Ensures no ability to paste in the text fields
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.cut) || action == #selector(UIResponderStandardEditActions.copy)
    }
}

class ViewController: UIViewController {
    
    var timer = Timer()
    
    var initialTextColor:UIColor!
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var labelToTop: NSLayoutConstraint!
    @IBOutlet var buttonToField: NSLayoutConstraint!
    @IBOutlet var buttonToBottom: NSLayoutConstraint!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var inputField: UITextField!
    
    var interestConvert:String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.labelToTop.constant = -300
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.labelToTop.constant = 0
        UIView.animate(withDuration: 1.65, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        scheduledTimerWithTimeInterval()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.labelToTop.constant = -300
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonTwo.isHidden = true
        addDoneButtonOnKeyboard()
    
        buttonToBottom.constant = 50
        buttonToBottom.isActive = false
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { //Delay because otherwise the keyboard will not load
            self.inputField.becomeFirstResponder()
        }
        
        
    }
    //Ensures button is still circular with aspect ratio constraint on different screen sizes:
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonTwo.layer.cornerRadius = buttonTwo.frame.height / 2.0
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
        if (sender.text?.isEmpty == true || sender.text == ",") {
            buttonTwo.isHidden = true
        }
        else {
            buttonTwo.isHidden = false
        }
    }
    
    @IBAction func buttonDrop(_ sender: Any) {
        buttonToField.isActive = false
        buttonToBottom.isActive = true
        //self.buttonToField.constant = 250
        UIView.animate(withDuration: 0.45, delay: 0.0, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @IBAction func buttonRise(_ sender: Any) {
        buttonToField.isActive = true
        buttonToBottom.isActive = false
        //self.buttonToField.constant = 25
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
    
    
    @IBAction func raiseView(_ sender: UITextField) {
        self.view.frame.origin.y -= 90
    }
    
    @IBAction func lowerView(_ sender: UITextField) {
        self.view.frame.origin.y += 90
    }
    
    
    @IBAction func setInterest(_ sender: Any) {
        interestConvert = inputField.text!
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
        
        self.inputField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.inputField.resignFirstResponder()
    }
}

