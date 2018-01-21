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
        let versionLabel = UILabel.init(frame: CGRect.init(x: 0, y: view.frame.height - 80, width: view.frame.width - 20, height: 20))
        versionLabel.textAlignment = .right
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text = "Version = " + version
        }
        
        for view in (navigationController?.navigationBar.subviews[0].subviews)! {
            view.alpha = 0
            for subview in view.subviews {
                subview.alpha = 0
            }
        }
        
        view.addSubview(versionLabel)
    }
}
