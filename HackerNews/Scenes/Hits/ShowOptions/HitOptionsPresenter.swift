//
//  HitOptionsPresenter.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

final class HitOptionsPresenter: HitOptionsPresenterProtocol {
    private let userDefaultsHandler: UserDefaultsHandlerProtocol
    private let generalRepository: GeneralRepositoryProtocol
    private let view: HitOptionsTableViewControllerProtocol
    
    init(userDefaultsHandler: UserDefaultsHandlerProtocol, generalRepository: GeneralRepositoryProtocol, view: HitOptionsTableViewControllerProtocol) {
        self.userDefaultsHandler = userDefaultsHandler
        self.generalRepository = generalRepository
        self.view = view
    }
    
    func loadHits(orderedBy order: HitOrder) {
        generalRepository.getHits(orderedBy: order, success: { [weak self] (hits) in
            guard let self = self else { return }
            let deletedHits = self.userDefaultsHandler.array(from: Constants.Keys.DELETED_HIT_IDS) ?? []
            let newHits = hits.compactMap { (hit) -> Hit? in
                guard !deletedHits.contains(hit.parentId) else { return nil }
                return hit
            }
            self.view.updateHits(newHits)
        }) { [weak self] (error) in
            self?.view.showMessage(message: error.localizedDescription)
        }
    }
    
    func saveDeletedHit(hit: Hit) {
        var deletedHits = userDefaultsHandler.array(from: Constants.Keys.DELETED_HIT_IDS) ?? []
        guard deletedHits.first(where: { (id) -> Bool in
            return id == hit.parentId
        }) == nil else {
            return
        }
        deletedHits.append(hit.parentId)
        userDefaultsHandler.save(value: deletedHits, to: Constants.Keys.DELETED_HIT_IDS)
    }
}
