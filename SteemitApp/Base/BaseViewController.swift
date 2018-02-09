//
//  BaseViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let versionLabel = UILabel.init(frame: CGRect.init(x: 0, y: view.frame.height - 80, width: view.frame.width - 20, height: 20))
        versionLabel.textAlignment = .right
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text = "Version = " + version
        }
        
        navigationController?.navigationBar.tintColor = UIColor.barTintColor()

        view.addSubview(versionLabel)
    }
}
