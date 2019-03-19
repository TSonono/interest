//
//  File.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-19.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//

import Foundation

enum AmortizationMode: String {
    // Using raw values to support UserDefaults
    case minimum = "minimum"
    case constant = "constant"
}

class Terms {
    
    var interest:Double = 0.0
    var fees:Int = 0
    var loanAmount:Int = 0
    var loanDebt:Int = 0
    var income:Int = 0
    var amortizationMode:AmortizationMode
    
    init(amortizationMode:AmortizationMode) {
        self.amortizationMode = amortizationMode
    }
}
