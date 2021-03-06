//
//  HitOptionsPresenterProtocol.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

protocol HitOptionsPresenterProtocol {
    func calculateDateDifference(date: Date?) -> String
    func loadHits(orderedBy order: HitOrder, isAnUpdate: Bool)
    func removeDeletedHits()
    func saveDeletedHit(hit: Hit)
    func updateNavigationBar()
}
