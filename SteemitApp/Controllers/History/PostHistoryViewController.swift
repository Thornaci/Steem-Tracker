//
//  PostHistoryViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/3/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import MBProgressHUD

class PostHistoryViewController: BaseViewController {

    let nm = NetworkManager.init()
    
    var postsHistory = [PostHistoryModel]()
    var hud: MBProgressHUD?

    override func viewDidLoad() {
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.detailsLabel.text = "Tags are loading.."
        nm.getSteemitAccountPostHistory(username: username, success: { (postsHistoryData) in
            self.postsHistory = postsHistoryData
            
            self.hud?.hide(animated: true)
        }) { (error) in
            self.hud?.hide(animated: true)
        }
    }
}
