//
//  UIImageExtension.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/8/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
    
    func resizeWithoutAdjustImage(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
