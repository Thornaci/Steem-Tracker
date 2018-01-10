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
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var sbdLabel: UILabel!
    @IBOutlet weak var steemLabel: UILabel!
    
    var session: URLSession!
    
    override func viewDidLoad() {
        
        getAccountInformation { [unowned self] result in
            if result == false {
                self.usernameLabel.text = "No account"
            }
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func getAccountInformation(_ completion: @escaping CompletionBlock) {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
        
        if let quoteFromApp = UserDefaults.init(suiteName: "group.SteemitApp.widget")?.value(forKey: "username") {
            let endPoint = "https://steemit.com/"
            let username = quoteFromApp as! String
            let url = endPoint + "@" + username + ".json"
            let fullUrl = URL(string: url)
            let request = URLRequest(url: fullUrl!)
            
            let task = session.dataTask(with: request) {[weak self] data, response, dataError in
                if dataError == nil {
                    do {
                        let userDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, Any>
                        if let user = userDictionary["user"] as? Dictionary<String, Any> {
                            if let username = user["name"] as? String {
                                self?.usernameLabel.text = username
                            }
                            if let steemBalance = user["balance"] as? String {
                                self?.sbdLabel.text = steemBalance
                            }
                            if let sbdBalance = user["sbd_balance"] as? String {
                                self?.steemLabel.text = sbdBalance
                            }
                        }
                        
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
}
