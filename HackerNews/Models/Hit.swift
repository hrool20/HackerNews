//
//  Hit.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import Foundation
import SwiftyJSON

class Hit {
    var id: String
    var parentId: String
    var objectId: String
    var title: String?
    var url: String?
    var author: String
    var storyId: String?
    var storyTitle: String?
    var storyUrl: String?
    var createdAt: Date?
    var comment: String
    var tags: [String]
    private var _createdAt: String
    
    init(parentId: String, objectId: String, title: String?, url: String?, author: String, storyId: String?, storyTitle: String?, storyUrl: String?, createdAt: String, comment: String, tags: [String]) {
        self.id = UUID().uuidString
        self.parentId = parentId
        self.objectId = objectId
        self.title = title
        self.url = url
        self.author = author
        self.storyId = storyId
        self.storyTitle = storyTitle
        self.storyUrl = storyUrl
        self._createdAt = createdAt
        self.createdAt = DateFormatterHandler.shared.date(from: createdAt)
        self.comment = comment
        self.tags = tags
    }
    
}
