//
//  PostHistoryModel.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/3/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import ObjectMapper

struct PostHistoryModel: Mappable {

    var category: String?
    var title: String?
    var body: String?
    var createdTime: String?
    var netVotes: Int = 0
    var pendingPayoutValue: String?
    var pendingPayoutValueDouble: Double = 0
    var url: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        category                <- map["category"]
        title                   <- map["title"]
        body                    <- map["body"]
        createdTime             <- map["created"]
        netVotes                <- map["net_votes"]
        pendingPayoutValue      <- map["pending_payout_value"]
        url                     <- map["url"]
        
        let clearPayout = pendingPayoutValue?.replacingOccurrences(of: "[A-Z]|[a-z]", with: "", options: [.regularExpression]).replacingOccurrences(of: " ", with: "", options: [.regularExpression])
        pendingPayoutValueDouble = Double(clearPayout!)!
    }
}
