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
        navigationController?.delegate = self
        
        lottieView.animationView.setAnimation(named: "wallet.json")
        lottieView.animationView.center = self.view.center
        lottieView.animationView.contentMode = .scaleAspectFill
        lottieView.animationView.animationSpeed = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.lottieView.animationView.play()
        }
        lottieView.animationView.play()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func toggled(_ sender: Any) {
        if modeSwitch.isOn {
            loanTerms.amortizationMode = AmortizationMode.minimum
        }
        else {
            loanTerms.amortizationMode = AmortizationMode.constant
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewControllerSettings {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? ViewControllerHome)?.loanTerms = self.loanTerms
    }
}
