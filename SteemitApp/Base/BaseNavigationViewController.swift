//
//  BaseNavigationViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/9/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.tintColor = UIColor.navBarBackgroundColor()
        navigationBar.barTintColor = UIColor.navBarBackgroundColor()
        navigationBar.backItem?.backBarButtonItem?.tintColor = UIColor.barTintColor()
        
        navigationBar.setBackgroundImage(UIColor.clear.as1ptImage(), for: .default)
        navigationBar.shadowImage = UIColor.navBarBorderColor().as1ptImage()
    }
}
