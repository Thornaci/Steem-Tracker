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
        
        if setupUserLocalInformations() {
            performSegue(withIdentifier: "infoPage", sender: nil)
        }
    }
    
    @IBAction func showInfo(_ sender: Any) {
        UserDefaults.standard.set("username", forKey: usernameTextField.text!)
        UserGlobals.sharedInstance.username = usernameTextField.text!
        
        performSegue(withIdentifier: "infoPage", sender: nil)
    }
    
    private func setupUserLocalInformations() -> Bool {
        if let username = UserDefaults.standard.string(forKey: "username") {
            UserGlobals.sharedInstance.username = username
            return true
        }
        return false
    }
}
