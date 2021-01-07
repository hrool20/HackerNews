//
//  DateFormatterHandler.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import Foundation

final class DateFormatterHandler {
    static let shared = DateFormatterHandler()
    private var dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
    }
    
    func date(from string: String, withFormat dateFormat: String? = nil) -> Date? {
        if let dateFormat = dateFormat {
            dateFormatter.dateFormat = dateFormat
        } else {
            dateFormatter.dateStyle = .full
        }
        return dateFormatter.date(from: string)
    }
    
    func string(from date: Date, withFormat dateFormat: String) -> String {
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
}
