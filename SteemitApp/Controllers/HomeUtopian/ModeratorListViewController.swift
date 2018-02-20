//
//  ModeratorListViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/18/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class ModeratorListViewController: BaseViewController {
    
    var moderators = [UtopianModeratorModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            names = names.sorted { $0 < $1 }
            menuVC.categoryList = names
            menuVC.delegate = self
        }
    }
}

extension ModeratorListViewController: ThoListViewControllerDelegate {
    func changePage(_ category: String) {
        let vc = UIStoryboard.init(name: "Information",
                                   bundle: nil).instantiateViewController(withIdentifier: "infoVC") as! InfoViewController
        vc.username = category
        navigationController?.pushViewController(vc, animated: true)
    }
}
