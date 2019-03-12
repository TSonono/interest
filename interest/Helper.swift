//
//  Helper.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-12.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//

import Foundation
import UIKit


class Helper {
    
    
    
    static func addDoneButtonOnKeyboard(inputField: UITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        inputField.inputAccessoryView = doneToolbar
    }
    
    @objc static func doneButtonAction(inputField: UITextField) {
        inputField.resignFirstResponder()
    }
}
