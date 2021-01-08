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
    
    // MARK: - PopupHandlerProtocol
    
    func showMessage(title: String?, message: String, closure: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: title ?? Constants.Localizable.APP_NAME, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.Localizable.OK, style: .default) { (_) in
            closure()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showQuestion(title: String, message: String, yes yesTitle: String?, no noTitle: String?, closure: @escaping ((Bool) -> Void)) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: yesTitle ?? Constants.Localizable.YES, style: .destructive) { (_) in
            closure(true)
        }
        let noAction = UIAlertAction(title: noTitle ?? Constants.Localizable.NO, style: .default) { (_) in
            closure(false)
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        alertController.preferredAction = noAction
        present(alertController, animated: true, completion: nil)
    }
}
