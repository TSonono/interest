//
//  UIButtonExtension.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-07.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 1.75
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = false
        pulse.repeatCount = 0
        pulse.initialVelocity = 0.7
        pulse.damping = 0.95
        
        layer.add(pulse, forKey: "pulse")
}

}
