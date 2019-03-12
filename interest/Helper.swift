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
    
    enum AmortizationMode {
        case minimum
        case constant
    }
    
    struct Terms {
        var interest:Double = 0.0
        var fees:Int = 0
        var loanAmount:Int = 0
        var loanDebt:Int = 0
        var income:Int = 0
        var amortizationMode: AmortizationMode = AmortizationMode.minimum
    }
}
