//
//  FavoriteUsersTableViewExtension.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/21/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

extension FavoriteUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCellReuseIdentifier, for: indexPath) as! FavoriteTableViewCell
        
        cell.usernameLabel.text = userArray[indexPath.row]
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

extension FavoriteUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let InfoVC = storyboard?.instantiateViewController(withIdentifier: "infoVC") as! InfoViewController
        InfoVC.username = userArray[indexPath.row]
        navigationController?.pushViewController(InfoVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            userArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
