//
//  UIColor+PrincipalColors.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/7/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

extension UIColor {
    class var accentColor: UIColor? {
        return UIColor(named: "ColorAccent")
    }
    
    class var backgroundColor: UIColor? {
        return UIColor(named: "ColorBackground")
    }
    
    class var loaderBackgroundColor: UIColor? {
        return UIColor(named: "ColorLoaderBackground")
    }
    
    class var primaryColor: UIColor? {
        return UIColor(named: "ColorPrimary")
    }
    
    class var primaryLightColor: UIColor? {
        return UIColor(named: "ColorPrimaryLight")
    }
    
    class var textColor: UIColor? {
        return UIColor(named: "ColorText")
    }
    
    class var textLightColor: UIColor? {
        return UIColor(named: "ColorTextLight")
    }
}
