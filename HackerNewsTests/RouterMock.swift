//
//  RouterMock.swift
//  HackerNewsTests
//
//  Created by Hugo Rosado on 1/8/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import Foundation
@testable import Hacker_News

final class RouterMock {
    static let shared = RouterMock()
    // Handlers
    let userDefaultsHandler: UserDefaultsHandlerProtocol
    // Repositories
    let generalRepository: GeneralRepositoryProtocol
    
    init() {
        let suiteName = "HackerNewsTests"
        userDefaultsHandler = UserDefaultsHandler(suiteName: suiteName)
        
        generalRepository = GeneralRepository()
    }
}
