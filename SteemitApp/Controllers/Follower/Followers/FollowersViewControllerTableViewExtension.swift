//
//  FollowersViewControllerTableViewExtension.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/28/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

extension FollowersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculateTableViewRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: followerCellReuseIdentifier, for: indexPath) as! FollowerTableViewCell
        cell.followerLabel.text = following[indexPath.row]
        if followers.contains(following[indexPath.row]) {
            cell.isFollowsImageView.image = UIImage.init(named: "tick")
        } else {
            cell.isFollowsImageView.image = UIImage.init(named: "false")
        }
        cell.positionNumberLabel.text = (indexPath.row + 1).description
        
        return cell
    }

    private func calculateTableViewRows() -> Int {
        if following.count == 0 {
            return 0
        }
        displayingCount = displayingCount + 20
        
        if displayingCount > following.count {
            displayingCount = following.count
        }
        return displayingCount
    }
}

extension FollowersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == following.count - 1 {
            return
        }
        
        if indexPath.row >= displayingCount - 1 {
            followerTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
