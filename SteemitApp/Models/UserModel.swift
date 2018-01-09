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
    var votingPower: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        username <- map["user.name"]
        profileUrl <- map["user.json_metadata.profile.profile_image"]
        aboutUser <- map["user.json_metadata.profile.about"]
        sbdBalance <- map["user.sbd_balance"]
        steemBalance <- map["user.balance"]
        votingPower <- map["user.voting_power"]
    }
}
