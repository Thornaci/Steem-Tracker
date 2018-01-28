//
//  FavoriteUsersViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/21/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class FavoriteUsersViewController: BaseViewController {

    var userArray = [String]()
    let favoriteCellReuseIdentifier = "FavoriteTableViewCell"
    
    @IBOutlet weak var favoriteListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteListTableView.register(UINib.init(nibName: favoriteCellReuseIdentifier, bundle: nil), forCellReuseIdentifier: favoriteCellReuseIdentifier)
        
        let rightBarButton = UIBarButtonItem.init(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        rightBarButton.tintColor = UIColor.barTintColor()
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let array = UserDefaults.standard.array(forKey: "username") {
            userArray = array as! [String]
            favoriteListTableView.reloadData()
        }
    }
    
    @objc func editTapped() {
        if favoriteListTableView.isEditing {
            navigationItem.rightBarButtonItem?.title = "Edit"
            favoriteListTableView.setEditing(false, animated: true)
        } else {
            navigationItem.rightBarButtonItem?.title = "Done"
            favoriteListTableView.setEditing(true, animated: true)
        }
        
        let helper = Helpers.init()
        helper.setLocalDataVariables(userArray)
    }
}
