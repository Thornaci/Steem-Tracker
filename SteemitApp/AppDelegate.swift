//
//  AppDelegate.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/6/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import HockeySDK
//import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        BITHockeyManager.shared().configure(withIdentifier: "292b4a0dc15e4fb9af602055958630fd")
        BITHockeyManager.shared().start()
        BITHockeyManager.shared().authenticator.authenticateInstallation()
        BITHockeyManager.shared().isStoreUpdateManagerEnabled = true
        
//        FirebaseApp.configure()
        
        return true
    }
}

