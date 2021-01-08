//
//  Constants+Localizable.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import Foundation

extension Constants {
    struct Localizable {
        static let APP_NAME = NSLocalizedString("Hacker News", comment: "")
        static let CANCEL = NSLocalizedString("Cancel", comment: "")
        static let DEFAULT_ERROR_MESSAGE = NSLocalizedString("There was a problem, please try later", comment: "")
        static let OK = NSLocalizedString("Ok", comment: "")
        static let NO: String = NSLocalizedString("No", comment: "")
        static let RESTORE_NEWS = NSLocalizedString("Restart news", comment: "")
        static let RESTORE_NEWS_QUESTION = NSLocalizedString("Are you sure to restore thes news?", comment: "")
        static let YES: String = NSLocalizedString("Yes", comment: "")
    }
}
