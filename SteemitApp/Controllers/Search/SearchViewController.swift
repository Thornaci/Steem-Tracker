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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissGesture)
        
    }
    
    @IBAction func showInfo(_ sender: Any) {
        performSegue(withIdentifier: "infoPage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let InfoVC = segue.destination as! InfoViewController
        InfoVC.username = usernameTextField.text!
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
