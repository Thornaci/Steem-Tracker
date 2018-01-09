//
//  UserGlobals.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

final class UserGlobals {
    
    static let sharedInstance: UserGlobals = UserGlobals()
    
    var username: String = ""
    var userMoney: String?
    
}
