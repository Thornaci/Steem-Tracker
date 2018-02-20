//
//  UtopianPendingPostsModel.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/19/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import ObjectMapper

struct UtopianPendingPostsModel: Mappable {
    
    var total: Int = 0
    var development: Int = 0
    var bugHunting: Int = 0
    var documentation: Int = 0
    var translations: Int = 0
    var analysis: Int = 0
    var ideas: Int = 0
    var graphics: Int = 0
    var tutorials: Int = 0
    var videoTutorials: Int = 0
    var blog: Int = 0
    var subProjects: Int = 0
    var tasks: Int = 0
    var visibility: Int = 0
    var copywriting: Int = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        total                <- map["posts.pending._total"]
        development          <- map["posts.pending._total.development"]
        bugHunting           <- map["posts.pending._total.bug_hunting"]
        documentation        <- map["posts.pending._total.documentation"]
        translations         <- map["posts.pending._total.translations"]
        analysis             <- map["posts.pending._total.analysis"]
        ideas                <- map["posts.pending._total.ideas"]
        graphics             <- map["posts.pending._total.graphics"]
        tutorials            <- map["posts.pending._total.tutorials"]
        videoTutorials       <- map["posts.pending._total.video_tutorials"]
        blog                 <- map["posts.pending._total.blog"]
        subProjects          <- map["posts.pending._total.sub_projects"]
        tasks                <- map["posts.pending._total.tasks"]
        visibility           <- map["posts.pending._total.visibility"]
        copywriting          <- map["posts.pending._total.copywriting"]
    }
}
