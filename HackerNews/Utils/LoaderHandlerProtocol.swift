//
//  LoaderHandlerProtocol.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/8/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import Foundation

protocol LoaderHandlerProtocol {
    var isLoaderVisible: Bool { get }
    func endLoader()
    func startLoader(message: String)
}
extension LoaderHandlerProtocol {
    func startLoader() {
        startLoader(message: Constants.Localizable.DEFAULT_LOADER)
    }
}
