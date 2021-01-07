//
//  HitOptionsTableViewControllerProtocol.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

protocol HitOptionsTableViewControllerProtocol: PopupHandlerProtocol {
    func updateHits(_ hits: [Hit])
}
