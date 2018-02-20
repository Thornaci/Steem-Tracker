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
    
    func filterLastWeekData(postsHistory: [PostHistoryModel]) -> [[PostHistoryModel]] {
        let maxSize = 7
        var filteredPostsHistory = [[PostHistoryModel]]()
        for _ in 0...maxSize {
            let postArray = [PostHistoryModel]()
            filteredPostsHistory.append(postArray)
        }
        
        for postHistory in postsHistory {
            let postDate = Date.iso8601Formatter.date(from: (postHistory.createdTime?.replacingOccurrences(of: "T", with: " "))!)
            for i in 0...maxSize {
                if i.days.earlier.day == postDate?.day && i.days.earlier.month == postDate?.month && i.days.earlier.year == postDate?.year {
                    filteredPostsHistory[maxSize-i].append(postHistory)
                }
            }
        }
        return filteredPostsHistory
    }
    
    func calculateVotePower(_ lastVoteTime: String, _ lastVotePower: CGFloat) -> CGFloat {
        let datea = Date();
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let lastVoteDate = dateFormatter.date(from: lastVoteTime)
        
        let differenceInSeconds = datea.timeIntervalSince(lastVoteDate!)
        let generatedVP = differenceInSeconds * 10000 / 86400 / 5
        let totalVP = (lastVotePower + CGFloat(generatedVP)) / 100
        if totalVP > 100 {
            return 100
        } else {
            return totalVP
        }
    }
}
