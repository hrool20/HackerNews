//
//  UIResponderExtension.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

extension UIResponder: LoaderHandlerProtocol {
    static var NIBName: String {
        return String(describing: self)
    }
    
    // MARK: - LoaderHandlerProtocol
    
    var isLoaderVisible: Bool {
        get { return LoaderView.isVisible }
    }
    
    func endLoader() {
        let loaderView = findLoader()
        loaderView?.hide()
    }
    
    func startLoader(message: String) {
        if LoaderView.isVisible, let loaderView = findLoader() {
            loaderView.loadViews(message: message, animation: true)
        } else {
            let window = UIApplication.shared.keyWindow
            let loaderView = LoaderView(message: message)
            DispatchQueue.main.async {
                window?.addSubview(loaderView)
                window?.bringSubviewToFront(loaderView)
            }
        }
    }
    
    private func findLoader() -> LoaderView? {
        let window = UIApplication.shared.keyWindow
        return window?.subviews.first(where: { (view) -> Bool in
            return view.self is LoaderView
        }) as? LoaderView
    }
}
