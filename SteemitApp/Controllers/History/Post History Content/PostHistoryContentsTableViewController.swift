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
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Date().getDateFromDay(day: day)
        return category + " on \(date.dateWithFormat(format: "yyyy-MM-dd"))"

    }
}

extension PostHistoryContentsViewController: UITableViewDelegate {
    
}
