//
//  HomeUtopianViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/18/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class HomeUtopianViewController: BaseViewController {

    let nm = NetworkManager()
    
    @IBOutlet weak var percentView: ThoSlider!
    
    
    override func viewDidLoad() {
//        getUtopianInfo()
    }
    
    func getUtopianInfo() {
        nm.getSteemitAccount(user: "utopian-io", success: { utopianData in
            
        }) { (error) in
            print(error)
        }
    }
   
    @IBAction func closeScreen(_ sender: Any) {
//        self.navigationController?.dismiss(animated: true, completion: nil)
        percentView.updateBar(0.9)
    }
}
