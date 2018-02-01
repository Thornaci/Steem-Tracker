//
//  OptionsViewControllerTableViewExtension.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/30/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

extension OptionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: optionsReusableIdentifier, for: indexPath)
        
        if let label = cell.viewWithTag(151) as? UILabel {
            label.text = options[indexPath.row].title
        }
        cell.selectionStyle = .none
        
        return cell
    }
}

extension OptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToPage(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension OptionsViewController {
    fileprivate func navigateToPage(index: Int) {
        let vc = UIStoryboard.init(name: options[index].storyboardName,
                                   bundle: nil).instantiateViewController(withIdentifier: options[index].vcIdentifier) as! BaseViewController
        vc.username = username
        navigationController?.pushViewController(vc, animated: true)
    }
}
