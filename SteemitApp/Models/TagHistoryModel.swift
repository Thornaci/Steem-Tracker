//
//  TagHistoryModel.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/1/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import ObjectMapper

struct TagHistoryModel: Mappable {
    
    var name: String?                                        // "steem"
    var totalPayouts: String?                                // "3885200.102 SBD"
    var totalPayoutsDouble: Double = 0
    var netVotes: Int = 0                                    // 358840
    var topPosts: Int = 0                                    // 28376
    var comments: Int = 0                                    // 23807
    var trending: String?                                    // "164298665"
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name            <- map["name"]
        totalPayouts    <- map["total_payouts"]
        netVotes        <- map["net_votes"]
        topPosts        <- map["top_posts"]
        comments        <- map["comments"]
        trending        <- map["trending"]
        
        let clearPayout = totalPayouts?.replacingOccurrences(of: "[A-Z]|[a-z]", with: "", options: [.regularExpression]).replacingOccurrences(of: " ", with: "", options: [.regularExpression])
        totalPayoutsDouble = Double(clearPayout!)!
    }
}
