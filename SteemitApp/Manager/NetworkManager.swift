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
    
    func getSteemitAccountFollowerCount(user: String,
                           success: @escaping (_ result: Dictionary<String, Any>) -> Void,
                           failure: @escaping (_ error: String) -> Void) {
        let path = steemEndPoint + "get_follow_count?account=" + user
        BaseNetwork.sharedInstance.getRequest(path: path, success: { (data) in
            
            guard let responseJSON = data as? Dictionary<String, AnyObject> else {
                failure("Error reading response")
                return
            }
            
            var dict = Dictionary<String, Any>()
            if let count = responseJSON["follower_count"] as? Int {
                dict["followerCount"] = count
            }
            
            if let count = responseJSON["following_count"] as? Int {
                dict["followingCount"] = count
            }
            
            success(dict)
        }) { (error) in
            failure(error)
        }
    }
    
    func getSteemitAccountFollowings(user: String,
                                    limit: String,
                                    success: @escaping (_ result: [String]) -> Void,
                                    failure: @escaping (_ error: String) -> Void) {
        let path = steemEndPoint + "get_following?follower=" + user +  "&startFollower=a&followType=blog&limit=" + limit
        BaseNetwork.sharedInstance.getRequest(path: path, success: { (data) in
            
            guard let responseJSON = data as? Array<Dictionary<String, AnyObject>> else {
                failure("Error reading response")
                return
            }
            var followingArray = [String]()
            for followInfo in responseJSON {
                if let follower = followInfo["following"] as? String {
                    followingArray.append(follower)
                }
            }
            
            success(followingArray)
        }) { (error) in
            failure(error)
        }
    }
    
    func getSteemitAccountFollowers(user: String,
                                    limit: String,
                                        success: @escaping (_ result: [String]) -> Void,
                                        failure: @escaping (_ error: String) -> Void) {
        let path = steemEndPoint + "get_followers?following=" + user +  "&startFollower=a&followType=blog&limit=" + limit
        BaseNetwork.sharedInstance.getRequest(path: path, success: { (data) in
            
            guard let responseJSON = data as? Array<Dictionary<String, AnyObject>> else {
                failure("Error reading response")
                return
            }
            var followerArray = [String]()
            for followInfo in responseJSON {
                if let follower = followInfo["follower"] as? String {
                    followerArray.append(follower)
                }
            }
            
            success(followerArray)
        }) { (error) in
            failure(error)
        }
    }
    
    func getSteemitTagsHistory(success: @escaping (_ result: [TagHistoryModel]) -> Void,
                               failure: @escaping (_ error: String) -> Void) {
        
        let path = steemEndPoint + "get_trending_tags?afterTag=steem&limit=1000"
        BaseNetwork.sharedInstance.getRequest(path: path, success: { (data) in
            
            guard let responseJSON = data as? Array<Dictionary<String, AnyObject>> else {
                failure("Error reading response")
                return
            }
            
            var tagsHistoryArray = [TagHistoryModel]()
            
            for tagsHistory in responseJSON {
                
                guard let tagHistory: TagHistoryModel = Mapper<TagHistoryModel>().map(JSONObject: tagsHistory) else {
                    failure("Error reading tag")
                    return
                }
                
                tagsHistoryArray.append(tagHistory)
            }
            
            success(tagsHistoryArray)
        }) { (error) in
            failure(error)
        }
    }
    
    func cancelAllSessions() {
        BaseNetwork.sharedInstance.cancelAllSessions()
    }
}
