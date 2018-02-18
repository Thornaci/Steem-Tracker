//
//  SearchViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var menuViewLeading: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        homeView.addGestureRecognizer(dismissGesture)
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        dismissKeyboard()
        if menuViewLeading.constant < 0 {
            self.menuViewLeading.constant += 200
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            self.menuViewLeading.constant -= 200
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func showInfo(_ sender: Any) {
        performSegue(withIdentifier: "chooseAction", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseAction" {
            let optionVC = segue.destination as! OptionsViewController
            optionVC.username = usernameTextField.text!
        } else if segue.identifier == "leftSideMenu" {
            let menuVC = segue.destination as! ThoListViewController
            menuVC.categoryList = HomeCategories.categoryList
            menuVC.delegate = self
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SearchViewController: ThoListViewControllerDelegate {
    func changePage(_ category: String) {
        if category == "Utopian-io" {
            let vc = UIStoryboard.init(name: "HomeUtopian",
                                       bundle: nil).instantiateInitialViewController()
            present(vc!, animated: true, completion: nil)
        }
    }
}
