//
//  Date+.swift
//  Xpense
//
//  Created by Nestor Garcia on 20/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

extension Date {
    
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    static func date(from dateString: String, withFormat format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let date = formatter.date(from: dateString)
        return date
    }
}
