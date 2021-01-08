//
//  PrincipalNavigationController.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/7/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

class PrincipalNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.tintColor = .accentColor ?? .white
        navigationBar.barTintColor = .backgroundColor ?? .white
        navigationBar.barStyle = .default
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard viewControllers.count > 0 else {
            super.pushViewController(viewController, animated: animated)
            return
        }
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        viewControllers[viewControllers.count - 1].navigationItem.backBarButtonItem = backButton
        super.pushViewController(viewController, animated: animated)
    }
    
}
