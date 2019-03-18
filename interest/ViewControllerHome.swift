//
//  ViewControllerHome.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-18.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//



import UIKit
import Lottie

class ViewControllerHome: UIViewController {
    
    @IBOutlet weak var lottieView: LOTAnimatedControl!
    @IBOutlet weak var lottieHeart: LOTAnimatedControl!
    
    var rotationAngle:Double = 0.0
    var timer = Timer()
    
    var loanTerms = Helper.Terms()
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet var videoView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        continueButton.isHidden = false
        lottieHeart.animationView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduledTimerWithTimeInterval()
        
        lottieView.animationView.setAnimation(named: "house.json")
        lottieView.animationView.center = self.view.center
        lottieView.animationView.contentMode = .scaleAspectFill
        lottieView.animationView.loopAnimation = true
        lottieView.animationView.animationSpeed = 0.85
        
        lottieHeart.animationView.setAnimation(named: "star.json")
        lottieHeart.animationView.center = self.view.center
        lottieHeart.animationView.contentMode = .scaleAspectFill
        lottieHeart.animationView.animationSpeed = 1.60
        
        lottieView.animationView.play()
        
        lottieHeart.animationView.isHidden = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is ViewController) {
            let nextController = segue.destination as! ViewController
            nextController.loanTerms = self.loanTerms
        }
    }
    

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        continueButton.pulsate()
        self.rotationAngle += 90.0
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: .curveEaseInOut, animations: {
            self.settingsButton.transform = CGAffineTransform(rotationAngle: CGFloat((self.rotationAngle * .pi) / 180.0))
        })
    }
    
    
    @IBAction func start(_ sender: Any) {
        continueButton.isHidden = true
        lottieHeart.animationView.isHidden = false
        lottieHeart.animationView.play()
        print(lottieHeart.animationView.animationDuration)
        
        //Time in this delay should match the duration of the heart animation
        //Note: The duration is affected by the animation speed, which is not reflected in .animationSpeed
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.85) { [unowned self] in
            self.performSegue(withIdentifier: "toInterest", sender: nil)
        }
    }
}
