//
//  GeneralRepositoryTests.swift
//  HackerNewsTests
//
//  Created by Hugo Rosado on 1/8/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import XCTest
@testable import Hacker_News

class GeneralRepositoryTests: XCTestCase {
    private let timeout: TimeInterval = 60.0

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessfulGetHitsResponse() throws {
        let expectation = self.expectation(description: "Hit array should not be empty")
        let generalRepository = RouterMock.shared.generalRepository
        let order: HitOrder = .ascendant
        
        generalRepository.getHits(orderedBy: order,
        success: { (hits) in
            XCTAssertNotEqual(hits, [], "Hit array is empty")
            if let firstDate = hits.first?.createdAt, let lastDate = hits.last?.createdAt {
                let compare = firstDate.compare(lastDate)
                switch order {
                case .ascendant:
                    XCTAssertTrue(compare == .orderedAscending || compare == .orderedSame, "Hit order should be ascendant")
                case .descendant:
                    XCTAssertTrue(compare == .orderedDescending || compare == .orderedSame, "Hit order should be descendant")
                }
            }
            expectation.fulfill()
        }) { (error) in
            XCTFail("Response should be successful")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }

}
