//
//  CategoryType.swift
//  Xpense
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

enum CategoryType: String, CaseIterable {
    case groceries
    case bills
    case restaurant
    case gambling
    case clothing
    case furniture
    
    var defaultName: String {
        rawValue.capitalized
    }
    
    var defaultHexColor: String {
        switch self {
        case .groceries:
            return "#0367f5"
        case .bills:
            return "#0000FF"
        case .restaurant:
            return "#083942"
        case .gambling:
            return "#00FFFF"
        case .clothing:
            return "#FF00FF"
        case .furniture:
            return "#C0C0C0"
        }
    }
    
    var defaultColor: UIColor? {
        UIColor(hex: defaultHexColor)
    }
}
