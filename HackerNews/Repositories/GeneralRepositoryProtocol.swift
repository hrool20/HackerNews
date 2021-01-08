//
//  GeneralRepositoryProtocol.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import Foundation

enum HitOrder: Int {
    case ascendant
    case descendant
}

protocol GeneralRepositoryProtocol {
    func getHits(orderedBy order: HitOrder?, success: @escaping([Hit]) -> Void, failure: @escaping(Error) -> Void)
}
