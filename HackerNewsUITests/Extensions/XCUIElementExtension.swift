//
//  XCUIElementExtension.swift
//  HackerNewsUITests
//
//  Created by Hugo Rosado on 1/8/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import XCTest

extension XCUIElement {
    enum SwipeDirection {
        case left
        case right
    }
    
    func longSwipe(_ direction : SwipeDirection) {
        let startOffset: CGVector
        let endOffset: CGVector
        
        switch direction {
        case .right:
            startOffset = CGVector.zero
            endOffset = CGVector(dx: 0.8, dy: 0.5)
        case .left:
            startOffset = CGVector(dx: 0.8, dy: 0.5)
            endOffset = CGVector.zero
        }
        
        let startPoint = coordinate(withNormalizedOffset: startOffset)
        let endPoint = coordinate(withNormalizedOffset: endOffset)
        startPoint.press(forDuration: 0.1, thenDragTo: endPoint)
    }
}
