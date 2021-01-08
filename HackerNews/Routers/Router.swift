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
    // Handlers
    private let userDefaultsHandler: UserDefaultsHandlerProtocol
    // Repositories
    private let generalRepository: GeneralRepositoryProtocol
    
    init() {
        userDefaultsHandler = UserDefaultsHandler()
        generalRepository = GeneralRepository()
    }
    
    func getHitOptions() -> UIViewController {
        let viewController = HitOptionsTableViewController.get()
        viewController.hitsPresenter = HitOptionsPresenter(userDefaultsHandler: userDefaultsHandler, generalRepository: generalRepository, view: viewController)
        return viewController
    }
    
    func getMainWebview(title: String?, url: String) -> UIViewController {
        let viewController = MainWebviewViewController.get()
        viewController.navigationTitle = title
        viewController.url = url
        return viewController
    }
    
    func getSplashScene() -> UIViewController {
        let viewController = SplashViewController.get()
        viewController.splashPresenter = SplashPresenter(view: viewController)
        return viewController
    }
}
