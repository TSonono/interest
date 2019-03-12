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
    
    static func setDeviceConstraints(modelName: String, fieldToTopLabel: NSLayoutConstraint, percentToTopLabel: NSLayoutConstraint) -> (fieldToTopLabelConstant: CGFloat, percentToTopLabelConstant: CGFloat) {
        if (modelName.contains("5") || modelName.contains("SE")) {
            return (170, 170)
        }
        else if (modelName == "iPhone 6" || modelName == "iPhone 6s" || modelName == "iPhone 7" || modelName == "Simulator iPhone 8") {
            return (230, 230)
        }
        else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "Simulator iPhone 8 Plus") {
            return (190, 190)
        }
        else{
            return (fieldToTopLabel.constant, percentToTopLabel.constant)
        }
    }
}
