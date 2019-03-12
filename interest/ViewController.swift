//
//  ViewController.swift
//  interest
//
//  Created by Tofik Sonono on 2018-01-15.
//  Copyright © 2018 Tofik Sonono. All rights reserved.
//

import UIKit

let modelName = UIDevice.modelName
let outOfBoundsTop = -500

// Global Variables:
var interest:Double!

class ViewController: UIViewController {
    
    var timer = Timer()
    
    var initialOriginY:CGFloat!
    var interestConvert:String!
    var hasBecomeFirstResponder:Bool = false
    
    var loanTerms = Terms()
    
    
    @IBOutlet weak var fieldToTopLabel: NSLayoutConstraint!
    @IBOutlet weak var percentToTopLabel: NSLayoutConstraint!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var labelToTop: NSLayoutConstraint!
    @IBOutlet var buttonToField: NSLayoutConstraint!
    @IBOutlet var buttonToBottom: NSLayoutConstraint!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var inputField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.labelToTop.constant = CGFloat(outOfBoundsTop)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.labelToTop.constant = 0
        UIView.animate(withDuration: 1.65, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        scheduledTimerWithTimeInterval()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (modelName.contains("5") || modelName.contains("SE")) {
            fieldToTopLabel.constant = 200
            percentToTopLabel.constant = 200
        }
        else if (modelName == "iPhone 6" || modelName == "iPhone 6s" || modelName == "iPhone 7" || modelName == "Simulator iPhone 8") {
            fieldToTopLabel.constant = 230
            percentToTopLabel.constant = 230
        }
        else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "Simulator iPhone 8 Plus") {
            fieldToTopLabel.constant = 190
            percentToTopLabel.constant = 190
        }
        
        buttonTwo.isHidden = true
        addDoneButtonOnKeyboard()
    
        buttonToBottom.constant = 50
        buttonToBottom.isActive = false
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
        //Prevent first responder automation if user does it manually
            if (self.hasBecomeFirstResponder == false) {
                self.inputField.becomeFirstResponder()
            }
        }
    }
    
    //Ensures button is still circular with aspect ratio constraint on different screen sizes:
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonTwo.layer.cornerRadius = buttonTwo.frame.height / 2.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is ViewFees) {
            let nextController = segue.destination as! ViewFees
            nextController.loanTerms = self.loanTerms
        }
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
        hasBecomeFirstResponder = true
        initialOriginY = self.view.frame.origin.y
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {    //Prevent "black area" when view is raised
            self.view.frame.origin.y = self.initialOriginY - 150
        }
        
    }
    
    @IBAction func lowerView(_ sender: UITextField) {
        self.view.frame.origin.y = initialOriginY
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
    
    @IBAction func setOutput(_ sender: Any) {
        interestConvert = inputField.text!
        interestConvert = interestConvert.replacingOccurrences(of: ",", with: ".")
        loanTerms.interest = Double(interestConvert)!
        interest = Double(interestConvert)!
        timer.invalidate()
        self.inputField.resignFirstResponder()
        performSegue(withIdentifier: "toFees", sender: self)
    }
}

