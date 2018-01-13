//
//  EntranceViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class EntranceViewController: BaseViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissGesture)
        
        if setupUserLocalInformations() {
            performSegue(withIdentifier: "infoPage", sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func showInfo(_ sender: Any) {
        UserDefaults.standard.set(usernameTextField.text!, forKey: "username")
        UserDefaults.init(suiteName: "group.SteemitApp.widget")?.setValue(usernameTextField.text!, forKey: "username")
        
        UserGlobals.sharedInstance.username = usernameTextField.text!
        
        performSegue(withIdentifier: "infoPage", sender: nil)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupUserLocalInformations() -> Bool {
        if let username = UserDefaults.standard.string(forKey: "username") {
            UserGlobals.sharedInstance.username = username
            return true
        }
        return false
    }
}
