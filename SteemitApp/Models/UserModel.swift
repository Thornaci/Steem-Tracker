//
//  UserModel.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import ObjectMapper

struct UserModel: Mappable {
    
    var username: String?
    var aboutUser: String?
    var profileUrl: String?
    var sbdBalance: String?
    var steemBalance: String?
    var votingPower: CGFloat = 0
    var lastvoteTime: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        username        <- map["name"]
        sbdBalance      <- map["sbd_balance"]
        steemBalance    <- map["balance"]
        votingPower     <- map["voting_power"]
        lastvoteTime    <- map["last_vote_time"]
        
        var jsonMetadata: String = ""
        jsonMetadata <- map["json_metadata"]
        jsonMetadata = jsonMetadata.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "")
        let array = jsonMetadata.split(separator: "\"")
        for index in 0...array.count {
            if index + 2 < array.count {
                if array[index].description == "profile_image" {
                    profileUrl = array[index+2].description
                } else if array[index].description == "about" {
                    aboutUser = array[index+2].description
                }
            }
        }
    }
}
