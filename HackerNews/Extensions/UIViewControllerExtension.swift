//
//  UIViewControllerExtension.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

extension UIViewController: PopupHandlerProtocol {
    static func get(with bundle: Bundle? = nil) -> Self {
        return Self(nibName: NIBName, bundle: bundle)
    }
    
    // MARK: PopupHandlerProtocol
    
    func showMessage(title: String?, message: String, closure: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: title ?? Constants.Localizable.APP_NAME, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.Localizable.OK, style: .default) { (_) in
            closure()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
