//
//  BaseTabBarViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/9/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundImage = UIImage.colorForNavBar(color: .navBarBackgroundColor())
        tabBar.shadowImage = UIImage.colorForNavBar(color: .navBarBorderColor())
    }
}
