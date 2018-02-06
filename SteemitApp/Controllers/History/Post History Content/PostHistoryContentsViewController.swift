//
//  PostHistoryContentsViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/6/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class PostHistoryContentsViewController: BaseViewController {

    var category = ""
    var day = 1
    var contentArray = [PostHistoryModel]()

    override func viewDidLoad() {
        navigationController?.navigationBar.topItem?.title = ""
    }
}
