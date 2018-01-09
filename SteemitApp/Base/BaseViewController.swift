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
        view.applyGradient(colours: [UIColor.init(white: 1, alpha: 1), UIColor.init(red: 37/255, green: 213/255, blue: 170/255, alpha: 1)])
        let versionLabel = UILabel.init(frame: CGRect.init(x: 0, y: view.frame.height - 40, width: view.frame.width - 20, height: 20))
        versionLabel.textAlignment = .right
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text = "Version = " + version
        }
        
        navigationItem.title = "SteemitApp"
        
        view.addSubview(versionLabel)
    }
}
