//
//  CategoryService.swift
//  Xpense
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

protocol CategoryServiceProtocol {
    
    /// Fetch all categories sorted by name.
    /// - Note: Will create default ones if none is found.
    func fetchCategories() -> [Category]
    
    /// Saves or updates a category
    /// - Parameter category: the category to be saved.
    func save(category: Category)
}

final class CategoryService: CategoryServiceProtocol {
    
    private let databaseService: DatabaseServiceProtocol
    
    init(databaseService: DatabaseServiceProtocol = DI.databaseService) {
        self.databaseService = databaseService
    }
    
    func fetchCategories() -> [Category] {
        var categories = databaseService.fetchCategories()
        if categories.isEmpty {
            Log.message("Creating and storing default categories...", level: .info, type: .category)
            defaultCategories().forEach { [weak self] in
                self?.databaseService.saveCategory($0)
            }
            categories = databaseService.fetchCategories()
        }
        return categories.sorted(by: { $0.name < $1.name })
    }
    
    func save(category: Category) {
        databaseService.saveCategory(category)
    }
}

// MARK: - Private

private extension CategoryService {
    
    func defaultCategories() -> [Category] {
        [CategoryMock.sampleBills, CategoryMock.sampleGroceries, CategoryMock.sampleClothing,
         CategoryMock.sampleGambling, CategoryMock.sampleFurniture, CategoryMock.sampleRestaurant]
    }
}
