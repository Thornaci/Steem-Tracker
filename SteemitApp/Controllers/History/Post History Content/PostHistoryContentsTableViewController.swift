//
//  PostHistoryContentsTableViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/6/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

extension PostHistoryContentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: postContentCellReuseIdentifier, for: indexPath) as! PostContentTableViewCell
        cell.selectionStyle = .none
        let postContent = contentArray[indexPath.row]
        cell.categoryLabel.text = postContent.category?.description
        cell.titleLabel.text = postContent.title?.description
        cell.pendingPayoutLabel.text = postContent.pendingPayoutValue?.description
        
        let date = Date.init(dateString: (postContent.createdTime)!, format: "yyyy-MM-dd'T'HH:mm:ss")
        cell.timeLabel.text = "\(date.dateWithFormat(format: "HH:mm"))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Date().getDateFromDay(day: day)
        return category + " on \(date.dateWithFormat(format: "yyyy-MM-dd"))"

    }
}

extension PostHistoryContentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPostOnWeb", sender: contentArray[indexPath.row])
    }
}
