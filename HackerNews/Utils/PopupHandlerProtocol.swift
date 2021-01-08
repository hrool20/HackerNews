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
    func showQuestion(title: String, message: String, yes yesTitle: String?, no noTitle: String?, closure: @escaping((Bool) -> Void))
}
extension PopupHandlerProtocol {
    func showMessage(message: String, closure: (() -> Void)? = nil) {
        showMessage(title: nil, message: message) {
            closure?()
        }
    }
    
    func showQuestion(title: String, message: String, closure: ((Bool) -> Void)?) {
        showQuestion(title: title, message: message, yes: nil, no: nil) { (isSuccessful) in
            closure?(isSuccessful)
        }
    }
    
    func showQuestion(title: String, message: String, yes yesTitle: String?, no noTitle: String?) {
        showQuestion(title: title, message: message, yes: yesTitle, no: noTitle) { (_) in
        }
    }
}
