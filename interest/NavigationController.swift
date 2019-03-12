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
        //Make the transisition between navigation bar and view seamless
        navigationBar.shadowImage = UIImage()
        navigationBar.backIndicatorImage = UIImage()
        // Do any additional setup after loading the view.
    }

}
