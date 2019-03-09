//
//  TestViewController.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-08.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class TestViewController: UIViewController {
    
    
    @IBOutlet weak var videoView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideo()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupVideo() {
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "coined", ofType: "mov")!)
        let player = AVPlayer(url: path)
        
        let newLayer = AVPlayerLayer(player: player)
        newLayer.frame = self.videoView.frame
        self.videoView.layer.addSublayer(newLayer)
        newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        player.play()
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

