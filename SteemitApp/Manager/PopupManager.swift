//
//  PopupManager.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/9/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

struct PopupManager {
    
    func showDefaultPopup(viewController: UIViewController, actions: [UIAlertAction], message: String, title: String) {
        
        let controller = UIAlertController.init(title: title,
                                                message: message,
                                                preferredStyle: UIAlertControllerStyle.alert)
        
        for item in actions {
            controller.addAction(item)
        }
        
        viewController.present(controller, animated: true, completion: nil)
    }
}
