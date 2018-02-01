//
//  Helpers.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/21/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

struct Helpers {
    
    func setLocalDataVariables(_ array: Array<Any>) {
        UserDefaults.standard.set(array, forKey: "username")
        UserDefaults.init(suiteName: "group.SteemitApp.widget")?.set(array, forKey: "username")
    }
    
    func findTopTenTagsForComment(tagsHistory: [TagHistoryModel]) -> [TagHistoryModel] {
        
        let sortedTags = tagsHistory.sorted(by: { $0.comments > $1.comments })
        let tags = sortedTags[0...9]
        
        return Array(tags)
    }
    
    func findTopTenTagsForTotalPayouts(tagsHistory: [TagHistoryModel]) -> [TagHistoryModel] {
        
        let sortedTags = tagsHistory.sorted(by: { $0.totalPayoutsDouble > $1.totalPayoutsDouble })
        let tags = sortedTags[0...9]
        
        return Array(tags)
    }
    
    func findTopTenTagsForNetVotes(tagsHistory: [TagHistoryModel]) -> [TagHistoryModel] {
        
        let sortedTags = tagsHistory.sorted(by: { $0.netVotes > $1.netVotes })
        let tags = sortedTags[0...9]
        
        return Array(tags)
    }
    
    func findTopTenTagsForTopPosts(tagsHistory: [TagHistoryModel]) -> [TagHistoryModel] {
        
        let sortedTags = tagsHistory.sorted(by: { $0.topPosts > $1.topPosts })
        let tags = sortedTags[0...9]
        
        return Array(tags)
    }
}
