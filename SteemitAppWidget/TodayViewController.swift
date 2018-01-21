//
//  TodayViewController.swift
//  SteemitAppWidget
//
//  Created by Burak Tayfun on 1/10/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import NotificationCenter

typealias CompletionBlock = (_ result: Bool) -> ()

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var session: URLSession!
    var users = [UserModel]()
    
    @IBOutlet weak var infosTableView: UITableView!
    
    override func viewDidLoad() {
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        getAccountInformation { [unowned self] result in
            if result == true {
                self.infosTableView.alpha = 1
                DispatchQueue.main.async {
                    self.infosTableView.reloadData()
                }
            } else {
                self.infosTableView.alpha = 0
            }
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        if activeDisplayMode == .expanded {
            let height = CGFloat(users.count) * 110.0
            preferredContentSize = CGSize(width: maxSize.width, height: height)
        } else {
            preferredContentSize = maxSize
        }
    }
    
    func getAccountInformation(_ completion: @escaping CompletionBlock) {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
        
        if let usernameArray = UserDefaults.init(suiteName: "group.SteemitApp.widget")?.array(forKey: "username") {
            
            let request = URLRequest(url: setUrl(usernameArray: usernameArray as! [String]))
            
            let task = session.dataTask(with: request) { [weak self] data, response, dataError in
                if dataError == nil {
                    do {
                        let userDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Dictionary<String, Any>>
                        
                        self?.users = (self?.serializeUsers(data: userDictionary))!
                        
                        completion(true)
                        
                    } catch {
                        completion(false)
                    }
                    
                } else {
                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    func serializeUsers(data: Array<Dictionary<String, Any>>) -> [UserModel] {
        var users = [UserModel]()
        for user in data {
            var newUser = UserModel.init()
            if let username = user["name"] as? String {
                newUser.username = username
            }
            if let steemBalance = user["balance"] as? String {
                newUser.steemBalance = steemBalance
            }
            if let sbdBalance = user["sbd_balance"] as? String {
                newUser.sbdBalance = sbdBalance
            }
            
        users.append(newUser)
        }
        
        return users
    }
    
    func setUrl(usernameArray: [String]) -> URL {
        let endPoint = "https://api.steemjs.com/"
        var usernamesString = "%5B%22"
        for index in 0...usernameArray.count - 1 {
            usernamesString = usernamesString + "\(usernameArray[index])"
            if usernameArray.count != 1 && index < usernameArray.count - 1 {
                usernamesString = usernamesString + "%22%2C%20%22"
            }
        }
        usernamesString = usernamesString + "%22%5D"
        
        let url = endPoint + "getAccounts?names[]=" + usernamesString
        return URL(string: url)!
    }
}
