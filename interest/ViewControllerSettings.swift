//
//  ViewControllerSettings.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-18.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//

import UIKit
import Lottie

class ViewControllerSettings: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var modeSwitch: UISwitch!
    @IBOutlet weak var lottieView: LOTAnimatedControl!
    
    var loanTerms:Terms!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modeSwitch.isOn =  UserDefaults.standard.bool(forKey: "switchState")
        navigationController?.delegate = self   //For passing data back to previous view controller
        
        lottieView.animationView.setAnimation(named: "wallet.json")
        lottieView.animationView.center = self.view.center
        lottieView.animationView.contentMode = .scaleAspectFill
        lottieView.animationView.animationSpeed = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.lottieView.animationView.play()
        }
        lottieView.animationView.play()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func toggled(_ sender: Any) {
        if modeSwitch.isOn {
            loanTerms.amortizationMode = AmortizationMode.constant
        }
        else {
            loanTerms.amortizationMode = AmortizationMode.minimum
        }
        UserDefaults.standard.set(loanTerms.amortizationMode.rawValue, forKey: "amortizationMode")
    }
    @IBAction func saveSwitch(_ sender: UISwitch) {
        //Saves switcher postion between sesstions
        UserDefaults.standard.set(sender.isOn, forKey: "switchState")
    }
}

extension ViewControllerSettings {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? ViewControllerHome)?.loanTerms = self.loanTerms
    }
}
