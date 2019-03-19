//
//  VideoViewController.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-08.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    
    var rotationAngle:Double = 0.0
    var timer = Timer()
    var player:AVPlayer!
    var path:URL!
    var newLayer:AVPlayerLayer!
    
    var loanTerms = Terms()

    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet var videoView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduledTimerWithTimeInterval()
        setupVideo()
        
        NotificationCenter.default.addObserver(self, selector:#selector(VideoViewController.shutItDown), name: UIApplication.didEnterBackgroundNotification, object: UIApplication.shared)
        NotificationCenter.default.addObserver(self, selector:#selector(VideoViewController.methodToRefresh), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(VideoViewController.runAgain), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is ViewController) {
            let nextController = segue.destination as! ViewController
            nextController.loanTerms = self.loanTerms
        }
    }
    
    @objc func runAgain() {
        let t1 = CMTimeMake(value: 0, timescale: 100);
        player.seek(to: t1)
        player.play()
        //
    }
    
    @objc func methodToRefresh() {
        setupVideo()
    }
    
    @objc func shutItDown() {
        self.newLayer.removeFromSuperlayer()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupVideo() {
        
        self.path = URL(fileURLWithPath: Bundle.main.path(forResource: "coined", ofType: "mov")!)
        self.player = AVPlayer(url: self.path)

        self.newLayer = AVPlayerLayer(player: self.player)
        self.newLayer.frame = self.videoView.frame
        self.videoView.layer.addSublayer(newLayer)
        newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        player.isMuted = true
        self.player.play()
        
        self.videoView.bringSubviewToFront(continueButton)
        self.videoView.bringSubviewToFront(settingsButton)
        
        self.videoView.bringSubviewToFront(infoButton)
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
        performSegue(withIdentifier: "toInterest", sender: self)
    }
}
