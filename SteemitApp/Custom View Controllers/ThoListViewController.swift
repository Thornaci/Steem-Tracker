//
//  ThoListViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/18/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

protocol ThoListViewControllerDelegate: class {
    func changePage(_ category: String)
}

class ThoListViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!

    var categoryList = [String]()
    let categoryTableViewCellIdentifier = "TitleTableViewCell"
    weak var delegate: ThoListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.register(UINib.init(nibName: categoryTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: categoryTableViewCellIdentifier)
    }
}

extension ThoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryTableViewCellIdentifier, for: indexPath) as! TitleTableViewCell
        cell.headerLabel.text = categoryList[indexPath.row]
        
        return cell
    }
}

extension ThoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.changePage(categoryList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
