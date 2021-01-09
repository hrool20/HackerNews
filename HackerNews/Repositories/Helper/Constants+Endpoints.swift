//
//  Constants+Endpoints.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import Foundation

extension Constants {
    struct Endpoints {
        private static let BASE_ENDPOINT: String = "api/v1"
        #if DEBUG
        private static let BASE_URL: String = "https://hn.algolia.com/\(BASE_ENDPOINT)"
        #else
        private static let BASE_URL: String = "https://hn.algolia.com/\(BASE_ENDPOINT)"
        #endif
        
        static let GET_HITS = "\(BASE_URL)/search_by_date"
    }
}
