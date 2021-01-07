//
//  HitOptionsPresenter.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

final class HitOptionsPresenter: HitOptionsPresenterProtocol {
    private let generalRepository: GeneralRepositoryProtocol
    private let view: HitOptionsTableViewControllerProtocol
    
    init(generalRepository: GeneralRepositoryProtocol, view: HitOptionsTableViewControllerProtocol) {
        self.generalRepository = generalRepository
        self.view = view
    }
    
    func loadHits(orderedBy order: HitOrder) {
        generalRepository.getHits(orderedBy: order, success: { [weak self] (hits) in
            guard let self = self else { return }
            self.view.updateHits(hits)
        }) { [weak self] (error) in
            self?.view.showMessage(message: error.localizedDescription)
        }
    }
}
