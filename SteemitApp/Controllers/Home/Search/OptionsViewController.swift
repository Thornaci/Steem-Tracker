//
//  OptionsViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/30/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class OptionsViewController: BaseViewController {

    @IBOutlet weak var optionsTableView: UITableView!
    
    let optionsReusableIdentifier = "optionsTitleTableViewCell"
    var options = [OptionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createOptions()
        optionsTableView.reloadData()
    }

    private func createOptions() {
        options = [OptionModel(title: "User Information",
                               vcIdentifier: "infoVC",
                               storyboardName: "Information"),
                   OptionModel(title: "Follower List",
                               vcIdentifier: "followerVC",
                               storyboardName: "Follower"),
                   OptionModel(title: "Tag History",
                               vcIdentifier: "tagHistoryVC",
                               storyboardName: "History")]
    }
}
