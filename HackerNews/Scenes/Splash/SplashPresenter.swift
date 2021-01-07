//
//  SplashPresenter.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

final class SplashPresenter: SplashPresenterProtocol {
    private let view: SplashViewControllerProtocol
    
    init(view: SplashViewControllerProtocol) {
        self.view = view
    }
    
    func startAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            self?.view.goToHitOptions()
        }
    }
}
