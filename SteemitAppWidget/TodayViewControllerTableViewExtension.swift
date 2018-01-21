//
//  TodayViewControllerTableViewExtension.swift
//  SteemitAppWidget
//
//  Created by Burak Tayfun on 1/21/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

extension TodayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfosTableViewCell", for: indexPath) as! InfosTableViewCell
        let user = users[indexPath.row]
        cell.usernameLabel.text = user.username
        cell.steemLabel.text = user.steemBalance
        cell.sbdLabel.text = user.sbdBalance
        return cell
    }
}

extension TodayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
