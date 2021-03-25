//
//  HitOptionsUITests.swift
//  HackerNewsUITests
//
//  Created by Hugo Rosado on 1/8/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import XCTest

class HitOptionsUITests: XCTestCase {

    private let app: XCUIApplication = XCUIApplication()
    private var hitTableView: XCUIElement!
    private var firstCell: XCUIElement!
    private let splashTimeout: TimeInterval = 10.0
    private let timeout: TimeInterval = 5.0
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app.launch()
        
        hitTableView = app.tables[Constants.UITest.HitOptions.HIT_TABLE_VIEW]
        XCTAssertTrue(hitTableView.waitForExistence(timeout: splashTimeout))
        XCTAssertTrue(hitTableView.exists)
        
        firstCell = hitTableView.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: timeout))
        XCTAssertTrue(firstCell.exists)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeleteCellWithTouch() throws {
        firstCell.swipeLeft()
        
        let oldCount = hitTableView.cells.count
        let deleteEditAction = firstCell.buttons.firstMatch
        XCTAssertTrue(deleteEditAction.waitForExistence(timeout: timeout))
        deleteEditAction.tap()
        
        let newCount = hitTableView.cells.count
        XCTAssertTrue(oldCount > newCount)
    }
    
    func testDeleteCellWithSwipe() throws {
        let oldCount = hitTableView.cells.count
        firstCell.longSwipe(.left)
        let newCount = hitTableView.cells.count
        XCTAssertTrue(oldCount > newCount)
    }
    
    func testRestoreDeletedHits() throws {
        let settingBarButton = app.navigationBars["Hacker_News.HitOptionsTableView"].children(matching: .button)[Constants.UITest.HitOptions.SETTING_BAR_BUTTON]
        guard settingBarButton.exists else { return }
        settingBarButton.tap()
        
        let sheet = app.sheets.firstMatch.buttons[Constants.UITest.HitOptions.RESTORE_ACTION]
        sheet.tap()
        
        let yesAction = app.alerts.firstMatch.buttons[Constants.UITest.General.YES_ACTION]
        XCTAssertTrue(yesAction.waitForExistence(timeout: timeout))
        yesAction.tap()
        
        let oldCount = hitTableView.cells.count
        let expectation = self.expectation(for: NSPredicate(format: "cells.count > \(oldCount)"), evaluatedWith: hitTableView, handler: nil)
        wait(for: [expectation], timeout: timeout)
        
        let newCount = hitTableView.cells.count
        XCTAssertTrue(oldCount < newCount)
    }

}
