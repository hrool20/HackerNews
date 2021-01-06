//
//  Router.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

final class Router {
    static let shared: Router = Router()
    
    init() {
    }
    
    func getSplashScene() -> UIViewController {
        let viewController = SplashViewController.get()
        return viewController
    }
    
    func getMainWebview(title: String?, url: String) -> UIViewController {
        let viewController = MainWebviewViewController.get()
        viewController.navigationTitle = title
        viewController.url = url
        return viewController
    }
}
