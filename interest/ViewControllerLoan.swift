//
//  ViewControllerLoan.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-07.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//


import UIKit
import TextFieldEffects

var loanAmount:Int!

class ViewControllerLoan: UIViewController {

    var loanTerms = Terms()
    
    @IBOutlet weak var buttonFromBottom: NSLayoutConstraint!
    @IBOutlet weak var continueButton: UIButton!
    //@IBOutlet weak var debtField: UITextField!
    
    @IBOutlet weak var debtFieldKaede: KaedeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        continueButton.layer.cornerRadius = 20  // Make continueButton have an elliptic shape
        continueButton.isHidden = true
        
        addDoneButtonOnKeyboard()
        //debtField.textAlignment = .center
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            self.debtFieldKaede.becomeFirstResponder()
        }
        
        // animate label text:
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
    
    @IBAction func buttonDrop(_ sender: Any) {
        self.buttonFromBottom.constant = 150
    }
    
    @IBAction func buttonRise(_ sender: Any) {
        self.buttonFromBottom.constant = 270
    }
    
    
    

    
    
    @IBAction func setDebt(_ sender: Any) {
        loanAmount = Int(debtFieldKaede.text!)
        performSegue(withIdentifier: "toDebt", sender: self)
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
        
        self.debtFieldKaede.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.debtFieldKaede.resignFirstResponder()
    }
    
    @IBAction func switchTextFee(_ sender: KaedeTextField) {
        debtFieldKaede.placeholder = "kr"
    }
    
    @IBAction func backTextFee(_ sender: KaedeTextField) {
        if ((debtFieldKaede.text?.isEmpty)!) {
            debtFieldKaede.placeholder = ""
        }
    }
    
}

