//
//  PopupHandlerProtocol.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import Foundation

protocol PopupHandlerProtocol {
    func showMessage(title: String?, message: String, closure: @escaping(() -> Void))
}
extension PopupHandlerProtocol {
    func showMessage(message: String, closure: (() -> Void)? = nil) {
        showMessage(title: nil, message: message) {
            closure?()
        }
    }
}
