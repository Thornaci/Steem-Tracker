//
//  FollowersViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/25/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import MBProgressHUD

class FollowersViewController: BaseViewController {

    @IBOutlet weak var followerTableView: UITableView!
    
    let followerCellReuseIdentifier = "FollowerTableViewCell"
    var followers = [String]()
    var following = [String]()
    var displayingCount = 0
    var hud: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followerTableView.register(UINib.init(nibName: followerCellReuseIdentifier, bundle: nil), forCellReuseIdentifier: followerCellReuseIdentifier)
        
        navigationItem.title = "Following List"
        navigationController?.navigationBar.topItem?.title = ""
        getFollowerList()
    }
    
    func getFollowerList() {
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.detailsLabel.text = "I am looking who is following you.."
        let nm = NetworkManager.init()
        nm.getSteemitAccountFollowerCount(user: username, success: { (followDict) in
            if let followingLimit = followDict["followingCount"] as? Int {
                nm.getSteemitAccountFollowings(user: self.username, limit: followingLimit.description, success: { (followingArray) in
                    self.following.removeAll()
                    self.following = followingArray
                    
                    if let followerLimit = followDict["followerCount"] as? Int {
                        nm.getSteemitAccountFollowers(user: self.username, limit: followerLimit.description, success: { (followersArray) in
                            self.followers.removeAll()
                            self.followers = followersArray
                            self.hud?.hide(animated: true)
                            self.followerTableView.reloadData()
                        }, failure: { (error) in
                            self.hud?.hide(animated: true)
                        })
                    }
                }, failure: { (error) in
                    self.hud?.hide(animated: true)
                })
            }
        }) { (error) in
            self.hud?.hide(animated: true)
        }
    }
}
