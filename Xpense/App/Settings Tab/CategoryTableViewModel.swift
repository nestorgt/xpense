//
//  CategoryTableViewModel.swift
//  Xpense
//
//  Created by Nestor Garcia on 22/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

final class CategoryTableViewModel {
    
    private let categories = Category.allCases
    
    var screentTitle: String { NSLocalizedString("category-listing-tab-title") }
    
    // MARK: - Table
    
    var numberOfSections: Int {
        Self.Section.allCases.count
    }
    
    func nameForSection(_ section: Int) -> String {
        let sections = Section.allCases
        guard sections.indices.contains(section) else { return "" }
        return Section.allCases[section].title
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        switch section {
        case Self.Section.categories.rawValue:
            return categories.count
        default:
            return 0
        }
    }
    
    func color(for index: Int) -> UIColor? {
        category(for: index)?.defaultColor
    }
    
    func hexColor(for index: Int) -> String? {
        color(for: index)?.toHex
    }
    
    func name(for index: Int) -> String? {
        category(for: index)?.defaultName
    }
    
    // MARK: - Alert
    
    var alertTitle: String { NSLocalizedString("alert-category-title") }
    var alertDescription: String { NSLocalizedString("alert-category-description") }
    var alertHexPlaceholder: String { NSLocalizedString("alert-category-hex-placeholder") }
    var alertNamePlaceholder: String { NSLocalizedString("alert-category-name-placeholder") }
    
    // MARK: - User input
    
    /// Returns true if the new value was stored.
    func didEnter(nameString: String?, hexString: String?, forIndex index: Int) -> Bool {
        Log.message("User entry: \(nameString ?? "<nil>") - \(hexString ?? "<nil>")",
            level: .info, category: .category)
        
        let nameCheck = isNameValid(nameString: nameString) && name(for: index) != nameString
        Log.message("User entry name: \(nameString ?? "<nil>") -> \(nameCheck ? "👍" : "👎")",
            level: .info, category: .category)
        
        let colorCheck = isHexValid(hexString: hexString) && hexColor(for: index) != hexString?.uppercased()
        Log.message("User entry color: \(hexString ?? "<nil>") -> \(colorCheck ? "👍" : "👎")",
            level: .info, category: .category)
        
        return nameCheck || colorCheck
        // TODO: save color on db
    }
}

// MARK: - Private

private extension CategoryTableViewModel {
    
    enum Section: Int, CaseIterable {
        case categories
        
        var title: String {
            switch self {
            case .categories:
                return "Categories"
            }
        }
    }
    
    func category(for index: Int) -> Category? {
        guard categories.indices.contains(index) else { return nil }
        return categories[index]
    }
    
    func isHexValid(hexString: String?) -> Bool {
        let newHex = hexString?.uppercased()
        let newColor = UIColor(hex: newHex ?? "")
        return newColor != nil
    }
    
    func isNameValid(nameString: String?) -> Bool {
        nameString?.count ?? 0 > 3
    }
}
