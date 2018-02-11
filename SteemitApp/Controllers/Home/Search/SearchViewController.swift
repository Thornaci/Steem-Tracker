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
    
    override func viewDidAppear(_ animated: Bool) {
        usernameTextField.becomeFirstResponder()
    }
    
    @IBAction func showInfo(_ sender: Any) {
        performSegue(withIdentifier: "chooseAction", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let OptionVC = segue.destination as! OptionsViewController
        OptionVC.username = usernameTextField.text!
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
