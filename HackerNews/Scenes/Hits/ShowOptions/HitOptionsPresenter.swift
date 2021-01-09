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
    
    func calculateDateDifference(date: Date?) -> String {
        var result = "0s"
        guard let date = date else {
            return result
        }
        let now = Date()
        let order = date.compare(now)
        switch order {
        case .orderedAscending:
            let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: date, to: now)
            if let days = dateComponents.day, days != 0 {
                result = "\(days)d"
            }else if let hours = dateComponents.hour, hours != 0 {
                result = "\(hours)h"
            } else if let minutes = dateComponents.minute, minutes != 0 {
                result = "\(minutes)m"
            } else {
                result = "\(dateComponents.second ?? 0)s"
            }
        default:
            break
        }
        return result
    }
    
    func loadHits(orderedBy order: HitOrder, isAnUpdate: Bool) {
        if !isAnUpdate {
            view.startLoader()
        }
        
        generalRepository.getHits(orderedBy: order, success: { [weak self] (hits) in
            guard let self = self else { return }
            if !isAnUpdate {
                self.view.endLoader()
            }
            
            let deletedHits = self.userDefaultsHandler.array(from: Constants.Keys.DELETED_HIT_IDS) ?? []
            let newHits = hits.compactMap { (hit) -> Hit? in
                guard !deletedHits.contains(hit.parentId) else { return nil }
                return hit
            }
            self.updateNavigationBar()
            self.view.updateHits(newHits)
        }) { [weak self] (error) in
            if !isAnUpdate {
                self?.view.endLoader()
            }
            self?.view.endRefreshControl()
            self?.view.showMessage(message: error.localizedDescription)
        }
    }
    
    func removeDeletedHits() {
        userDefaultsHandler.remove(from: Constants.Keys.DELETED_HIT_IDS)
        userDefaultsHandler.remove(from: Constants.Keys.IS_SOME_HIT_DELETED)
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
        userDefaultsHandler.save(value: true, to: Constants.Keys.IS_SOME_HIT_DELETED)
        updateNavigationBar()
    }
    
    func updateNavigationBar() {
        let shouldShowRightItems = userDefaultsHandler.bool(from: Constants.Keys.IS_SOME_HIT_DELETED)
        view.updateNavigationBar(shouldShowRightItems)
    }
}
