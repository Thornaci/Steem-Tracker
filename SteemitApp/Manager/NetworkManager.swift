//
//  NetworkManager.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import ObjectMapper

struct NetworkManager {
    
    let endPoint = "https://api.coinmarketcap.com/v1/ticker/"
    let steemEndPoint = "https://api.steemjs.com/"
    
    func getSteemitPrice(currency: String,
                         success: @escaping (_ result: CoinModel) -> Void,
                         failure: @escaping (_ error: String) -> Void) {
        
        let path = endPoint + CoinTypes.steemDollar.rawValue + "/?convert=" + currency
        
        BaseNetwork.sharedInstance.getRequest(path: path, success: { (data) in
            
            guard let responseJSON = data as? Array<[String: AnyObject]> else {
                failure("Error reading response")
                return
            }
            
            let coin: [CoinModel] = Mapper<CoinModel>().mapArray(JSONArray: responseJSON)
            
            success(coin.first!)
        }) { (error) in
            failure(error)
        }
    }
    
    func getSteemitAccount(user: String,
                         success: @escaping (_ result: UserModel) -> Void,
                         failure: @escaping (_ error: String) -> Void) {
        let path = steemEndPoint + "get_accounts?names[]=" + user
        BaseNetwork.sharedInstance.getRequest(path: path, success: { (data) in
            
            guard let responseJSON = data as? Array<Dictionary<String, AnyObject>> else {
                failure("Error reading response")
                return
            }
            
            guard let user: UserModel = Mapper<UserModel>().map(JSONObject: responseJSON.first) else {
                failure("Error reading response")
                return
            }
            
            success(user)
        }) { (error) in
            failure(error)
        }
    }
    
    func cancelAllSessions() {
        BaseNetwork.sharedInstance.cancelAllSessions()
    }
}
