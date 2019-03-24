//
//  ViewControllerAck.swift
//  interest
//
//  Created by Tofik Sonono on 2019-03-24.
//  Copyright © 2019 Tofik Sonono. All rights reserved.
//

import UIKit
import AcknowList

class ViewControllerAck: AcknowListViewController{
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
