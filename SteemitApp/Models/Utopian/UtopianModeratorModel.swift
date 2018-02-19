//
//  UtopianModeratorModel.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/18/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import ObjectMapper

struct UtopianModeratorModel: Mappable {
    
    var name: String?
    var supermoderator: Bool = false
    var totalPostChecked: Int = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name                    <- map["account"]
        supermoderator          <- map["supermoderator"]
        totalPostChecked        <- map["total_moderated"]
    }
}
