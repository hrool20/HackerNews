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
        loaderView?.hide(force: false)
    }
    
    func startLoader(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let oldLoaderView = self.findLoader()
            guard self.isLoaderVisible, let loaderView = oldLoaderView else {
                oldLoaderView?.hide(force: true)
                let window = UIApplication.shared.keyWindow
                let loaderView = LoaderView(message: message)
                window?.addSubview(loaderView)
                window?.bringSubviewToFront(loaderView)
                return
            }
            loaderView.loadViews(message: message, animation: true)
        }
    }
    
    private func findLoader() -> LoaderView? {
        let window = UIApplication.shared.keyWindow
        return window?.subviews.first(where: { (view) -> Bool in
            return view.self is LoaderView
        }) as? LoaderView
    }
}
