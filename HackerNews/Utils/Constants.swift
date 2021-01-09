//
//  Constants.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import Foundation

struct Constants {
    struct Keys {
        static let IS_SOME_HIT_DELETED: String = "isSomeHitDeleted"
        static let DELETED_HIT_IDS: String = "deletedHitIds"
        static let USER: String = "user"
    }
    
    struct UITest {
        struct General {
            private static let prf: String = "GR"
            static let NO_ACTION = "\(prf)noAction"
            static let YES_ACTION = "\(prf)yesAction"
        }
        struct HitOptions {
            private static let prf: String = "HO"
            static let HIT_TABLE_VIEW = "\(prf)hitTableView"
            static let RESTORE_ACTION = "\(prf)restoreAction"
            static let SETTING_BAR_BUTTON = "\(prf)settingsBarButton"
        }
        struct LoaderView {
            private static let prf: String = "LV"
            static let IDENTIFIER = "\(prf)"
        }
    }
}
