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

class ViewController: UIViewController {
    
    var timer = Timer()
    
    var initialOriginY:CGFloat!
    var interestConvert:String!
    var hasBecomeFirstResponder:Bool = false
    
    var loanTerms = Helper.Terms()
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        (self.fieldToTopLabel.constant, self.percentToTopLabel.constant) = Helper.setDeviceConstraints(modelName: modelName, fieldToTopLabel: self.fieldToTopLabel, percentToTopLabel: self.percentToTopLabel)
        
        buttonTwo.isHidden = true
        inputField.addDoneButtonOnKeyboard()
    
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
        timer = Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        buttonTwo.pulsate()
    }

    @IBAction func hideButton(_ sender: UITextField) {
        //Continue button only shows when text field not empty
        if (sender.text?.isEmpty == true || sender.text == ",") {
            buttonTwo.isHidden = true
        }
        else {
            buttonTwo.isHidden = false
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        hasBecomeFirstResponder = true
        initialOriginY = self.view.frame.origin.y
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == initialOriginY {
                self.view.frame.origin.y -= 150
            }
        }
        buttonRise()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            //self.view.frame.origin.y = 88
            self.view.frame.origin.y = initialOriginY
        }
        buttonDrop()
    }
    
    func buttonDrop() {
        buttonToField.isActive = false
        buttonToBottom.isActive = true
        //self.buttonToField.constant = 250
        UIView.animate(withDuration: 0.45, delay: 0.0, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func buttonRise() {
        buttonToField.isActive = true
        buttonToBottom.isActive = false
        //self.buttonToField.constant = 25
    }
    
    @IBAction func setOutput(_ sender: Any) {
        interestConvert = inputField.text!
        interestConvert = interestConvert.replacingOccurrences(of: ",", with: ".")
        loanTerms.interest = Double(interestConvert)!
        self.inputField.resignFirstResponder()
        performSegue(withIdentifier: "toFees", sender: self)
    }
}

