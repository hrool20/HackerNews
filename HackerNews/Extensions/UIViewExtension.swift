//
//  UIViewExtension.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

extension UIView {
    static func getNIB() -> UINib {
        return UINib(nibName: NIBName, bundle: nil)
    }
}
