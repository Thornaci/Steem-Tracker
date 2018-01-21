//
//  Helpers.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/21/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

struct Helpers {
    
    func setLocalDataVariables(_ array: Array<Any>) {
        UserDefaults.standard.set(array, forKey: "username")
        UserDefaults.init(suiteName: "group.SteemitApp.widget")?.set(array, forKey: "username")
    }
}
