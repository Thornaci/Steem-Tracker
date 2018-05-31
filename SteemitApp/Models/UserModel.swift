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
    var profileCoverUrl: String?
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
        
        let tc = TextChanger()
        var jsonMetadata = ""
        jsonMetadata <- map["json_metadata"]
        let metaDataAsDict = tc.convertToDictionary(text: jsonMetadata)
        if metaDataAsDict != nil, let profile = metaDataAsDict!["profile"] as? [String: String]{
            if let about = profile["about"] {
                aboutUser = about
            }
            if let imageUrl = profile["profile_image"] {
                profileUrl = imageUrl
            }
            if let coverUrl = profile["cover_image"] {
                profileCoverUrl = coverUrl
            }
        }
    }
}
