//
//  GeneralRepository.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import Foundation
import SwiftyJSON

final class GeneralRepository: GeneralRepositoryProtocol {
    func getHits(orderedBy order: HitOrder?, success: @escaping ([Hit]) -> Void, failure: @escaping (Error) -> Void) {
        ResponseHelper.GET(with: .url,
                           url: Constants.Endpoints.GET_HITS,
                           parameters: nil,
        success: { (response) in
            let hits = response["hits"].arrayValue.compactMap { (jsonObject) -> Hit? in
                let tags = jsonObject["_tags"].arrayValue.compactMap { (jsonObject) -> String? in
                    return jsonObject.string
                }
                return Hit(parentId: jsonObject["parent_id"].stringValue,
                           objectId: jsonObject["objectID"].stringValue,
                           title: jsonObject["title"].string,
                           url: jsonObject["url"].string,
                           author: jsonObject["author"].stringValue,
                           storyId: jsonObject["story_id"].string,
                           storyTitle: jsonObject["story_title"].string,
                           storyUrl: jsonObject["story_url"].string,
                           createdAt: jsonObject["created_at"].stringValue,
                           comment: jsonObject["comment_text"].stringValue,
                           tags: tags)
            }
            guard let order = order else {
                success(hits)
                return
            }
            let orderedHits = hits.sorted { (hit1, hit2) -> Bool in
                guard let date1 = hit1.createdAt, let date2 = hit2.createdAt else { return false }
                var aux: ComparisonResult
                switch order {
                case .ascendant: aux = .orderedAscending
                case .descendant: aux = .orderedDescending
                }
                return date1.compare(date2) == aux
            }
            success(orderedHits)
        },
        failure: failure)
    }
}
