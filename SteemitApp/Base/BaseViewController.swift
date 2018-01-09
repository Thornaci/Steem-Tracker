//
//  BaseViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let versionLabel = UILabel.init(frame: CGRect.init(x: 20, y: view.frame.height - 20, width: view.frame.width - 20, height: 20))
        view.addSubview(versionLabel)
    }
}
