//
//  ModeratorListViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/18/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class ModeratorListViewController: UIViewController {
    
    var moderators = [UtopianModeratorModel]()
    
    override func viewDidLoad() {
        navigationItem.title = "Moderators"
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moderatorList" {
            let menuVC = segue.destination as! ThoListViewController
            var names = [String]()
            for mod in moderators {
                names.append(mod.name!)
            }
            menuVC.categoryList = names
            menuVC.delegate = self
        }
    }
}

extension ModeratorListViewController: ThoListViewControllerDelegate {
    func changePage(_ category: String) {
        
    }
}
