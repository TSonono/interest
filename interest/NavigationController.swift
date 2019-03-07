//
//  NavigationController.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-07.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage()
        navigationBar.backIndicatorImage = UIImage()
        //self.navigationController!.navigationBar.layer.zPosition = -1;
        // Do any additional setup after loading the view.
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
