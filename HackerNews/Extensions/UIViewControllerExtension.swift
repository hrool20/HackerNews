//
//  UIViewControllerExtension.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

extension UIViewController {
    static func get(with bundle: Bundle? = nil) -> Self {
        return Self(nibName: NIBName, bundle: bundle)
    }
}
